//
//  ScoreListViewController.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/30/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "ScoreListViewController.h"
#import "CategoryListViewController.h"

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
    self.scoreLabel.text = self.score;
    self.bonusScoreLabel.text = self.bonusScore;
    int score = [self.score intValue];
    int bonusScore = [self.bonusScore intValue];
    int totScore = score + bonusScore;
    self.totalScore.text = [NSString stringWithFormat:@"%d",totScore];
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

- (void)viewDidUnload {
    [self setScoreLabel:nil];
    [self setTotalScore:nil];
    [self setBonusScoreLabel:nil];
    [super viewDidUnload];
}
@end
