//
//  CBTCentralControlPanelViewController.m
//  CBTest
//
//  Created by Alan Wang on 12/17/14.
//  Copyright (c) 2014 Alan Wang. All rights reserved.
//

#import "CBTCentralControlPanelViewController.h"
#import "CBTCentral.h"

@interface CBTCentralControlPanelViewController ()

@property (nonatomic) BOOL isScanning;

@end

@implementation CBTCentralControlPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isScanning = NO;
    
    self.statusTextLabel.text = self.central.centralManagerStateAsString;
    
    // Set up table view
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    // Set up KVO
    [self.central addObserver:self forKeyPath:@"discoverdPeripherals" options:0 context:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        numRows = 0;
    }
    else if (section == 1) {
        numRows = [self.central.discoveredPeripherals count];
    }
    
    return numRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    CBPeripheral *peripheral = self.central.discoveredPeripherals[indexPath.row];
    
    cell.textLabel.text = peripheral.name;
    
    return cell;
}


#pragma mark - IBActions

- (IBAction)didPressScanButton:(UIButton *)sender {
    if (!self.isScanning) {
        [self.central scanForPeripheralsWithServices:nil options:nil];
        [self.scanButton setTitle:@"Stop Scanning" forState:UIControlStateNormal];
        self.isScanning = YES;
    }
    else {
        [self.central stopScan];
        [self.scanButton setTitle:@"Scan For Devices" forState:UIControlStateNormal];
        self.isScanning = NO;
    }
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.tableView reloadData];
}

@end
