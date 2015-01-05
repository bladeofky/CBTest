//
//  CBTPeripheralControlPanelViewController.h
//  CBTest
//
//  Created by Alan Wang on 1/5/15.
//  Copyright (c) 2015 Alan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface CBTPeripheralControlPanelViewController : UIViewController <CBPeripheralManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *advertiseButton;

- (IBAction)didPressAdvertiseButton:(UIButton *)sender;

@end
