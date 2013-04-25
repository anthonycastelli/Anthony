//
//  ACAlertView.m
//  Legato
//
//  Created by Anthony Castelli on 4/10/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACAlertView.h"
#import <QuartzCore/QuartzCore.h>

@interface UIImage (IPImageUtils)

+ (UIImage *)ipMaskedImageNamed:(NSString *)name color:(UIColor *)color;
+ (UIImage *)imageFromMainBundleFile:(NSString*)aFileName;

@end

@implementation UIImage (IPImageUtils)

+ (UIImage *)ipMaskedImageNamed:(NSString *)name color:(UIColor *)color {
	UIImage *image = [UIImage imageFromMainBundleFile:name];
	CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
	CGContextRef c = UIGraphicsGetCurrentContext();
	[image drawInRect:rect];
	CGContextSetFillColorWithColor(c, [color CGColor]);
	CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
	CGContextFillRect(c, rect);
	UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
	return result;
}

+ (UIImage *)imageFromMainBundleFile:(NSString*)aFileName; {
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", bundlePath, aFileName]];
}

@end

@interface ACAlertViewPresenter : NSObject

@property (nonatomic, assign) ACAlertViewDismissalStyle defaultCancelDismissalStyle;
@property (nonatomic, assign) ACAlertViewDismissalStyle defaultAcceptDismissalStyle;
@property (nonatomic, strong) UIColor *defaultColor;

+ (ACAlertViewPresenter *)sharedAlertViewPresenter;
- (void)resetDefaultAppearance;
- (void)showAlertView:(ACAlertView *)alertView;
- (void)AC_alertView:(ACAlertView *)sender tappedButtonAtIndex:(NSInteger)index animated:(BOOL)animated;

@end

@interface ACAlertViewPresenter ()

@property (nonatomic, strong) NSMutableArray *alertViews;
@property (nonatomic, strong) ACAlertView *visibleAlertView;
@property (nonatomic, strong) UIView *alertContainerView;
@property (nonatomic, assign) UIInterfaceOrientation currentOrientation;
@property (nonatomic, strong) UIWindow *alertOverlayWindow;
@property (nonatomic, strong) UIWindow *originalKeyWindow;
@property (nonatomic, strong) UIImageView *bgShadow;
@property (nonatomic, assign) BOOL isAnimating;

- (void)dismissAlertView:(ACAlertView *)alertView withCancelAnimation:(BOOL)animated atButtonIndex:(NSInteger)index;
- (void)dismissAlertView:(ACAlertView *)alertView withAcceptAnimation:(BOOL)animated atButtonIndex:(NSInteger)index;

- (void)dismissAlertView:(ACAlertView *)alertView withShrinkAnimation:(BOOL)animated atButtonIndex:(NSInteger)index;
- (void)dismissAlertView:(ACAlertView *)alertView withFallAnimation:(BOOL)animated atButtonIndex:(NSInteger)index;
- (void)dismissAlertView:(ACAlertView *)alertView withExpandAnimation:(BOOL)animated atButtonIndex:(NSInteger)index;
- (void)dismissAlertView:(ACAlertView *)alertView withFadeAnimation:(BOOL)animated atButtonIndex:(NSInteger)index;

- (void)prepareBackgroundShadow;
- (void)prepareAlertContainerView;
- (void)prepareWindow;
- (void)presentAlertView:(ACAlertView *)alertView;
- (void)showNextAlertView;
- (void)dismissWindow;
- (void)updateViewForOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated;

@end

@implementation ACAlertViewPresenter

@synthesize defaultCancelDismissalStyle = _defaultCancelDismissalStyle;
@synthesize defaultAcceptDismissalStyle = _defaultAcceptDismissalStyle;
@synthesize alertViews = _alertViews;
@synthesize visibleAlertView = _visibleAlertView;
@synthesize alertContainerView = _alertContainerView;
@synthesize currentOrientation = _currentOrientation;
@synthesize alertOverlayWindow = _alertOverlayWindow;
@synthesize bgShadow = _bgShadow;
@synthesize isAnimating = _isAnimating;
@synthesize defaultColor = _defaultColor;
@synthesize originalKeyWindow = _originalKeyWindow;

