//
//  CBTPeripheral.m
//  CBTest
//
//  Created by Alan Wang on 12/17/14.
//  Copyright (c) 2014 Alan Wang. All rights reserved.
//

#import "CBTPeripheral.h"

@interface CBTPeripheral ()

@property (nonatomic, strong) CBPeripheralManager *peripheralManager;

@end

@implementation CBTPeripheral

#pragma mark - Accessors
- (CBPeripheralManager *)peripheralManager
{
    if (!_peripheralManager) {
        _peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self
                                                                    queue:nil
                                                                  options:nil];
    }
    
    return _peripheralManager;
}

#pragma mark - CBPeripheralManagerDelegate

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSLog(@"Peripheral manager did update state");
}


@end
