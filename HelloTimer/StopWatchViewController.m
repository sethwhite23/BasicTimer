//
//  StopWatchViewController.m
//  HelloTimer
//
//  Created by Seth White on 3/2/16.
//  Copyright © 2016 Seth White. All rights reserved.
//

#import "StopWatchViewController.h"

@interface StopWatchViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stopWatchLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopwatchStartButton;
@property (weak, nonatomic) IBOutlet UIButton *stopwatchStopButton;

@end

@implementation StopWatchViewController

NSTimer *stopWatchTimer;
unsigned long stopWatchTime = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateStopWatchLabel];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(UIButton *)sender {
    NSLog(@"Start button pressed");
    
    stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval: .01
        target: self
        selector: @selector(updateTimer)
        userInfo: nil
        repeats: YES];
    
    // Disable the Start button while the Stopwatch is running.
    [_stopwatchStartButton setEnabled:NO];
}

- (IBAction)stopButtonPressed:(UIButton *)sender {
    [stopWatchTimer invalidate];
    
    // Enable the Start button.
    [_stopwatchStartButton setEnabled:YES];
}

- (IBAction)resetButtonPressed:(UIButton *)sender {
    stopWatchTime = 0.0;
    [self updateStopWatchLabel];
}

- (void) updateTimer{
    stopWatchTime += 1;
    [self updateStopWatchLabel];
}

- (void) updateStopWatchLabel {
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    int milliseconds = 0;
    int r = 0;
    NSString *stopWatchText = @"";
    
    // Parse stopWatchTime to readable format
    hours = (int) stopWatchTime / (60*60*10);
    r = (int) stopWatchTime - (hours * 60*60*10);
    minutes = r / (60*10);
    r = r - (minutes * 60 * 10);
    seconds = r / 100;
    milliseconds = fmodf(stopWatchTime, 100);
    
     _stopWatchLabel.text = [NSString stringWithFormat:@"%d:%02d:%02d.%02d", hours, minutes, seconds, milliseconds];
}

@end
