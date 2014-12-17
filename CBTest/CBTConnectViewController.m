//
//  CBTConnectViewController.m
//  CBTest
//
//  Created by Alan Wang on 12/17/14.
//  Copyright (c) 2014 Alan Wang. All rights reserved.
//

#import "CBTConnectViewController.h"
#import "CBTCentral.h"
#import "CBTCentralControlPanelViewController.h"

@interface CBTConnectViewController ()

@end

@implementation CBTConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)didPressConnectAsCentralButton:(UIButton *)sender {
    
    // Perform necessary setup for CBCentralManager
    CBTCentral *central = [[CBTCentral alloc]init];
    
    [self.navigationController pushViewController:central.controlPanelViewController animated:YES];
    
}

- (IBAction)didPressConnectAsPeripheralButton:(UIButton *)sender {
}
@end