#define kCancelButtonIndex 0

+ (id)sharedAlertViewPresenter {
    static dispatch_once_t once;
    static ACAlertViewPresenter *sharedAlertViewPresenter;
    dispatch_once(&once, ^ { sharedAlertViewPresenter = [[self alloc] init]; });
    return sharedAlertViewPresenter;
}

- (id)init {
    self = [super init];
    if (self) {
        NSAssert([[[UIApplication sharedApplication] keyWindow] rootViewController], @"ACAlertView requires that your application's keyWindow has a rootViewController");
        _alertViews = [NSMutableArray array];
        [self resetDefaultAppearance];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    return self;
}

#pragma mark - Rotation

- (void)didRotate:(NSNotification *)notification {
    [self matchReferenceOrientation:YES];
}

- (void)matchReferenceOrientation:(BOOL)animated {
    UIWindow *referenceWindow = self.originalKeyWindow;
    if (referenceWindow == nil) {
        referenceWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    }
    UIViewController *rootVC = referenceWindow.rootViewController;
    UIViewController *referenceViewController = rootVC;
    if (rootVC.presentedViewController) {
        referenceViewController = rootVC.presentedViewController;
    }
}

- (void)updateViewForOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated {
    CGFloat duration = 0.0f;
    if (animated) {
        duration = 0.3;
        if ( (UIInterfaceOrientationIsLandscape(self.currentOrientation) && UIInterfaceOrientationIsLandscape(orientation))
            || (UIInterfaceOrientationIsPortrait(orientation) && UIInterfaceOrientationIsPortrait(self.currentOrientation)) ) {
            duration = 0.6;
        }
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            duration = duration * 1.3;
        }
    }
    self.currentOrientation = orientation;
    [UIView animateWithDuration:duration animations:^{
        switch (orientation) {
            case UIInterfaceOrientationPortrait:
                _alertContainerView.transform = CGAffineTransformMakeRotation(0);
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                _alertContainerView.transform = CGAffineTransformMakeRotation(M_PI);
                break;
            case UIInterfaceOrientationLandscapeLeft:
                _alertContainerView.transform = CGAffineTransformMakeRotation(M_PI / -2);
                break;
            case UIInterfaceOrientationLandscapeRight:
                _alertContainerView.transform = CGAffineTransformMakeRotation(M_PI / 2);
                break; 
            default:
                break;
        }
    }];
    
}

#pragma mark - Show, Hide, Respond

- (void)showAlertView:(ACAlertView *)alertView {
    [self.alertViews addObject:alertView];
    if (self.visibleAlertView == nil && _isAnimating == NO) {
        [self presentAlertView:alertView];
    }
}

- (void)presentAlertView:(ACAlertView *)alertView {
    _isAnimating = YES;
    self.visibleAlertView = alertView;
    
    if ([alertView.delegate respondsToSelector:@selector(willPresentAlertView:)]) {
        [alertView.delegate willPresentAlertView:alertView];
    }
    
    if (self.alertOverlayWindow == nil) {
        [self prepareWindow];
    }
    
    if (self.bgShadow == nil) {
        [self prepareBackgroundShadow];
    }
    
    if (self.alertContainerView == nil) {
        [self prepareAlertContainerView];
    }
    
    alertView.transform = CGAffineTransformMakeScale(0.05f, 0.05f);
    alertView.alpha = 0.0f;
    alertView.center = CGPointMake(floorf(_alertContainerView.center.x), floorf(_alertContainerView.center.y));
    [_alertContainerView addSubview:alertView];
    
    [UIView animateWithDuration:0.2f animations:^{
        alertView.alpha = 1.0f;
        _bgShadow.alpha = 1.0f;
    }];
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        alertView.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            alertView.transform = CGAffineTransformMakeScale(0.97f, 0.97f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.05f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                alertView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                _isAnimating = NO;
                if ([alertView.delegate respondsToSelector:@selector(didPresentAlertView:)]) {
                    [alertView.delegate didPresentAlertView:alertView];
                }
            }];
        }];
    }];
}

