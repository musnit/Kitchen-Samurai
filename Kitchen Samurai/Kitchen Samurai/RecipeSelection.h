//
//  RecipeSelection.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/04/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class Kitchen_SamuraiAppDelegate;


@interface RecipeSelection : UIViewController {
    UIImageView *Lock;
    UIImageView *rating;
    UITextView *DetailedTextView;
    UILabel *DetailedDifficulty;
    UIImageView *DetailedStars;
    UILabel *DetailedTitle;
    NSMutableDictionary* recipeList;
    NSMutableArray* starsArray;
    BOOL* DetailedViewOpen;
    UIView *DetailedView;
    NSString* DataPath;
    NSMutableDictionary* chosenRecipe;
    AVAudioPlayer* soundEffect;

    NSUserDefaults *prefs;


}
- (void)loadRecipeList;
- (void) createLabels;
- (void) createButtons;
- (UILabel *)getLabelAtIndex:(NSInteger)index;
- (UIButton *)getButtonAtIndex:(NSInteger)index;
- (UIImageView *)getImageAtIndex:(NSInteger)index;
- (UITextView *)getTextViewAtIndex:(NSInteger)index;
- (void)saveGameState:(int)r forLevel:(int)l;
- (int)getRating:(int)l;
- (IBAction)goBack:(id)sender;
- (IBAction)close:(id)sender;
- (IBAction)getRecipe:(id)sender;
@property (nonatomic, retain) Kitchen_SamuraiAppDelegate *appDelegate;
@property (nonatomic, retain) IBOutlet UIView *DetailedView;
@property (nonatomic, retain) IBOutlet UIImageView *Lock;
@property (nonatomic, retain) IBOutlet UIImageView *rating;
@property (nonatomic, retain) IBOutlet UITextView *DetailedTextView;
@property (nonatomic, retain) IBOutlet UILabel *DetailedDifficulty;
@property (nonatomic, retain) IBOutlet UIImageView *DetailedStars;
@property (nonatomic, retain) IBOutlet UILabel *DetailedTitle;



@end
