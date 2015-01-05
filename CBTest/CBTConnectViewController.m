//
//  CBTConnectViewController.m
//  CBTest
//
//  Created by Alan Wang on 12/17/14.
//  Copyright (c) 2014 Alan Wang. All rights reserved.
//

#import "CBTConnectViewController.h"
#import "CBTCentralControlPanelViewController.h"
#import "CBTPeripheralControlPanelViewController.h"

@interface CBTConnectViewController ()

//@property (nonatomic, strong) CBTPeripheral *peripheral;

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
    
    CBTCentralControlPanelViewController *centralViewController = [[CBTCentralControlPanelViewController alloc]init];
    
    [self.navigationController pushViewController:centralViewController animated:YES];
    
}

- (IBAction)didPressConnectAsPeripheralButton:(UIButton *)sender {

    CBTPeripheralControlPanelViewController *peripheralVC = [[CBTPeripheralControlPanelViewController alloc]init];
    
    [self.navigationController pushViewController:peripheralVC animated:YES];
}
@end