- (void)showNextAlertView {
    if (self.alertViews.count > 0) {
        [self presentAlertView:[self.alertViews objectAtIndex:0]];
    } 
}

- (void)dismissWindow {
    [UIView animateWithDuration:0.33f animations:^{
        _bgShadow.alpha = 0.0f;
    } completion:^(BOOL finished) {
        _isAnimating = NO;
        [_bgShadow removeFromSuperview];
        [_alertContainerView removeFromSuperview];
        [_alertOverlayWindow removeFromSuperview];
        self.bgShadow = nil;
        self.alertContainerView = nil;
        self.alertOverlayWindow = nil;
        [self.originalKeyWindow makeKeyAndVisible];
        self.originalKeyWindow = nil;
    }];
}

- (void)AC_alertView:(ACAlertView *)sender tappedButtonAtIndex:(NSInteger)index animated:(BOOL)animated {
    if ([sender.delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        [sender.delegate alertView:sender willDismissWithButtonIndex:index];
    }
    if (index == kCancelButtonIndex) {      
        if (sender.numberOfButtons > 1) {
            [self dismissAlertView:sender withCancelAnimation:animated atButtonIndex:index];
        } else {
            [self dismissAlertView:sender withAcceptAnimation:animated atButtonIndex:index];
        }
    } else {
        [self dismissAlertView:sender withAcceptAnimation:animated atButtonIndex:index];
    }
}

- (void)dismissAlertView:(ACAlertView *)alertView withCancelAnimation:(BOOL)animated atButtonIndex:(NSInteger)index {
    if (self.alertViews.count == 1) {
        [self dismissWindow];
    }
    switch (self.defaultCancelDismissalStyle) {
        case ACAlertViewDismissalStyleShrink:
            [self dismissAlertView:alertView withShrinkAnimation:animated atButtonIndex:index];
            break;
        case ACAlertViewDismissalStyleFall:
            [self dismissAlertView:alertView withFallAnimation:animated atButtonIndex:index];
            break;
        case ACAlertViewDismissalStyleExpand:
            [self dismissAlertView:alertView withExpandAnimation:animated atButtonIndex:index];
            break;
        case ACAlertViewDismissalStyleFade:
        case ACAlertViewDismissalStyleDefault:
            [self dismissAlertView:alertView withFadeAnimation:animated atButtonIndex:index];
            break;
        default:
            break;
    }    
}

- (void)dismissAlertView:(ACAlertView *)alertView withAcceptAnimation:(BOOL)animated atButtonIndex:(NSInteger)index {
    if (self.alertViews.count == 1) {
        [self dismissWindow];
    }
    switch (self.defaultAcceptDismissalStyle) {
        case ACAlertViewDismissalStyleShrink:
            [self dismissAlertView:alertView withShrinkAnimation:animated atButtonIndex:index];
            break;
        case ACAlertViewDismissalStyleFall:
            [self dismissAlertView:alertView withFallAnimation:animated atButtonIndex:index];
            break;
        case ACAlertViewDismissalStyleExpand:
            [self dismissAlertView:alertView withExpandAnimation:animated atButtonIndex:index];
            break;
        case ACAlertViewDismissalStyleFade:
        case ACAlertViewDismissalStyleDefault:
            [self dismissAlertView:alertView withFadeAnimation:animated atButtonIndex:index];
            break;
        default:
            break;
    }
}

- (void)dismissAlertView:(ACAlertView *)alertView withShrinkAnimation:(BOOL)animated atButtonIndex:(NSInteger)index {
    CGFloat duration = 0.0f;
    if (animated) {
        duration = 0.2f;
    }
    __weak ACAlertView *blockSafeAlertView = alertView;
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        blockSafeAlertView.alpha = 0.0f;
        blockSafeAlertView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        if ([blockSafeAlertView.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
            [blockSafeAlertView.delegate alertView:blockSafeAlertView didDismissWithButtonIndex:index];
        }
        [blockSafeAlertView removeFromSuperview];
        [self.alertViews removeObject:blockSafeAlertView];
        self.visibleAlertView = nil;
        [self showNextAlertView];
    }];
}

