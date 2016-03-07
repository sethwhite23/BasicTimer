//
//  TimerSelectionController.m
//  HelloTimer
//
//  Created by Seth White on 3/5/16.
//  Copyright © 2016 Seth White. All rights reserved.
//

#import "TimerSelectionController.h"

@interface TimerSelectionController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *timerSelectionDatePicker;

@end

@implementation TimerSelectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Timer Selection Controller Did Load");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    NSLog(@"Done Button Pressed");
    [self.timerSelectionDelegate timerSelected:_timerSelectionDatePicker.countDownDuration];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
