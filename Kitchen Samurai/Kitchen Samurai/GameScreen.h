//
//  GameScreen.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwipeGestureRecognizer.h"

@class Kitchen_SamuraiAppDelegate;
@class Game;
@class Ingredient;
@class CATransition;

@interface GameScreen : UIViewController <UIGestureRecognizerDelegate> {
    UILongPressGestureRecognizer *drag;
    UILongPressGestureRecognizer *tempSwipe;
    NSArray *timerpics;
    UIButton *quitButton;
    UIView *ingredientCountersView;
    UIView *EndGameView;
    UIButton *pauseButton;
    UIImageView *chef1;
    UIImageView *chef2;
    UIButton *nextButton;
    UIImageView *chef3;
    int mistakes;
    UIImageView *starsImage;
    UIButton *retryButton;
    CGFloat* fingerVelocities;
    CGPoint lastFingerPosition;
    CFTimeInterval lastFingerTime;
    
    UIImage *dot;
    UIImage *pause;
    UIImage *play;
    
    UIFont *baarMetLarge;
    UIFont *baarMetSmall;
    UIFont *baarMetXLarge;
    
    int dotCounter; // dot index used to get UIImageView from pool instead of creating one
    NSMutableArray *dotImageViews;
    UILabel *timeLabel;
    UILabel *endGameLabel;
}

@property (nonatomic, retain) Kitchen_SamuraiAppDelegate *appDelegate;
@property (nonatomic, retain) Game *game;
@property (nonatomic, retain) NSMutableDictionary* progressImageDictionary;
@property (nonatomic, retain) NSMutableDictionary* numberImageDictionary;

- (IBAction)quitGameButtonClicked:(id)sender;
- (IBAction)pauseGameButtonClicked:(id)sender;
- (IBAction)nextRecipe:(id)sender;
- (IBAction)mainMenuButton:(id)sender;
- (void)performSwipe:(id)sender;
- (void)dragPot:(id)sender;
-(UIImageView*)addIngredientToView:(Ingredient *)i;
-(UIImageView*)addPotToView:(PhysicalObject *)p;
- (void)addProgressFrame;
- (void)resetGameScreen;
- (void) mistake;
- (void) updateTimerMinutes:(int) minutes andSeconds:(int) seconds;
- (IBAction)retry:(id)sender;
- (void) updateProgressFrame:(int) i;
- (void)saveGameState:(int)r forLevel:(int)l;
- (void) endGame:(BOOL)win:(int)score:(int)level;
- (void) enableGestureRecognizers:(BOOL)enable;

@property (nonatomic, retain) IBOutlet UILabel *endGameLabel;

@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UIButton *quitButton;
@property (nonatomic, retain) IBOutlet UIView *ingredientCountersView;
@property (nonatomic, retain) IBOutlet UIView *EndGameView;
@property (nonatomic, retain) IBOutlet UIButton *pauseButton;
@property (nonatomic, retain) IBOutlet UIImageView *chef1;
@property (nonatomic, retain) IBOutlet UIImageView *chef2;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) IBOutlet UIImageView *chef3;
@property (nonatomic) int mistakes;
@property (nonatomic, retain) IBOutlet UIImageView *starsImage;
@property (nonatomic, retain) IBOutlet UIButton *retryButton;
@property (nonatomic, retain) UIImage* play;
@property (nonatomic, retain) UIImage* pause;
@property (nonatomic, retain) UILongPressGestureRecognizer* tempSwipe;
@property (nonatomic, retain) UILongPressGestureRecognizer* drag;


@end
