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
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *alarmStartButton;
@property (weak, nonatomic) IBOutlet UIButton *alarmStopButton;

@end

NSTimeInterval timer = 0;
NSTimer *alarmTimer;


@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setTimerLabel];
}


- (IBAction)setTimerButtonPressed:(UIButton *)sender {
}


- (IBAction)startButtonPressed:(UIButton *)sender {
    // Start the timer refire every second
    alarmTimer = [NSTimer scheduledTimerWithTimeInterval: 1 // 1 Second
        target: self
        selector: @selector(updateTimer)
        userInfo: nil
        repeats: YES];
    
    [_alarmStartButton setEnabled:NO];
    [_alarmStopButton setEnabled:YES];
}

- (void) updateTimer{
    [self setTimerLabel];
    if (timer < 1){
        [self playTimerSound];
        [self clearTimer];
        [_alarmStopButton setEnabled:NO];
        [_alarmStartButton setEnabled:YES];
    }
    else {
        timer -= 1;
    }
}

- (void) playTimerSound {
    // User 1005 for now.  The Calendar Alert sound
    // http://iphonedevwiki.net/index.php/AudioServices
    NSLog(@"Playing Sound");
    //AudioServicesPlaySystemSound(1053);
    AudioServicesPlayAlertSound(1053);
    //SystemSoundID soundId = 1304;
    
}

- (void) clearTimer{
    [alarmTimer invalidate];
    // Enable the Start button now the timer is not running.
    [_alarmStartButton setEnabled:YES];
    
}


- (IBAction)stopButtonPressed:(id)sender {
    [self clearTimer];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Check the segue identifier
    if ([segue.identifier isEqualToString:@"setTimer"])
    {
        NSLog(@"Prepare for seque to timer");
        
        // Get the TimerSelectionController from the Seque via the NavigationController
        UINavigationController *navController = [segue destinationViewController];
        TimerSelectionController *timerSelectionController = (TimerSelectionController *)([navController viewControllers][0]);
        NSLog(@"timerSelectionController %@", timerSelectionController);
        
        // Set the delegate to this class in order to get the DatePicker value
        timerSelectionController.timerSelectionDelegate = self;
    }
}

- (void) timerSelected: (NSTimeInterval)timeInterval{
    
    NSLog(@"Timer Selected");
    
    NSLog(@"Date picker time interval %f", timeInterval);

    NSLog(@"Timer value before: %f", timeInterval);
    
    timer = timeInterval;
    
    [self setTimerLabel];
}

- (void) setTimerLabel{
    int hours;
    int minutes;
    int seconds;
    int r;
    
    //NSLog(@"Timer value before: %f", timeInterval);
    
    // Parse timer to readable format
    hours = timer / (60*60);
    r = timer - (hours * 60*60);
    minutes = r / (60);
    r = r - (minutes * 60);
    seconds = r;
    
    _timerLabel.text = [NSString stringWithFormat:@"%d:%d:%d", hours, minutes, seconds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
