//
//  GameScreen.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScreen.h"
#import "Kitchen_SamuraiAppDelegate.h"
#import "Game.h"
#import "GameView.h"
#import "PhysicalObject.h"
#import "Ingredient.h"

@implementation GameScreen
@synthesize quitButton;
@synthesize ingredientCountersView;
@synthesize EndGameView;

@synthesize appDelegate;
@synthesize game;

@synthesize numberImageDictionary;
@synthesize progressImageDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)performSwipe:(id)sender
{
    CGPoint touchPoint = [((UILongPressGestureRecognizer*)sender) locationInView:tempSwipe.view];
    for (Ingredient* i in game.ingredientsOnScreen)
    {
        if (CGRectContainsPoint(i.imageView.frame, touchPoint)){
            i.isCut = true;
        }
    }
}

- (void) updateProgressFrame:(int) type{
    int numLeft = [[game.ingredientsLeft valueForKey:[NSString stringWithFormat:@"%i",type]] intValue];
    UIImageView* numberimage = [numberImageDictionary valueForKey:[NSString stringWithFormat:@"%i",type]];
    //NSLog(@"%i",numLeft);
    if (numLeft==0){
        [numberimage removeFromSuperview];
        UIImageView* image = [progressImageDictionary valueForKey:[NSString stringWithFormat:@"%i",type]];
        UIImageView* crossOutImage = [[UIImageView alloc] initWithImage: [((GameView*)self.view).numberImages objectAtIndex:numLeft]];
        [crossOutImage setFrame:CGRectMake(0, 0, image.image.size.width * 0.5f, image.image.size.height * 0.5f)];
        [crossOutImage setContentMode:UIViewContentModeScaleToFill];

        [image addSubview:crossOutImage];
        [crossOutImage release];
    }
    else{
        [numberimage setImage:[((GameView*)self.view).numberImages objectAtIndex:numLeft]];
    }
}

- (void)dragPot:(id)sender
{
    CGPoint touchPoint =  [drag locationOfTouch:0 inView:drag.view];
    game.pot.xPos = touchPoint.x;
    [game.pot.imageView setCenter:CGPointMake(game.pot.xPos, 768 - game.pot.yPos)];
}

- (void)dealloc
{
    [appDelegate release];
    [game release];
    [quitButton release];
    [ingredientCountersView release];
    [EndGameView release];
    [super dealloc];
}

-(void)quitGameButtonClicked:(id)sender{
    [game endGame];
    [self.appDelegate switchToMenu];
}

-(void)pauseGameButtonClicked:(id)sender{
    [game pauseOrResumeGame];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)addProgressFrame 
{
    //Draw topleft window
    float x=16;
    float y=16;
    progressImageDictionary = [[NSMutableDictionary alloc] init];
    numberImageDictionary = [[NSMutableDictionary alloc] init];

    for(id type in game.ingredientsLeft)
    {
        NSNumber* number = [game.ingredientsLeft valueForKey:type];
        UIImageView* image = [[UIImageView alloc] initWithImage: [((GameView*)self.view).ingredientImages objectAtIndex:[type intValue]]];
        [image setCenter:CGPointMake(x,y)];
        UIImageView* numberimage = [[UIImageView alloc] initWithImage:[((GameView*)self.view).numberImages objectAtIndex:[number intValue]]];
        /*if([number intValue]==0){
            [numberimage setCenter:CGPointMake(x,y)];
        }
        else{
            [numberimage setCenter:CGPointMake(x+100,y)];
        }*/
        [image setFrame:CGRectMake(x, y, image.image.size.width * 0.5f, image.image.size.height * 0.5f)];
        [image setContentMode:UIViewContentModeScaleToFill];
        [ingredientCountersView addSubview:image];
        [numberimage setFrame:CGRectMake(x+64, image.center.y-numberimage.image.size.height * 0.4f, numberimage.image.size.width * 0.8f, numberimage.image.size.height * 0.8f)];
        [numberimage setContentMode:UIViewContentModeScaleToFill];
        [ingredientCountersView addSubview:numberimage];
        [progressImageDictionary setValue:image forKey:type];
    //    UIView* test = [progressImageDictionary valueForKey:[number stringValue]];
        [numberImageDictionary setValue:numberimage forKey:type];
        [image release];
        [numberimage release];
        y+=image.frame.size.height + 16;
    }
}

