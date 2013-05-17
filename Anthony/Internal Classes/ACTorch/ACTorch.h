//
//  ACTorch.h
//  Anthony
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

// Notification strings for observers of Torch, used in torch start and stop
extern NSString * const TorchDidStartNotification;
extern NSString * const TorchDidStopNotification;

@interface ACTorch : NSObject

@property (nonatomic, retain) AVCaptureSession *mSession;
@property (nonatomic, retain) AVCaptureDevice *mDevice;
@property (nonatomic, retain) AVCaptureInput *mInput;
@property (nonatomic, retain) AVCaptureStillImageOutput *mOutput;
@property (nonatomic, retain) NSTimer *mStrobeTimer;
@property (nonatomic, assign) BOOL mStrobing;
@property (nonatomic, assign) NSInteger mStrobeTicks;

+ (ACTorch *)sharedTorch;

// Initialize the UITorch
- (id)init;

// Turn on the torch
- (void)start;

// Turn off the torch
- (void)stop;

// Start Strobing with givien seconds
- (void)startStrobesPerSecond:(int)strobesPerSecond forNumberOfSeconds:(int)numberOfSeconds;

// Turn of the strobe
- (void)stopStrobe;

// LED Torch is on
- (BOOL)isTorchOn;

// Strobe is running
- (BOOL)isStrobing;

@end
