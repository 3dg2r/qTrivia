//
//  SettingsViewController.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 6/7/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
