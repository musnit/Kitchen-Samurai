//
//  CustomSwipeGestureRecognizer.h
//  Kitchen Samurai
//
//  Created by Rizmari Versfeld on 2011/05/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@class PhysicalObject;

@interface CustomSwipeGestureRecognizer : UIGestureRecognizer {
    
}

@property (nonatomic, retain) PhysicalObject *pot;
@end
