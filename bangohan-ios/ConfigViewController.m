//
//  ConfigViewController.m
//  bangohan-ios
//
//  Created by Hasegawa Naohiro on 2014/06/01.
//  Copyright (c) 2014年 hnaohiro. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()
@end

@implementation ConfigViewController
{
    NSUserDefaults* userDefaults;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSInteger user_id = [userDefaults integerForKey:@"user_id"];
    
    if (user_id == 2) {
        self.user.selectedSegmentIndex = 0;
    } else if (user_id == 3) {
        self.user.selectedSegmentIndex = 1;
    } else {
        [userDefaults setInteger:2 forKey:@"user_id"];
    }
    
    NSInteger hour = [userDefaults integerForKey:@"hour"];
    NSInteger min = [userDefaults integerForKey:@"min"];
    NSString* dateString = [[NSString alloc] initWithFormat:@"%d:%d", hour, min];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H:m"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSLog(@"user_id: %d", user_id);
    NSLog(@"time:%02d:%02d", hour, min);
    
    [self.reminder setDate:date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)userChanged:(id)sender
{
    NSInteger index = [self.user selectedSegmentIndex];

    if (index == 0) {
        [userDefaults setInteger:2 forKey:@"user_id"];
    } else if (index == 1) {
        [userDefaults setInteger:3 forKey:@"user_id"];
    }
}

- (void)reminderChanged:(id)sender
{
    NSDate *date = [self.reminder date];
    
    [userDefaults setInteger:[self getHour:date] forKey:@"hour"];
    [userDefaults setInteger:[self getMin:date] forKey:@"min"];
}

- (NSInteger)getHour:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    return [components hour];
}

- (NSInteger)getMin:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    return [components minute];
}

@end
