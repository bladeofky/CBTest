//
//  CBTCentralControlPanelViewController.h
//  CBTest
//
//  Created by Alan Wang on 12/17/14.
//  Copyright (c) 2014 Alan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface CBTCentralControlPanelViewController : UIViewController <UITableViewDataSource, CBCentralManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *statusTextLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;


- (IBAction)didPressScanButton:(UIButton *)sender;

@end
