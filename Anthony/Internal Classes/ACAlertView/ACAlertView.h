//
//  ACAlertView.h
//  Legato
//
//  Created by Anthony Castelli on 4/10/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ACAlertViewDelegate;

@interface ACAlertView : UIView

typedef enum {
    ACAlertViewDismissalStyleDefault, // Defaults to the global settings set by JSAlertViewPresenter
    ACAlertViewDismissalStyleShrink,
    ACAlertViewDismissalStyleFall, // Like Tweetbot
    ACAlertViewDismissalStyleExpand, // Like Reeder
    ACAlertViewDismissalStyleFade, // The iOS default looks like this
} ACAlertViewDismissalStyle;

@property (nonatomic, weak) id <ACAlertViewDelegate> delegate;
@property (nonatomic, readonly) int numberOfButtons;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, assign) ACAlertViewDismissalStyle cancelButtonDismissalStyle;
@property (nonatomic, assign) ACAlertViewDismissalStyle acceptButtonDismissalStyle;

+ (void)setGlobalAcceptButtonDismissalAnimationStyle:(ACAlertViewDismissalStyle)style;
+ (void)setGlobalCancelButtonDismissalAnimationStyle:(ACAlertViewDismissalStyle)style;
+ (void)setGlobalTintColor:(UIColor *)tint;
+ (void)resetDefaults;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<ACAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (void)show;
- (void)dismissWithTappedButtonIndex:(NSInteger)index animated:(BOOL)animated;

@end

@protocol ACAlertViewDelegate <NSObject>

@optional
- (void)alertView:(ACAlertView *)alertView tappedButtonAtIndex:(NSInteger)index;
- (void)willPresentAlertView:(ACAlertView *)alertView;
- (void)didPresentAlertView:(ACAlertView *)alertView;
- (void)alertView:(ACAlertView *)alertView willDismissWithButtonIndex:(NSInteger)index;
- (void)alertView:(ACAlertView *)alertView didDismissWithButtonIndex:(NSInteger)index;

@end







