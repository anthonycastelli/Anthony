//
//  UIViewController+ACPopupViewController.m
//  Legato
//
//  Created by Anthony Castelli on 4/5/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "UIViewController+ACPopupViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ACPopupBackgroundView.h"
#import <objc/runtime.h>

#define kPopupModalAnimationDuration 0.35
#define kACPopupViewController @"kACPopupViewController"
#define kACPopupBackgroundView @"kACPopupBackgroundView"
#define kACSourceViewTag 23941
#define kACPopupViewTag 23942
#define kACOverlayViewTag 23945

@interface UIViewController (ACPopupViewControllerPrivate)
- (UIView *)topView;
- (void)presentPopupView:(UIView *)popupView;
@end

#pragma mark - Public

@implementation UIViewController (ACPopupViewController)

static void * const keypath = (void*)&keypath;

- (UIViewController *)AC_popupViewController {
    return objc_getAssociatedObject(self, kACPopupViewController);
}

- (void)setAC_popupViewController:(UIViewController *)AC_popupViewController {
    objc_setAssociatedObject(self, kACPopupViewController, AC_popupViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (ACPopupBackgroundView *)AC_popupBackgroundView {
    return objc_getAssociatedObject(self, kACPopupBackgroundView);
}

- (void)setAC_popupBackgroundView:(ACPopupBackgroundView *)AC_popupBackgroundView {
    objc_setAssociatedObject(self, kACPopupBackgroundView, AC_popupBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)presentPopupViewController:(UIViewController *)popupViewController animationType:(ACPopupViewAnimation)animationType {
    self.AC_popupViewController = popupViewController;
    [self presentPopupView:popupViewController.view animationType:animationType];
}

- (void)dismissPopupViewControllerWithanimationType:(ACPopupViewAnimation)animationType {
    UIView *sourceView = [self topView];
    UIView *popupView = [sourceView viewWithTag:kACPopupViewTag];
    UIView *overlayView = [sourceView viewWithTag:kACOverlayViewTag];
    
    switch (animationType) {
        case ACPopupViewAnimationSlideBottomTop:
        case ACPopupViewAnimationSlideBottomBottom:
        case ACPopupViewAnimationSlideTopTop:
        case ACPopupViewAnimationSlideTopBottom:
        case ACPopupViewAnimationSlideLeftLeft:
        case ACPopupViewAnimationSlideLeftRight:
        case ACPopupViewAnimationSlideRightLeft:
        case ACPopupViewAnimationSlideRightRight:
            [self slideViewOut:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
            break;
            
        default:
            [self fadeViewOut:popupView sourceView:sourceView overlayView:overlayView];
            break;
    }
    self.AC_popupViewController = nil;
}

#pragma mark - View Handling

- (void)presentPopupView:(UIView*)popupView animationType:(ACPopupViewAnimation)animationType {
    UIView *sourceView = [self topView];
    sourceView.tag = kACSourceViewTag;
    popupView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    popupView.tag = kACPopupViewTag;
    
    // check if source view controller is not in destination
    if ([sourceView.subviews containsObject:popupView]) return;
    
    // customize popupView
    popupView.layer.shadowPath = [UIBezierPath bezierPathWithRect:popupView.bounds].CGPath;
    popupView.layer.masksToBounds = NO;
    popupView.layer.shadowOffset = CGSizeMake(5, 5);
    popupView.layer.shadowRadius = 5;
    popupView.layer.shadowOpacity = 0.5;
    popupView.layer.shouldRasterize = YES;
    popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    // Add semi overlay
    UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
    overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlayView.tag = kACOverlayViewTag;
    overlayView.backgroundColor = [UIColor clearColor];
    
    // BackgroundView
    self.AC_popupBackgroundView = [[ACPopupBackgroundView alloc] initWithFrame:sourceView.bounds];
    self.AC_popupBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.AC_popupBackgroundView.backgroundColor = [UIColor clearColor];
    self.AC_popupBackgroundView.alpha = 0.0f;
    [overlayView addSubview:self.AC_popupBackgroundView];
    
    // Make the Background Clickable
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    dismissButton.backgroundColor = [UIColor clearColor];
    dismissButton.frame = sourceView.bounds;
    [overlayView addSubview:dismissButton];
    
    popupView.alpha = 0.0f;
    [overlayView addSubview:popupView];
    [sourceView addSubview:overlayView];
    
    [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimation:) forControlEvents:UIControlEventTouchUpInside];
    switch (animationType) {
        case ACPopupViewAnimationSlideBottomTop:
        case ACPopupViewAnimationSlideBottomBottom:
        case ACPopupViewAnimationSlideTopTop:
        case ACPopupViewAnimationSlideTopBottom:
        case ACPopupViewAnimationSlideLeftLeft:
        case ACPopupViewAnimationSlideLeftRight:
        case ACPopupViewAnimationSlideRightLeft:
        case ACPopupViewAnimationSlideRightRight:
            dismissButton.tag = animationType;
            [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
            break;
        default:
            dismissButton.tag = ACPopupViewAnimationFade;
            [self fadeViewIn:popupView sourceView:sourceView overlayView:overlayView];
            break;
    }
}

- (UIView *)topView {
    UIViewController *recentView = self;
    
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
}

- (void)dismissPopupViewControllerWithanimation:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton* dismissButton = sender;
        switch (dismissButton.tag) {
            case ACPopupViewAnimationSlideBottomTop:
            case ACPopupViewAnimationSlideBottomBottom:
            case ACPopupViewAnimationSlideTopTop:
            case ACPopupViewAnimationSlideTopBottom:
            case ACPopupViewAnimationSlideLeftLeft:
            case ACPopupViewAnimationSlideLeftRight:
            case ACPopupViewAnimationSlideRightLeft:
            case ACPopupViewAnimationSlideRightRight:
                [self dismissPopupViewControllerWithanimationType:dismissButton.tag];
                break;
            default:
                [self dismissPopupViewControllerWithanimationType:ACPopupViewAnimationFade];
                break;
        }
    } else {
        [self dismissPopupViewControllerWithanimationType:ACPopupViewAnimationFade];
    }
}

#pragma mark - Animations

#pragma mark - Slide

- (void)slideViewIn:(UIView *)popupView sourceView:(UIView *)sourceView overlayView:(UIView *)overlayView withAnimationType:(ACPopupViewAnimation)animationType {
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupStartRect;
    switch (animationType) {
        case ACPopupViewAnimationSlideBottomTop:
        case ACPopupViewAnimationSlideBottomBottom:
            popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                        sourceSize.height,
                                        popupSize.width,
                                        popupSize.height);
            
            break;
        case ACPopupViewAnimationSlideLeftLeft:
        case ACPopupViewAnimationSlideLeftRight:
            popupStartRect = CGRectMake(-sourceSize.width,
                                        (sourceSize.height - popupSize.height) / 2,
                                        popupSize.width,
                                        popupSize.height);
            break;
            
        case ACPopupViewAnimationSlideTopTop:
        case ACPopupViewAnimationSlideTopBottom:
            popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                        -popupSize.height,
                                        popupSize.width,
                                        popupSize.height);
            break;
            
        default:
            popupStartRect = CGRectMake(sourceSize.width,
                                        (sourceSize.height - popupSize.height) / 2,
                                        popupSize.width,
                                        popupSize.height);
            break;
    }
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupStartRect;
    popupView.alpha = 1.0f;
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.AC_popupViewController viewWillAppear:NO];
        self.AC_popupBackgroundView.alpha = 1.0f;
        popupView.frame = popupEndRect;
    } completion:^(BOOL finished) {
        [self.AC_popupViewController viewDidAppear:NO];
    }];
}

