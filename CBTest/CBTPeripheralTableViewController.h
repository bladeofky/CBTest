//
//  CBTPeripheralTableViewController.h
//  CBTest
//
//  Created by Alan Wang on 1/5/15.
//  Copyright (c) 2015 Alan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface CBTPeripheralTableViewController : UITableViewController <CBPeripheralDelegate>

@property (nonatomic, strong) CBPeripheral *peripheral;

@end
