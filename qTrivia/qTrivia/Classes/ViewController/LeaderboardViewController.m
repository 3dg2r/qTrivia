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
    isCategory = NO;
    self.categoryList = [PlistHelper getArray:@"CategoryList"];
    self.arrayOfScores = [[FMDBManager getAllScores]mutableCopy];
    self.gameModeList = [PlistHelper getArray:@"GameModeList"];
    gameMOde = -1;
    categoryID = @"All Category";
    [self.tableView reloadData];
	// Do any additional setup after loading the view.
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Select category button and delegate
- (IBAction)selectCategoryButtonPressed:(id)sender {
    isCategory = YES;
    NSMutableArray *categoryList = [[NSMutableArray alloc]init];
    [categoryList addObject:[NSString stringWithFormat:@"All Category"]];
    for (NSDictionary *dic in self.categoryList) {
        [categoryList addObject:[dic objectForKey:@"title"]];
    }
    
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"SelectCategory" owner:nil options:nil];
    SelectCategory * popupView = [array objectAtIndex: 0];
    popupView.delegate = self;
    popupView.categoryList = categoryList;
    popupView.tag = 1;
    popupView.frame = self.view.frame;
    popupView.center = self.view.center;
    [self.view addSubview:popupView];
    [popupView show];
}
- (IBAction)didPressedGameModeButton:(id)sender {
    isCategory = NO;
    NSMutableArray *game_mode_list = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.gameModeList) {
        [game_mode_list addObject:[dic objectForKey:@"title"]];
    }
    
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"SelectCategory" owner:nil options:nil];
    SelectCategory * popupView = [array objectAtIndex: 0];
    popupView.delegate = self;
    popupView.categoryList = game_mode_list;
    popupView.tag = 1;
    popupView.frame = self.view.frame;
    popupView.center = self.view.center;
    [self.view addSubview:popupView];
    [popupView show];
    
}

-(void)didSelectCategory:(SelectCategory *)view andCategoryID:(NSString *)title {
    if (isCategory) {
        [self.categoryButton setTitle:title forState:UIControlStateNormal];
        [self.arrayOfScores removeAllObjects];
        categoryID = title;
    }
    else {
        [self.gameModeButton setTitle:title forState:UIControlStateNormal];
        [self.arrayOfScores removeAllObjects];
        for (NSDictionary *dictionary in self.gameModeList) {
            NSString *titleOfGameMode = [dictionary objectForKey:@"title"];
            if ([titleOfGameMode isEqualToString:title]) {
                gameMOde = [[dictionary objectForKey:@"gameModeKey"] intValue];
                break;
            }
        }
    }

    NSNumber *game_mode = [NSNumber numberWithInt:gameMOde];
    if ([categoryID isEqualToString:@"All Category"] && gameMOde == -1) {
        self.arrayOfScores = [[FMDBManager getAllScores]mutableCopy];
    }
    else if(gameMOde == -1){
        self.arrayOfScores = [[FMDBManager getScoreByCategory:categoryID] mutableCopy];
    }
    else if ([categoryID isEqualToString:@"All Category"]) {
        self.arrayOfScores = [[FMDBManager getScoreByGameMode:game_mode] mutableCopy];
    }
    else {
        self.arrayOfScores = [[FMDBManager getScoreByCategory:categoryID andGameMode:game_mode] mutableCopy];
    }
    
    [self.tableView reloadData];
    [view hide];
    [view removeFromSuperview];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    
    [self setCategoryButton:nil];
    [self setGameModeButton:nil];
    [super viewDidUnload];
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
    cell.categoryLabel.text = [[self.arrayOfScores objectAtIndex:indexPath.row]objectForKey:@"category_id"];
    for (NSDictionary *dic in self.gameModeList) {
        NSInteger gameMode = [[dic objectForKey:@"gameModeKey"] integerValue];
        if (gameMode == [[[self.arrayOfScores objectAtIndex:indexPath.row] objectForKey:@"game_mode"] integerValue]) {
            cell.gameModeLabel.text = [dic objectForKey:@"title"];
            break;
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}
@end
