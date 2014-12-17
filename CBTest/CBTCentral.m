//
//  CBTCentral.m
//  CBTest
//
//  Created by Alan Wang on 12/17/14.
//  Copyright (c) 2014 Alan Wang. All rights reserved.
//

#import "CBTCentral.h"
#import "CBTCentralControlPanelViewController.h"

@interface CBTCentral ()

@property (nonatomic, strong) CBCentralManager *centralManager;

@end

@implementation CBTCentral

#pragma mark - Accessors

-(CBCentralManager *)centralManager
{
    if (!_centralManager) {
        _centralManager = [[CBCentralManager alloc]initWithDelegate:self
                                                              queue:nil
                                                            options:nil];
    }
    
    return _centralManager;
}

-(NSString *)centralManagerStateAsString
{
    NSString *output;
    
    if (!self.centralManager) {
        output = @"Central Manager does not exist";
    }
    else {
        switch (self.centralManager.state) {
            case CBCentralManagerStateUnknown:
                output = @"State unknown, update imminent.";
                break;
            case CBCentralManagerStatePoweredOn:
                output = @"Bluetooth is currently powered on and availble to use.";
                break;
            case CBCentralManagerStatePoweredOff:
                output = @"Blueotth is currently powered off.";
                break;
            case CBCentralManagerStateResetting:
                output = @"The connection with the system service was momentarily lost, update imminent.";
                break;
            case CBCentralManagerStateUnauthorized:
                output = @"The application is not authorized to use the Bluetooth Low Energy Central/Client role.";
                break;
            case CBCentralManagerStateUnsupported:
                output = @"The platfrom does not suppor thte Bluetooth Low Energy Central/Client role.";
                break;
            default:
                output = @"CBManagerState not recognized.";
                break;
        }
    }
    
    return output;
}

-(CBTCentralControlPanelViewController *)controlPanelViewController
{
    if (!_controlPanelViewController) {
        _controlPanelViewController = [[CBTCentralControlPanelViewController alloc]init];
        _controlPanelViewController.central = self;
    }
    
    return _controlPanelViewController;
}

#pragma mark - CBCentralManagerDelegate
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"Central manager did update state");
}

@end
