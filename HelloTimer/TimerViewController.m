//
//  AlarmViewController.m
//  HelloTimer
//
//  Created by Seth White on 3/2/16.
//  Copyright © 2016 Seth White. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "TimerViewController.h"
#import "TimerSelectionController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *alarmStartButton;
@property (weak, nonatomic) IBOutlet UIButton *alarmStopButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *timerDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *timerButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@end

NSTimeInterval timer = 0;
NSTimer *alarmTimer;
BOOL timer_running = NO;

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateTime];
    
    if (timer_running){
        [_timerButton setEnabled:NO];
        [_alarmStartButton setEnabled:NO];
        [_alarmStopButton setEnabled:YES];

    }
    else{
        [_timerButton setEnabled:YES];
        [_alarmStartButton setEnabled:YES];
        [_alarmStopButton setEnabled:NO];
    }
}

- (IBAction)startButtonPressed:(UIButton *)sender {
    // Start the timer refire every second
    alarmTimer = [NSTimer scheduledTimerWithTimeInterval: 1 // 1 Second
        target: self
        selector: @selector(updateTimer)
        userInfo: nil
        repeats: YES];
    
    [self timerStarted];
}

- (void) updateTimer{
    [self updateTime];
    if (timer < 1){
        [self playTimerSound];
        [self timerStopped];
    }
    else {
        timer -= 1;
    }
}

- (void) timerStarted{
    [_alarmStopButton setEnabled:YES];
    [_alarmStartButton setEnabled:NO];
    [_timerButton setEnabled:NO];
    timer_running = YES;
}

- (void) timerStopped{
    [self clearTimer];
    [_alarmStopButton setEnabled:NO];
    [_alarmStartButton setEnabled:YES];
    [_timerButton setEnabled:YES];
    timer_running = NO;
}

- (void) playTimerSound {
    // User 1005 for now.  The Calendar Alert sound
    // http://iphonedevwiki.net/index.php/AudioServices
    NSLog(@"Playing Sound");
    AudioServicesPlayAlertSound(1053);
}

- (void) clearTimer{
    [alarmTimer invalidate];
    // Enable the Start button now the timer is not running.
    [_alarmStartButton setEnabled:YES];
}

- (IBAction)stopButtonPressed:(id)sender {
    [self timerStopped];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Check the segue identifier
    if ([segue.identifier isEqualToString:@"setTimer"])
    {
        // Get the TimerSelectionController from the Seque via the NavigationController
        UINavigationController *navController = [segue destinationViewController];
        TimerSelectionController *timerSelectionController = (TimerSelectionController *)([navController viewControllers][0]);
        
        // Set the delegate to this class in order to get the DatePicker value
        timerSelectionController.timerSelectionDelegate = self;
    }
}

- (void) timerSelected: (NSTimeInterval)timeInterval{
    timer = timeInterval;
    [self updateTimerText: timeInterval];
}

- (void) updateTime{
    [self updateTimerText: timer];
}

- (void) updateTimerText: (int) timer_seconds {
    int hours;
    int minutes;
    int seconds;
    int r;
    
    // Parse timer to readable format
    hours = timer_seconds / (60*60);
    r = timer_seconds - (hours * 60*60);
    minutes = r / (60);
    r = r - (minutes * 60);
    seconds = r;
    
    _timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
