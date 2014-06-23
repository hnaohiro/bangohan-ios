//
//  ConfigViewController.h
//  bangohan-ios
//
//  Created by Hasegawa Naohiro on 2014/06/01.
//  Copyright (c) 2014年 hnaohiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigViewController : UIViewController <UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *user;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminder;

- (IBAction)userChanged:(id)sender;
- (IBAction)reminderChanged:(id)sender;

@end
