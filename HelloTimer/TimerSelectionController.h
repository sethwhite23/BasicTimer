//
//  TimerSelectionController.h
//  HelloTimer
//
//  Created by Seth White on 3/5/16.
//  Copyright © 2016 Seth White. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimerSelectionDelegate

// The methods declared here are all optional
@optional

- (void) timerSelected: (NSTimeInterval)timeInterval;

@end


@interface TimerSelectionController : UIViewController

@property (weak) id <TimerSelectionDelegate> timerSelectionDelegate;

@end
