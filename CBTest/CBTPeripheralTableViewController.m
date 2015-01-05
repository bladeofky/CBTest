//
//  CBTPeripheralTableViewController.m
//  CBTest
//
//  Created by Alan Wang on 1/5/15.
//  Copyright (c) 2015 Alan Wang. All rights reserved.
//

#import "CBTPeripheralTableViewController.h"

@interface CBTPeripheralTableViewController ()

@property (nonatomic, strong) NSArray *services;
@property (nonatomic, strong) NSArray *characteristics;

@end

@implementation CBTPeripheralTableViewController

#pragma mark - Accessors
-(void)setPeripheral:(CBPeripheral *)peripheral
{
    _peripheral = peripheral;
    _peripheral.delegate = self;
    [_peripheral discoverServices:nil];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger numRows;
    
    if (section == 0) {
        numRows = [self.services count];
    }
    else {
        numRows = [self.characteristics count];
    }
    
    return numRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (indexPath.section == 0) {
        CBService *service = self.services[indexPath.row];
        cell.textLabel.text = [service.UUID UUIDString];
    }
    else {
        CBCharacteristic *characteristic = self.characteristics[indexPath.row];
        cell.textLabel.text = [characteristic.UUID UUIDString];
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *output;
    
    if (section == 0) {
            output = @"Services";
    }
    else {
        output = @"Characteristics";
    }
    
    return output;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CBService *service = self.services[indexPath.row];
        [self.peripheral discoverCharacteristics:nil forService:service];
    }
    else {
        CBCharacteristic *characteristic = self.characteristics[indexPath.row];
        [self.peripheral readValueForCharacteristic:characteristic];
    }
}

#pragma mark - CBPeripheralDelegate
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    else {
        self.services = peripheral.services;
        [self.tableView reloadData];
        NSLog(@"Discovered services: %@", peripheral.services);
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    else {
        self.characteristics = service.characteristics;
        [self.tableView reloadData];
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    else {
        NSString *stringFromValue = [[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        NSLog(@"Characteristic value: %@", stringFromValue);
    }
}

@end
