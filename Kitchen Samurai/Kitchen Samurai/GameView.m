//
//  GameView.m
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"
#import "Ingredient.h"
#import "Game.h"

@implementation GameView

NSString * const ingredientTypeToFileName[] = {
    @"asparagus.png",
    @"baby_marrow.png",
    @"bean.png",
    @"beetroot.png",
    @"bell_pepper.png",
    @"brinjal.png",
    @"broccoli.png",
    @"butternut.png",
    @"carrot.png",
    @"cauliflower.png",
    @"celery.png",
    @"chilli.png",
    @"corn.png",
    @"garlic.png",
    @"lemon.png",
    @"onion.png",
    @"parsnip.png",
    @"peas.png",
    @"potato.png",
    @"pumpkin.png",
    @"tomato.png",
    @"turnip.png"
};

@synthesize gameModel;
@synthesize ingredientImages;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initIngredientImages
{
    // set up all the ingredient images here
    NSLog(@"initializing ingredient images...");
    ingredientImages = [[NSMutableArray alloc] initWithCapacity:22];
    for (int i = 0; i < 22; i++)
    {
        UIImage* image = [UIImage imageNamed:ingredientTypeToFileName[i]];
        [ingredientImages addObject:image];
        [image release];
    }
    
    // set up the pot images
    pot_bottom = [UIImage imageNamed:@"pot.png"];
    pot_top = [UIImage imageNamed:@"pot_top.png"];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    for(Ingredient* i in gameModel.ingredientsOnScreen)
    {
        UIImage* image = [ingredientImages objectAtIndex:(int)i.ingredientType];
        //[image drawAtPoint:CGPointMake(i.xPos - image.size.width/2, 768 - i.yPos - image.size.height/2) blendMode:kCGBlendModeNormal alpha:i.alpha];
        [image drawAtPoint:CGPointMake(i.xPos - image.size.width/2, 768 - i.yPos - image.size.height/2)];
    }
    CGPoint top_left = CGPointMake(gameModel.pot.xPos - pot_top.size.width/2,768 - gameModel.pot.yPos - pot_top.size.height/2);
    [pot_top drawAtPoint:top_left];
    [pot_bottom drawAtPoint:top_left];
}

- (void)dealloc
{
    [ingredientImages release];
    [gameModel release];
    [super dealloc];
}

@end
