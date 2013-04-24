//
//  UIViewController+ACPopupViewController.h
//  Legato
//
//  Created by Anthony Castelli on 4/5/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACPopupBackgroundView;

typedef enum {
    ACPopupViewAnimationFade = 0,
    ACPopupViewAnimationSlideBottomTop = 1,
    ACPopupViewAnimationSlideBottomBottom,
    ACPopupViewAnimationSlideTopTop,
    ACPopupViewAnimationSlideTopBottom,
    ACPopupViewAnimationSlideLeftLeft,
    ACPopupViewAnimationSlideLeftRight,
    ACPopupViewAnimationSlideRightLeft,
    ACPopupViewAnimationSlideRightRight,
} ACPopupViewAnimation;

@interface UIViewController (MJPopupViewController)

@property (nonatomic, retain) UIViewController *mj_popupViewController;
@property (nonatomic, retain) ACPopupBackgroundView *mj_popupBackgroundView;

- (void)presentPopupViewController:(UIViewController *)popupViewController animationType:(ACPopupViewAnimation)animationType;
- (void)dismissPopupViewControllerWithanimationType:(ACPopupViewAnimation)animationType;

@end