- (void)dismissAlertView:(ACAlertView *)alertView withFallAnimation:(BOOL)animated atButtonIndex:(NSInteger)index {
    CGFloat duration = 0.0f;
    if (animated) {
        duration = 0.3f;
    }
    __weak ACAlertView *blockSafeAlertView = alertView;
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        blockSafeAlertView.alpha = 0.0f;
        CGRect frame = blockSafeAlertView.frame;
        frame.origin.y += 320.0f;
        blockSafeAlertView.frame = frame;
        blockSafeAlertView.transform = CGAffineTransformMakeRotation(M_PI / -3.5);
    } completion:^(BOOL finished) {
        if ([alertView.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
            [alertView.delegate alertView:blockSafeAlertView didDismissWithButtonIndex:index];
        }
        [blockSafeAlertView removeFromSuperview];
        [self.alertViews removeObject:blockSafeAlertView];
        self.visibleAlertView = nil;
        [self showNextAlertView];
    }];
}

- (void)dismissAlertView:(ACAlertView *)alertView withExpandAnimation:(BOOL)animated atButtonIndex:(NSInteger)index {
    CGFloat duration = 0.0f;
    if (animated) {
        duration = 0.25f;
    }
    __weak ACAlertView *blockSafeAlertView = alertView;
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        blockSafeAlertView.alpha = 0.0f;
        blockSafeAlertView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        if ([alertView.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
            [alertView.delegate alertView:blockSafeAlertView didDismissWithButtonIndex:index];
        }
        [blockSafeAlertView removeFromSuperview];
        [self.alertViews removeObject:blockSafeAlertView];
        self.visibleAlertView = nil;
        [self showNextAlertView];
    }];
}

- (void)dismissAlertView:(ACAlertView *)alertView withFadeAnimation:(BOOL)animated atButtonIndex:(NSInteger)index {
    CGFloat duration = 0.0f;
    if (animated) {
        duration = 0.25f;
    }
    __weak ACAlertView *blockSafeAlertView = alertView;
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        blockSafeAlertView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if ([alertView.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
            [alertView.delegate alertView:blockSafeAlertView didDismissWithButtonIndex:index];
        }
        [blockSafeAlertView removeFromSuperview];
        [self.alertViews removeObject:blockSafeAlertView];
        self.visibleAlertView = nil;
        [self showNextAlertView];
    }];
}

#pragma mark - Convenience Methods

- (void)prepareWindow {
    self.originalKeyWindow = [[UIApplication sharedApplication] keyWindow];
    self.alertOverlayWindow = [[UIWindow alloc] initWithFrame:[self.originalKeyWindow frame]];
    _alertOverlayWindow.windowLevel = UIWindowLevelAlert;
    _alertOverlayWindow.backgroundColor = [UIColor clearColor];
    [self.alertOverlayWindow makeKeyAndVisible];
    [self matchReferenceOrientation:NO];
}

- (void)prepareBackgroundShadow {
    UIImage *shadowImage = [UIImage imageFromMainBundleFile:@"acAlertView_gradientShadowOverlay_iPhone.png"]; // Used to use separate images for each device. This one looks great by itself.
    self.bgShadow = [[UIImageView alloc] initWithImage:shadowImage];
    _bgShadow.frame = [[UIScreen mainScreen] bounds];
    _bgShadow.contentMode = UIViewContentModeScaleToFill;
    _bgShadow.center = _alertOverlayWindow.center;
    _bgShadow.alpha = 0.0f;
    [_alertOverlayWindow addSubview:_bgShadow];
}

