//
//  LeaderboardViewController.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 6/7/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "LeaderboardViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LeaderboardViewController ()

@end

@implementation LeaderboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)(86/255.0f) green:(CGFloat)(171/255.0f) blue:(CGFloat)(8/255.0f) alpha:1].CGColor;
    self.tableView.layer.borderWidth = 4;
    self.tableView.layer.cornerRadius = 5;
	// Do any additional setup after loading the view.
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
