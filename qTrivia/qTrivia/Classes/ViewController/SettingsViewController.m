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
    [self.soundSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"hasSound"]];
	// Do any additional setup after loading the view.
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)switchToggle:(id)sender {
    if ([sender isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSound"];
    }
    else {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"hasSound"];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)viewDidUnload {
    [self setSoundSwitch:nil];
    [super viewDidUnload];
}
@end
