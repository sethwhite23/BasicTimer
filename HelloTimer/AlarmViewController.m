//
//  AlarmViewController.m
//  HelloTimer
//
//  Created by Seth White on 3/2/16.
//  Copyright © 2016 Seth White. All rights reserved.
//

#import "AlarmViewController.h"
#import "TimerSelectionController.h"

@interface AlarmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *alarmStartButton;
@property (weak, nonatomic) IBOutlet UIButton *alarmStopButton;

@end

NSTimeInterval timer = 0;
NSTimer *alarmTimer;


@implementation AlarmViewController

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
    
    // Disable the Start button while the timer is running
    [_alarmStartButton setEnabled:NO];
}

- (void) updateTimer{
    timer -= 1;
    [self setTimerLabel];
    
    if (timer < 1){
        [self clearTimer];
    }
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
    timer = timeInterval;
    
    [self setTimerLabel];
}

- (void) setTimerLabel{
    int hours = timer / (60 * 60);
    int minutes = (timer - (hours * 60 * 60) ) / 60;
    
    NSLog(@"Set Timer Hours: %d", hours);
    NSLog(@"Set Timer Minutes: %d", minutes);
    
    _timerLabel.text = [NSString stringWithFormat:@"%d:%d", hours, minutes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
