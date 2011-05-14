//
//  Game.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/05.
//  Copyright 2011 University of Cape Town. All rights reserved.
//

#import "Game.h"
#import "GameScreen.h"
#import "Ingredient.h"
#import "IngredientGenerator.h"

@implementation Game

float lastTimeStamp = -1;
float prevTime;

@synthesize isPaused;
@synthesize viewController;
@synthesize displayLink;
@synthesize ingredientsOnScreen;
@synthesize ingredientsLeft;
@synthesize generator;
@synthesize pot;
@synthesize difficulty;

- (id)init
{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop:)];
    [self.displayLink setFrameInterval:1];
    prevTime = [self.displayLink timestamp];
    return self;
}

-(void)catchIngredient:(Ingredient*)i{
    NSString* keyString = [NSString stringWithFormat:@"%i",i.ingredientType];
    int currentAmount = [[ingredientsLeft valueForKey:keyString] intValue];
    if(currentAmount==0){
        //do nothing for now, could punish them
        [viewController mistake];
    }
    else{
        //[soundEffect play];
        
        currentAmount--;
        NSNumber* newAmount=[NSNumber numberWithInt:currentAmount];
<<<<<<< HEAD
        NSLog(@"%i",[[ingredientsLeft valueForKey:keyString] intValue]);
=======
>>>>>>> 0e02c6d42f9aea0eae0dd294bac712abc286e45f
        [ingredientsLeft setValue:newAmount forKey:keyString];
        [viewController updateProgressFrame:i.ingredientType];
        number--;
        NSLog(@"Ingredients left : %i",number);
        if (number == 0)
        {
            NSLog(@"GAME Finished Well Done");
            [viewController endGame];
        }
    }
    if (currentAmount==0){
        [ingredientsLeft removeObjectForKey:keyString];
    }

}


// initialise game with saved datas
- (void)startGame: (NSDictionary*) recipe
{
    NSLog(@"Starting game...");
    ingredientsOnScreen=[[NSMutableArray alloc] init];
    ingredientsLeft = [recipe valueForKey:@"Ingredients"];
<<<<<<< HEAD
    number = [[recipe valueForKey:@"NumberIngredients"] intValue];
    self.generator = [[IngredientGenerator alloc] initWithRecipe:ingredientsLeft];
=======
    difficulty = [recipe valueForKey:@"Difficulty"];
    self.generator = [[IngredientGenerator alloc] initForGame:self];
>>>>>>> 0e02c6d42f9aea0eae0dd294bac712abc286e45f
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [viewController addProgressFrame];
    // add the pot
    self.pot = [[PhysicalObject alloc] init:512 :64 :0 :0 :64];
    pot.imageView = [viewController addPotToView:pot];
    
    //soundEffect = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"swoosh" ofType:@"caf"]] error:nil]; 
    
    prevTime=0;
}

- (void)endGame
{
    [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [ingredientsOnScreen release];   //kill all ingredients and array
    [pot release];
}

- (void)pauseOrResumeGame
{
    if(self.isPaused == NO){
        self.isPaused = YES;
        [self.displayLink setPaused:YES];
    }
    else{
        self.isPaused = NO;
        prevTime = [self.displayLink timestamp];
        [self.displayLink setPaused:NO];
    }
}


- (void)gameLoop:(CADisplayLink *)sender
{
    // calculate time step
    float time = [sender timestamp]-prevTime;
    prevTime = [sender timestamp];
   // NSLog(@"%f",time);//[sender timestamp]);
    //make sure no bugs in physics/generator on first loop cal when prevTime has not been set.
    
    //generate ingredient
    Ingredient*i=[generator giveIngredient];
    if(i!=nil){
        [ingredientsOnScreen addObject:i];
        i.imageView = [viewController addIngredientToView:i];
    }

    [self moveAndCatchIngredients: time];
    
    //[viewController.view setNeedsDisplay];
}

-(void) moveAndCatchIngredients:(float) timepassed{
    // objects are added to this array when they need to be released (can't alter array when using a foreach-type loop)
    NSMutableArray* toBeRemoved = [[NSMutableArray alloc] init];
    
    for(Ingredient* ingredient in ingredientsOnScreen){
        //NSLog(@"%i",[ingredients count]);
        if ([ingredient isOffscreen])
            [toBeRemoved addObject:ingredient];
        else
        {
            [ingredient updatePosition:timepassed]; //check that this is timesincelastframe
            
            // check for collision with pot
            if (ingredient.isCut && ingredient.yVel < 0 && ingredient.yPos < 144 && ingredient.yPos > 128)
            {
                if (ingredient.xPos > pot.xPos-64 && ingredient.xPos < pot.xPos+64)
                {
                    [toBeRemoved addObject:ingredient];
                    [self catchIngredient:ingredient];
                }
            }
        }
    }
    
    // remove objects that aren't visible
    for(Ingredient* offscreen in toBeRemoved)
    {
        [ingredientsOnScreen removeObject:offscreen];
    }
    [toBeRemoved release]; //this calls release on all objects in the array too
}

- (void)dealloc
{
    [self.displayLink release];
    [super dealloc];
}

@end
