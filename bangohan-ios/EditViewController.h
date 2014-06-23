//
//  EditViewController.h
//  bangohan-ios
//
//  Created by Hasegawa Naohiro on 2014/06/01.
//  Copyright (c) 2014年 hnaohiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *time;
@property (strong, nonatomic) IBOutlet UISegmentedControl *need;

- (IBAction)send:(id)sender;

@end
