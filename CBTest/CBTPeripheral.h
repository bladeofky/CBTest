//
//  CBTPeripheral.h
//  CBTest
//
//  Created by Alan Wang on 12/17/14.
//  Copyright (c) 2014 Alan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

/*!
 This class manages all aspects related to setting up and running the peripheral manager and using the device as a peripheral device for Bluetooth communications.
 */
@interface CBTPeripheral : NSObject <CBPeripheralManagerDelegate>

-(void)setupPeripheralandAdvertiseService;

@end