- (void)slideViewOut:(UIView *)popupView sourceView:(UIView *)sourceView overlayView:(UIView *)overlayView withAnimationType:(ACPopupViewAnimation)animationType {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PopupWillDismiss" object:nil];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect;
    switch (animationType) {
        case ACPopupViewAnimationSlideBottomTop:
        case ACPopupViewAnimationSlideTopTop:
            popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                      -popupSize.height,
                                      popupSize.width,
                                      popupSize.height);
            break;
        case ACPopupViewAnimationSlideBottomBottom:
        case ACPopupViewAnimationSlideTopBottom:
            popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                      sourceSize.height,
                                      popupSize.width,
                                      popupSize.height);
            break;
        case ACPopupViewAnimationSlideLeftRight:
        case ACPopupViewAnimationSlideRightRight:
            popupEndRect = CGRectMake(sourceSize.width,
                                      popupView.frame.origin.y,
                                      popupSize.width,
                                      popupSize.height);
            break;
        default:
            popupEndRect = CGRectMake(-popupSize.width,
                                      popupView.frame.origin.y,
                                      popupSize.width,
                                      popupSize.height);
            break;
    }
    
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.AC_popupViewController viewWillDisappear:NO];
        popupView.frame = popupEndRect;
        self.AC_popupBackgroundView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        [self.AC_popupViewController viewDidDisappear:NO];
        self.AC_popupViewController = nil;
    }];
}

#pragma mark --- Fade

- (void)fadeViewIn:(UIView *)popupView sourceView:(UIView *)sourceView overlayView:(UIView *)overlayView {
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupEndRect;
    popupView.alpha = 0.0f;
    
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        [self.AC_popupViewController viewWillAppear:NO];
        self.AC_popupBackgroundView.alpha = 0.5f;
        popupView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self.AC_popupViewController viewDidAppear:NO];
    }];
}

- (void)fadeViewOut:(UIView *)popupView sourceView:(UIView *)sourceView overlayView:(UIView *)overlayView {
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        [self.AC_popupViewController viewWillDisappear:NO];
        self.AC_popupBackgroundView.alpha = 0.0f;
        popupView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        [self.AC_popupViewController viewDidDisappear:NO];
        self.AC_popupViewController = nil;
    }];
}


@end
