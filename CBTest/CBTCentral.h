//
//  CBTCentral.h
//  CBTest
//
//  Created by Alan Wang on 12/17/14.
//  Copyright (c) 2014 Alan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class CBTCentralControlPanelViewController;

@interface CBTCentral : NSObject <CBCentralManagerDelegate>

@property (nonatomic, strong) NSArray *discoveredPeripherals;
@property (nonatomic, strong, readonly) NSString *centralManagerStateAsString;
@property (nonatomic, strong) CBTCentralControlPanelViewController *controlPanelViewController;

- (void)scanForPeripheralsWithServices:(NSArray *)serviceUUIDs options:(NSDictionary *)options;
- (void)stopScan;

@end
