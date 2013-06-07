//
//  ScoreListViewController.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/30/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "ScoreListViewController.h"
#import "CategoryListViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ScoreListViewController ()

@end

@implementation ScoreListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int score = [self.score intValue];
    int bonusScore = [self.bonusScore intValue];
    int totScore = score + bonusScore;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",totScore];
    
    self.tableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)(86/255.0f) green:(CGFloat)(171/255.0f) blue:(CGFloat)(8/255.0f) alpha:1].CGColor;
    self.tableView.layer.borderWidth = 4;
    self.tableView.layer.cornerRadius = 5;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playAgainButtonPressed:(id)sender {
    CategoryListViewController *categoryController = nil;
    for (CategoryListViewController *controller in [self.navigationController viewControllers]) {
        if ([controller isKindOfClass:[CategoryListViewController class]]) {
            categoryController = controller;
            break;
        }
    }
    [self.navigationController popToViewController:categoryController animated:YES];
}
- (IBAction)goToMainMenuButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableView Delegate and Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (void)viewDidUnload {
    [self setScoreLabel:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
