//
//  CBTCentralControlPanelViewController.m
//  CBTest
//
//  Created by Alan Wang on 12/17/14.
//  Copyright (c) 2014 Alan Wang. All rights reserved.
//

#import "CBTCentralControlPanelViewController.h"
#import "CBTPeripheralTableViewController.h"

@interface CBTCentralControlPanelViewController ()

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic) BOOL isScanning;

@property (nonatomic, strong) NSArray *connectedPeripherals;
@property (nonatomic, strong) NSOrderedSet *discoveredPeripherals;

@end

@implementation CBTCentralControlPanelViewController

#pragma mark - Accessors
-(CBCentralManager *)centralManager
{
    if (!_centralManager) {
        _centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil options:nil];
    }
    
    return _centralManager;
}

-(NSOrderedSet *)discoveredPeripherals
{
    if (!_discoveredPeripherals) {
        _discoveredPeripherals = [[NSOrderedSet alloc]init];;
    }
    
    return _discoveredPeripherals;
}

-(NSArray *)connectedPeripherals
{
    if (!_connectedPeripherals) {
        _connectedPeripherals = @[];
    }
    
    return _connectedPeripherals;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isScanning = NO;
    
    self.statusTextLabel.text = self.centralManagerStateAsString;
    
    // Set up table view
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Model
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
                output = @"Bluetooth is currently powered on and available to use.";
                break;
            case CBCentralManagerStatePoweredOff:
                output = @"Bluetooth is currently powered off.";
                break;
            case CBCentralManagerStateResetting:
                output = @"The connection with the system service was momentarily lost, update imminent.";
                break;
            case CBCentralManagerStateUnauthorized:
                output = @"The application is not authorized to use the Bluetooth Low Energy Central/Client role.";
                break;
            case CBCentralManagerStateUnsupported:
                output = @"The platform does not support the Bluetooth Low Energy Central/Client role.";
                break;
            default:
                output = @"CBManagerState not recognized.";
                break;
        }
    }
    
    return output;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRows;
    
    if (section == 0) {
        numRows = [self.connectedPeripherals count];
    }
    else if (section == 1) {
        numRows = [self.discoveredPeripherals count];
    }
    
    return numRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    CBPeripheral *peripheral;
    
    if (indexPath.section == 0) {
        peripheral = [self.connectedPeripherals objectAtIndex:indexPath.row];
    }
    else {
        peripheral = [self.discoveredPeripherals objectAtIndex:indexPath.row];
    }
    
    if (peripheral.name) {
        cell.textLabel.text = peripheral.name;
    }
    else {
        cell.textLabel.text = [peripheral.identifier UUIDString];
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *output;
    
    if (section == 0) {
        output = @"Connected Devices";
    }
    else {
        output = @"Discovered Devices";
    }
    
    return output;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CBTPeripheralTableViewController *peripheralTableVC = [[CBTPeripheralTableViewController alloc]init];
        peripheralTableVC.peripheral = self.connectedPeripherals[indexPath.row];
        [self.navigationController pushViewController:peripheralTableVC animated:YES];
    }
    else {
        CBPeripheral *peripheral = self.discoveredPeripherals[indexPath.row];
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

#pragma mark - IBActions

- (IBAction)didPressScanButton:(UIButton *)sender {
    if (!self.isScanning) {
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
        NSLog(@"Began scanning for peripherals");
        [self.scanButton setTitle:@"Stop Scanning" forState:UIControlStateNormal];
        self.isScanning = YES;
    }
    else {
        [self.centralManager stopScan];
        NSLog(@"Stopped scanning for peripherals");
        [self.scanButton setTitle:@"Scan For Devices" forState:UIControlStateNormal];
        self.isScanning = NO;
    }
}

#pragma mark - CBCentralManagerDelegate
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    self.statusTextLabel.text = [self centralManagerStateAsString];
    NSLog(@"Central Manager updated state to: %@", [self centralManagerStateAsString]);
}

-(void)centralManager:(CBCentralManager *)central
didDiscoverPeripheral:(CBPeripheral *)peripheral
    advertisementData:(NSDictionary *)advertisementData
                 RSSI:(NSNumber *)RSSI
{
    NSMutableOrderedSet *tempSet = [self.discoveredPeripherals mutableCopy];
    
    [tempSet addObject:peripheral];
    
    self.discoveredPeripherals = [tempSet copy];
    [self.tableView reloadData];
    
    NSLog(@"Discovered %@",peripheral.name);
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSMutableOrderedSet *tempDiscoveredPeripherals = [self.discoveredPeripherals mutableCopy];
    NSMutableArray *tempConnectedPeripherals = [self.connectedPeripherals mutableCopy];
    
    [tempDiscoveredPeripherals removeObject:peripheral];
    [tempConnectedPeripherals addObject:peripheral];
    
    self.discoveredPeripherals = [tempDiscoveredPeripherals copy];
    self.connectedPeripherals = [tempConnectedPeripherals copy];
    
    [self.tableView reloadData];
    
    NSLog(@"Successfully connected to peripheral: %@", peripheral.name);

}

-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSMutableOrderedSet *tempDiscoveredPeripherals = [self.discoveredPeripherals mutableCopy];
    NSMutableArray *tempConnectedPeripherals = [self.connectedPeripherals mutableCopy];
    
    [tempConnectedPeripherals removeObject:peripheral];
    [tempDiscoveredPeripherals addObject:peripheral];
    
    self.connectedPeripherals = [tempConnectedPeripherals copy];
    self.discoveredPeripherals = [tempDiscoveredPeripherals copy];
    
    [self.tableView reloadData];
    
    NSLog(@"Disconnected from peripheral: %@", peripheral.name);
}

@end
