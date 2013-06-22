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
    totScore = score + bonusScore;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",totScore];
    
    self.tableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)(86/255.0f) green:(CGFloat)(171/255.0f) blue:(CGFloat)(8/255.0f) alpha:1].CGColor;
    self.tableView.layer.borderWidth = 4;
    self.tableView.layer.cornerRadius = 5;
    self.dicToBeSave = [[NSMutableDictionary alloc]init];
    [self.dicToBeSave setObject:[self.categoryDic objectForKey:@"title"] forKey:@"category_id"];
    [self.dicToBeSave setObject:[NSString stringWithFormat:@"%d",totScore] forKey:@"score"];
    NSNumber *gameMode = [NSNumber numberWithInt:self.gameMode];
    self.arrayOfScores = [FMDBManager getScoreByCategory:[self.categoryDic objectForKey:@"title"] andGameMode:gameMode];
    [self.tableView reloadData];
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
- (IBAction)didPressedSaveToLeaderboard:(id)sender {
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"SaveToLeaderboardView" owner:nil options:nil];
    SaveToLeaderboardView * popupView = [array objectAtIndex: 0];
    popupView.delegate = self;
    popupView.tag = 1;
    popupView.frame = self.view.frame;
    popupView.center = self.view.center;
    [self.view addSubview:popupView];
    [popupView show];
}

#pragma mark - SaveToLeaderBoardView delegate

-(void)didPressedSubmitButton:(SaveToLeaderboardView *)view andName:(NSString *)name {
   
    NSString *nameOfUser = [name copy];
    [self.dicToBeSave setObject:nameOfUser forKey:@"name"];
    NSNumber *numberOfScore = [NSNumber numberWithInt:totScore];
    NSNumber *gameMode = [NSNumber numberWithInt:self.gameMode];
    if ([FMDBManager addHighScoreToLeaderBoard:self.dicToBeSave withScore:numberOfScore andGameMode:gameMode]) {
        self.arrayOfScores = [FMDBManager getScoreByCategory:[self.categoryDic objectForKey:@"title"]andGameMode:gameMode];
        [self.tableView reloadData];
    }
    [view removeFromSuperview];
}

-(void)didPressedBackButton:(SaveToLeaderboardView *)view {
    [view removeFromSuperview];
}

#pragma mark - UITableView Delegate and Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfScores.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeaderboardCell *cell = (LeaderboardCell*) [tableView dequeueReusableCellWithIdentifier: @"CellForRowInLeaderboardList"];
    
    if(cell == nil) {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"LeaderboardCell" owner:nil options:nil];
        
        cell = [array objectAtIndex: 0];
    }
    cell.scoreLabel.text = [[[self.arrayOfScores objectAtIndex:indexPath.row]objectForKey:@"score"] stringValue];
    cell.nameLabel.text = [[self.arrayOfScores objectAtIndex:indexPath.row]objectForKey:@"name"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}

- (void)viewDidUnload {
    [self setScoreLabel:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