- (void)prepareAlertContainerView {
    self.alertContainerView = [[UIView alloc] initWithFrame:_alertOverlayWindow.bounds];
    _alertContainerView.clipsToBounds = NO;
    [_alertOverlayWindow addSubview:_alertContainerView];
    [self matchReferenceOrientation:NO];
}

- (void)resetDefaultAppearance {
    _defaultCancelDismissalStyle = ACAlertViewDismissalStyleFade;
    _defaultAcceptDismissalStyle = ACAlertViewDismissalStyleFade;
    _defaultColor = [UIColor colorWithRed:0.02f green:0.06f blue:0.25f alpha:1.0f];
}

@end

@interface ACAlertView ()

@property (weak, nonatomic) ACAlertViewPresenter *presenter;
@property (strong, nonatomic) UIImageView *bgShadow;
@property (strong, nonatomic) UIImageView *littleWindowBG;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) NSMutableArray *acceptButtons;
@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *messageText;
@property (strong, nonatomic) NSString *cancelButtonTitle;
@property (strong, nonatomic) NSMutableArray *acceptButtonTitles;
@property (assign, nonatomic) CGSize messageSize;
@property (assign, nonatomic) CGSize titleSize;
@property (assign, nonatomic) BOOL isBeingDismissed;

- (void)initialSetup;
- (void)cancelButtonPressed:(id)sender;
- (void)actionButtonPressed:(id)sender;
- (void)prepareBackgroundImage;
- (void)prepareTitle;
- (void)prepareMessage;
- (void)prepareCancelButton;
- (void)prepareAcceptButtons;
- (UIImage *)defaultBackgroundImage;

@end

@implementation ACAlertView

@synthesize delegate = _delegate;
@synthesize presenter = _presenter;
@synthesize bgShadow = _bgShadow;
@synthesize littleWindowBG = _littleWindowBG;
@synthesize titleLabel = _titleLabel;
@synthesize messageLabel = _messageLabel;
@synthesize cancelButton = _cancelButton;
@synthesize acceptButtons = _acceptButtons;
@synthesize titleText = _titleText;
@synthesize messageText = _messageText;
@synthesize cancelButtonTitle = _cancelButtonTitle;
@synthesize acceptButtonTitles = _acceptButtonTitles;
@synthesize messageSize = _messageSize;
@synthesize titleSize = _titleSize;
@synthesize numberOfButtons;
@synthesize isBeingDismissed = _isBeingDismissed;
@synthesize tintColor = _tintColor;
@synthesize cancelButtonDismissalStyle = _cancelButtonDismissalStyle;
@synthesize acceptButtonDismissalStyle = _acceptButtonDismissalStyle;

#define kMaxViewWidth 284.0f

#define kDefaultTitleFontSize 18
#define kTitleOriginX 20
#define kTitleLeadingTop 19
#define kTitleLeadingBottom 10
#define kTitleSpacingMultiplier 1.5
#define kMaxTitleWidth 244
#define kMaxTitleNumberOfLines 3

#define kDefaultMessageFontSize 16
#define kMaxMessageWidth 256.0f
#define kMaxMessageNumberOfLines 8
#define kMessageOriginX 14

#define kSpacing 7
#define kSpaceAboveTopButton 7
#define kSpaceAfterOneOfSeveralActionButtons 6
#define kSpaceAboveSeparatedCancelButton 7
#define kSpaceAfterBottomButton 15
#define kMinimumButtonLabelSize 12
#define kLeftButtonOriginX 11
#define kRightButtonOriginX 146
#define kMinButtonWidth 127
#define kMaxButtonWidth 262
#define kButtonHeight 44.0f

