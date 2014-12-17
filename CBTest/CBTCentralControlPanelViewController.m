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

@end

@implementation CBTCentralControlPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.statusTextLabel.text = self.central.centralManagerStateAsString;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)didPressScanButton:(UIButton *)sender {
}
@end
