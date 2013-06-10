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
    self.categoryList = [PlistHelper getArray:@"CategoryList"];
    self.arrayOfScores = [[FMDBManager getAllScores]mutableCopy];
    [self.tableView reloadData];
	// Do any additional setup after loading the view.
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Select category button and delegate
- (IBAction)selectCategoryButtonPressed:(id)sender {
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

-(void)didSelectCategory:(SelectCategory *)view andCategoryID:(NSString *)title {
    [self.categoryButton setTitle:title forState:UIControlStateNormal];
    [self.arrayOfScores removeAllObjects];
    if ([title isEqualToString:@"All Category"]) {
        self.arrayOfScores = [[FMDBManager getAllScores]mutableCopy];
    }
    else {
        self.arrayOfScores = [[FMDBManager getScoreByCategory:title] mutableCopy];
    }
    [self.tableView reloadData];
    [view hide];
    [view removeFromSuperview];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    
    [self setCategoryButton:nil];
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
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}
@end