#define kWidthForDefaultAlphaBG 268

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<ACAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super init];
    if (self) {
        [self initialSetup];
        _titleText = title && title.length > 0 ? title : @"Untitled Alert";
        _cancelButtonTitle = cancelButtonTitle;
        _acceptButtonTitles = [NSMutableArray array];
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
            if (arg.length > 0) {
                [_acceptButtonTitles addObject:arg];
            }
        }
        va_end(args);
        _acceptButtons = [NSMutableArray array];
        _messageText = message;
        _delegate = delegate;
    }    
    return self;
}

- (int)numberOfButtons {
    int count = 0;
    if (_cancelButton) {
        count += 1;
    }
    count += _acceptButtons.count;
    return count;
}

- (void)show {
    [self prepareBackgroundImage];
    [self prepareTitle];
    if (_messageText && _messageText.length > 0) {
        [self prepareMessage];
    } else {
        _messageSize = CGSizeZero;
    }
    if (_cancelButtonTitle && _cancelButtonTitle.length > 0) {
        [self prepareCancelButton];
    }
    [self prepareAcceptButtons];
    CGFloat height = kTitleLeadingTop + _titleSize.height + kTitleLeadingBottom ;
    if (_messageLabel) {
        height += _messageSize.height + kSpacing;
    }
    height += kSpaceAboveTopButton;
    if (_cancelButton) {
        height += kButtonHeight + kSpaceAfterBottomButton;
        if (_acceptButtons.count > 1) {
            height += (kButtonHeight + kSpaceAfterOneOfSeveralActionButtons) * _acceptButtonTitles.count + kSpaceAboveSeparatedCancelButton + kSpacing;
        }
    } else {
        height += (kButtonHeight + kSpaceAfterOneOfSeveralActionButtons) * _acceptButtonTitles.count - kSpaceAfterOneOfSeveralActionButtons + kSpaceAfterBottomButton;
    } 
    self.frame = CGRectMake(0, 0, kMaxViewWidth, height);
    [_presenter showAlertView:self];
}

- (void)dismissWithTappedButtonIndex:(NSInteger)index animated:(BOOL)animated {
    if (_isBeingDismissed == NO) {
        _isBeingDismissed = YES;
        [_presenter AC_alertView:self tappedButtonAtIndex:index animated:animated];
    }
}

- (void)cancelButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(alertView:tappedButtonAtIndex:)]) {
        [self.delegate alertView:self tappedButtonAtIndex:kCancelButtonIndex];
    }
    if (_isBeingDismissed == NO) {
        _isBeingDismissed = YES;
        [_presenter AC_alertView:self tappedButtonAtIndex:kCancelButtonIndex animated:YES];
    }
}

- (void)actionButtonPressed:(id)sender {
    UIButton *acceptButton = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(alertView:tappedButtonAtIndex:)]) {
        [self.delegate alertView:self tappedButtonAtIndex:acceptButton.tag];
    }
    [_presenter AC_alertView:self tappedButtonAtIndex:acceptButton.tag animated:YES];
}

#pragma mark - Convenience

- (void)initialSetup {
    _presenter = [ACAlertViewPresenter sharedAlertViewPresenter];
    self.frame = CGRectMake(0, 0, kMaxViewWidth, kMaxViewWidth);
    self.backgroundColor = [UIColor clearColor];
}

