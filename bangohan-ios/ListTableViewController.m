//
//  ListTableViewController.m
//  bangohan-ios
//
//  Created by Hasegawa Naohiro on 2014/06/01.
//  Copyright (c) 2014年 hnaohiro. All rights reserved.
//

#import "ListTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ListTableViewController ()
@end

@implementation ListTableViewController
{
    id users;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    users = nil;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
}

- (void)viewDidAppear:(BOOL)animated
{
    [self fetchUsers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    
    UILabel *name = (UILabel*)[cell viewWithTag:1];
    UILabel *time = (UILabel*)[cell viewWithTag:2];
    
    id user = users[indexPath.row];
    BOOL defined = [[user objectForKey:@"defined"] boolValue];
    BOOL need = [[user objectForKey:@"need"] boolValue];
    UIColor* color;
    
    if (defined) {
        if (need) {
            NSInteger hour = [[user objectForKey:@"hour"] integerValue];
            NSInteger min = [[user objectForKey:@"min"] integerValue];
            time.text = [NSString stringWithFormat:@"%02d : %02d", hour, min];
            
            color = [UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1];
        } else {
            time.text = @"";
            color = [UIColor colorWithRed:0.906 green:0.298 blue:0.235 alpha:1];
        }
    } else {
        time.text = @"";
        color = [UIColor colorWithRed:0.498 green:0.549 blue:0.552 alpha:1];
    }
    
    name.text = [user objectForKey:@"name"];
    name.textColor = color;
    time.textColor = color;
    
    return cell;
}

- (void)fetchUsers
{
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"Logding...";
    [hud show:YES];
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    NSString* url = @"http://bangohan.herokuapp.com/users.json" ;
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        users = responseObject;
        [self.tableView reloadData];
        [hud hide:YES];
        
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
