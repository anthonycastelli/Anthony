//
//  ACTorch.m
//  Anthony
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACTorch.h"
#import <AVFoundation/AVFoundation.h>

NSString *const TorchDidStartNotification = @"TorchDidStartNotification";
NSString *const TorchDidStopNotification = @"TorchDidStopNotification";

@implementation ACTorch


+ (ACTorch *)sharedTorch {
    static dispatch_once_t pred;
    static ACTorch *sharedTorch = nil;
    dispatch_once(&pred, ^{
        sharedTorch = [[self alloc] init];
    });
    return sharedTorch;
}

- (id)init {
	if(self = [super init]) {
		self.mSession = [[AVCaptureSession alloc] init];
        self.mDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
		[self.mSession beginConfiguration];
        [self.mDevice lockForConfiguration:nil];
		self.mInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.mDevice error:nil];
		self.mOutput = [[AVCaptureStillImageOutput alloc] init];
		//[mSession addInput:mInput]; // Broken for an unknown reason
		[self.mSession addOutput:self.mOutput];
		[self.mSession commitConfiguration];
		[self.mSession startRunning];
		
		self.mStrobing = NO;
	}
	return self;
}

- (void)start {
	[self.mDevice setTorchMode:AVCaptureTorchModeOn];
	[[NSNotificationCenter defaultCenter] postNotificationName:TorchDidStartNotification object:nil];
}

- (void)stop {
	[self.mDevice setTorchMode:AVCaptureTorchModeOff];
	[[NSNotificationCenter defaultCenter] postNotificationName:TorchDidStopNotification object:nil];
}

- (void)startStrobesPerSecond:(int)strobesPerSecond forNumberOfSeconds:(int)numberOfSeconds {
	
	//NSLog(@"strobesPerSec: %i   ForSeconds: %i", strobesPerSecond, numberOfSeconds);
	
    // validity
	if (strobesPerSecond <= 0)
		return;
	
	if (self.mStrobing)
		[self stopStrobe];
		//return;
    
    strobesPerSecond = strobesPerSecond * 2;    // bc strobe is the on and off count together, not just on
    
    // mode
	BOOL isInfinitLoop = (numberOfSeconds == -1);
    
    int strobeCount = strobesPerSecond * numberOfSeconds;
    NSTimeInterval strobeInterval = (double)numberOfSeconds / strobeCount;
    
	if (isInfinitLoop) {
		self.mStrobeTicks = -1;
        strobeInterval = (NSTimeInterval) 1 / strobesPerSecond;
    } else {
		self.mStrobeTicks = strobeCount;
	}
    NSLog(@"interval= %f", strobeInterval);
	self.mStrobeTimer = [NSTimer scheduledTimerWithTimeInterval:strobeInterval
													target:self
												  selector:@selector(strobeTimerLoopAction)
												  userInfo:nil
												   repeats:YES];

	self.mStrobing = YES;
}

- (void)strobeTimerLoopAction {
	
	if (self.mStrobeTicks == 0) {
		[self stopStrobe];
		return;
	}
	
	if (self.mStrobeTicks != -1)
		self.mStrobeTicks--;
	
	if([self isTorchOn])
		[self stop];
	else {
		[self start];
	}
}

- (void)stopStrobe {
	if (self.mStrobeTimer != NULL) {
		[self.mStrobeTimer invalidate];
		self.mStrobeTimer = nil;
	}
	
	[self stop];
	self.mStrobing = NO;
}

- (BOOL)isStrobing {
	return self.mStrobing;
}

- (BOOL)isTorchOn {
	if ([self.mDevice torchMode] == AVCaptureTorchModeOn) {
		return YES;
	}
	
	return NO;
}

@end