- (void)prepareBackgroundImage {
    self.littleWindowBG = [[UIImageView alloc] initWithImage:[self defaultBackgroundImage]];
    _littleWindowBG.frame = self.frame;
    _littleWindowBG.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _littleWindowBG.userInteractionEnabled = YES;
    UIImageView *overlayBorder = [[UIImageView alloc] initWithImage:[[UIImage imageFromMainBundleFile:@"acAlertView_defaultBackground_overlay.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(40, 40, 40, 40)]];
    overlayBorder.frame = _littleWindowBG.frame;
    overlayBorder.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlayBorder.userInteractionEnabled = NO;
    [self addSubview:_littleWindowBG];
    [self addSubview:overlayBorder];
}

- (void)prepareTitle {
    self.titleLabel = [[UILabel alloc] init];
    self.titleSize = [_titleText sizeWithFont:[UIFont boldSystemFontOfSize:kDefaultTitleFontSize] 
                            constrainedToSize:CGSizeMake(kMaxTitleWidth, kDefaultTitleFontSize * kMaxTitleNumberOfLines) 
                                lineBreakMode:NSLineBreakByTruncatingTail];
    _titleLabel.frame = CGRectMake(kTitleOriginX, kTitleLeadingTop, kMaxTitleWidth, _titleSize.height);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    _titleLabel.font = [UIFont boldSystemFontOfSize:kDefaultTitleFontSize];
    _titleLabel.text = _titleText;
    _titleLabel.numberOfLines = kMaxTitleNumberOfLines;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
    [_littleWindowBG addSubview:_titleLabel];
}

- (void)prepareMessage {
    self.messageLabel = [[UILabel alloc] init];
    self.messageSize = [_messageText sizeWithFont:[UIFont systemFontOfSize:kDefaultMessageFontSize] 
                                constrainedToSize:CGSizeMake(kMaxMessageWidth, kMaxMessageNumberOfLines * kDefaultMessageFontSize) 
                                    lineBreakMode:NSLineBreakByTruncatingTail];
    _messageLabel.frame = CGRectMake(kMessageOriginX, kTitleLeadingTop + _titleSize.height + kTitleLeadingBottom, kMaxMessageWidth, _messageSize.height);
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    _messageLabel.font = [UIFont systemFontOfSize:kDefaultMessageFontSize];
    _messageLabel.text = _messageText;
    _messageLabel.numberOfLines = kMaxMessageNumberOfLines;
    _messageLabel.backgroundColor = [UIColor clearColor];
    _messageLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
    [_littleWindowBG addSubview:_messageLabel];
}

- (void)prepareCancelButton {
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat yOrigin = kTitleLeadingTop + _titleSize.height + kTitleLeadingBottom;
    if (_messageLabel) {
        yOrigin += _messageSize.height + kSpacing;
    }
    yOrigin += kSpaceAboveTopButton;
    if (_acceptButtonTitles.count > 1) {
        yOrigin += (kButtonHeight + kSpaceAfterOneOfSeveralActionButtons) * _acceptButtonTitles.count + kSpacing + kSpaceAboveSeparatedCancelButton;
        _cancelButton.frame = CGRectMake(kLeftButtonOriginX, yOrigin, kMaxButtonWidth, kButtonHeight);
    } else if (_acceptButtonTitles.count == 1) {
        _cancelButton.frame = CGRectMake(kLeftButtonOriginX, yOrigin, kMinButtonWidth, kButtonHeight);
    } else {
        _cancelButton.frame = CGRectMake(kLeftButtonOriginX, yOrigin, kMaxButtonWidth, kButtonHeight);
    }
    if (_acceptButtonTitles.count > 0) {
        [_cancelButton setBackgroundImage:[[UIImage imageFromMainBundleFile:@"acAlertView_iOS_cancelButton_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)]
                                 forState:UIControlStateNormal];
    } else {
        [_cancelButton setBackgroundImage:[[UIImage imageFromMainBundleFile:@"acAlertView_iOS_okayButton_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)]
                                 forState:UIControlStateNormal];
    }
    [_cancelButton setBackgroundImage:[[UIImage imageFromMainBundleFile:@"acAlertView_iOS_okayCancelButton_highlighted.png"]  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)]
                             forState:UIControlStateHighlighted];
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelButton setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.5f] forState:UIControlStateNormal];
    [_cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    _cancelButton.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
    [_cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:kDefaultTitleFontSize];
    //_cancelButton.titleLabel.minimumFontSize = kMinimumButtonLabelSize;
    _cancelButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _cancelButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _cancelButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    [_littleWindowBG addSubview:_cancelButton];
}

- (void)prepareAcceptButtons {
    for (int index = 0; index < _acceptButtonTitles.count; index++) {
        NSString *buttonTitle = [_acceptButtonTitles objectAtIndex:index];
        UIButton *acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat yOrigin = kTitleLeadingTop + _titleSize.height + kTitleLeadingBottom;
        if (_messageLabel) {
            yOrigin += _messageSize.height + kSpacing;
        }
        yOrigin += kSpaceAboveTopButton;
        if (_acceptButtonTitles.count > 1) {
            yOrigin += (kButtonHeight + kSpaceAfterOneOfSeveralActionButtons) * index;
            acceptButton.frame = CGRectMake(kLeftButtonOriginX, yOrigin, kMaxButtonWidth, kButtonHeight);
        } else if (_cancelButtonTitle) {
            acceptButton.frame = CGRectMake(kRightButtonOriginX, yOrigin, kMinButtonWidth, kButtonHeight);
        } else {
            acceptButton.frame = CGRectMake(kLeftButtonOriginX, yOrigin, kMaxButtonWidth, kButtonHeight);
        }
        [acceptButton setBackgroundImage:[[UIImage imageFromMainBundleFile:@"acAlertView_iOS_okayButton_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)]
                                forState:UIControlStateNormal];
        [acceptButton setBackgroundImage:[[UIImage imageFromMainBundleFile:@"acAlertView_iOS_okayCancelButton_highlighted.png"]  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)]
                                forState:UIControlStateHighlighted];
        [acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [acceptButton setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.5f] forState:UIControlStateNormal];
        [acceptButton setTitle:buttonTitle forState:UIControlStateNormal];
        acceptButton.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
        [acceptButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        acceptButton.titleLabel.font = [UIFont boldSystemFontOfSize:kDefaultTitleFontSize];
        //acceptButton.titleLabel.minimumFontSize = kMinimumButtonLabelSize;
        acceptButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        acceptButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        acceptButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        [_littleWindowBG addSubview:acceptButton];
        acceptButton.tag = index + 1;
        [_acceptButtons addObject:acceptButton];
    }
}

- (UIImage *)defaultBackgroundImage {
    UIEdgeInsets _defaultBackgroundEdgeInsets = UIEdgeInsetsMake(40, 40, 40, 40);
    if (self.tintColor == nil) {
        self.tintColor = [[ACAlertViewPresenter sharedAlertViewPresenter] defaultColor];
    }
    UIImage *defaultImageWithColor = [UIImage ipMaskedImageNamed:@"acAlertView_defaultBackground_alphaOnly.png" color:self.tintColor];
    UIImage *_defaultBackgroundImage = [defaultImageWithColor resizableImageWithCapInsets:_defaultBackgroundEdgeInsets];
    return _defaultBackgroundImage;
}

+ (void)setGlobalAcceptButtonDismissalAnimationStyle:(ACAlertViewDismissalStyle)style {
    [[ACAlertViewPresenter sharedAlertViewPresenter] setDefaultAcceptDismissalStyle:style];
}

+ (void)setGlobalCancelButtonDismissalAnimationStyle:(ACAlertViewDismissalStyle)style {
    [[ACAlertViewPresenter sharedAlertViewPresenter] setDefaultCancelDismissalStyle:style];
}

+ (void)setGlobalTintColor:(UIColor *)tint {
    if (tint == nil) {
        tint = [UIColor colorWithRed:0.02f green:0.06f blue:0.25f alpha:1.0f]; 
    }
    [[ACAlertViewPresenter sharedAlertViewPresenter] setDefaultColor:tint];
}

+ (void)resetDefaults {
    [[ACAlertViewPresenter sharedAlertViewPresenter] resetDefaultAppearance];
}

@end
