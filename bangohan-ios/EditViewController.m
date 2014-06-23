//
//  EditViewController.m
//  bangohan-ios
//
//  Created by Hasegawa Naohiro on 2014/06/01.
//  Copyright (c) 2014年 hnaohiro. All rights reserved.
//

#import "EditViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface EditViewController ()

@end

@implementation EditViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)send:(id)sender
{
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"Processing...";
    [hud show:YES];
 
    NSString* url = [[NSString alloc]initWithFormat:@"http://bangohan.herokuapp.com/users/%d.json", [self getUserId]];
    NSDictionary* param;
    
    if ([self.need selectedSegmentIndex] == 0) {
        NSDate* date = [self.time date];
        NSNumber* hour = [NSNumber numberWithInteger:[self getHour:date]];
        NSNumber* min = [NSNumber numberWithInteger:[self getMin:date]];
        
        param = @{@"hour": hour, @"min": min, @"need": @"true", @"defined": @"true"};
    } else {
        param = @{@"need": @"false", @"defined": @"true"};
    }
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    [manager PUT:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response: %@", responseObject);
        
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"Error: %@", error);
    }];
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

- (NSInteger)getUserId
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger user_id = [userDefaults integerForKey:@"user_id"];
    
    if (user_id == 0) {
        return 2;
    } else {
        return user_id;
    }
}

@end