- (void) mistake
{
    mistakes++;
    UIImageView *chef = [[UIImageView alloc] init];
    chef.frame = CGRectMake(10+35*mistakes,300 ,30, 60);
    [chef setBackgroundColor:[UIColor clearColor]];
    [chef setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_chef",mistakes]]];
    [ingredientCountersView addSubview:chef];
}

- (void) endGame
{
    EndGameView.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    GameView *gameView = ((GameView*)self.view);
    [gameView setGameModel:game];
    [gameView initIngredientImages];
    
    mistakes = 0;
    
    /*// Set up swipe gesture recognizers
    swipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(performSwipe:)];
    [swipe1 setDelegate:self];
    [swipe1 setNumberOfTouchesRequired:1];
    [swipe1 setDirection:(UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionUp)];
    [gameView addGestureRecognizer:swipe1];
    [swipe1 release];*/
    tempSwipe = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(performSwipe:)];
    [tempSwipe setDelegate:self];
    [tempSwipe setNumberOfTouchesRequired:1];
    [tempSwipe setAllowableMovement:INFINITY];
    [tempSwipe setMinimumPressDuration:0];
    [tempSwipe setNumberOfTapsRequired:0];
    [gameView addGestureRecognizer:tempSwipe];
    
    // Set up drag gesture recognizer
    drag = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(dragPot:)];
    [drag setDelegate:self];
    [drag setAllowableMovement:INFINITY];
    [drag setMinimumPressDuration:0];
    [drag setNumberOfTouchesRequired:1];
    [drag setNumberOfTapsRequired:0];
    [drag setCancelsTouchesInView:YES];
    [gameView addGestureRecognizer:drag];
   // [gameView release]; shouln't be here? there was no extra retain, self.view doesn't do a retain? doing this makes exit game/start again not work anymore
}

- (void)viewDidUnload
{
    [self setQuitButton:nil];
    [self setIngredientCountersView:nil];
    [self setEndGameView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

// UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    /*if (gestureRecognizer==drag)
    {
        CGRect pot = CGRectMake(game.pot.xPos-75, 768-game.pot.yPos-70, 150, 140);
        CGPoint touch = [gestureRecognizer locationInView:self.view];
        if (CGRectContainsPoint(pot, touch))
            return YES;
        else
            return NO;
    }
    else
        return YES;*/
    CGRect pot = CGRectMake(game.pot.xPos-75, 768-game.pot.yPos-70, 150, 140);
    CGPoint touch = [gestureRecognizer locationInView:self.view];
    if (CGRectContainsPoint(pot, touch))
        if (gestureRecognizer==drag)
            return YES;
        else
            return NO;
    else
        if (gestureRecognizer==tempSwipe)
            return YES;
        else
            return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (CGRectContainsPoint(quitButton.frame, [touch locationInView:self.view]))
        return NO;
    else
        return YES;
}

-(UIImageView*)addIngredientToView:(Ingredient *)i
{
    GameView* gameView = (GameView*)self.view;
    UIImage* image = [gameView.ingredientImages objectAtIndex:(int)i.ingredientType];
    UIImageView *imageView = [ [ UIImageView alloc ] initWithFrame:CGRectMake(i.xPos-image.size.width/2, 768 - i.yPos-image.size.height/2, image.size.width, image.size.height)];
    imageView.image = image;
    [gameView insertSubview:imageView belowSubview:ingredientCountersView];
    [image release];
    [imageView autorelease];
    return imageView;
}

-(UIImageView*)addPotToView:(PhysicalObject *)p
{
    GameView* gameView = (GameView*)self.view;
    UIImage* image = gameView.pot;
    UIImageView *imageView = [ [ UIImageView alloc ] initWithFrame:CGRectMake(p.xPos-image.size.width/2, 768 - p.yPos-image.size.height/2, image.size.width, image.size.height)];
    imageView.image = image;
    [gameView addSubview:imageView];
    [image release];
    [imageView autorelease];
    return imageView;
}

@end
