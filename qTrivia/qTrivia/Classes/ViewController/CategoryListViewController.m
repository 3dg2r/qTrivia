//
//  CategoryListViewController.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/25/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "CategoryListViewController.h"
#import "PlistHelper.h"
#import "CategoryListCell.h"
#import "SelectGameModeViewController.h"

@interface CategoryListViewController ()
@property (nonatomic,strong) NSArray *categoryList;
@end

@implementation CategoryListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.categoryList = [PlistHelper getArray:@"CategoryList"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableView Delegate and Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryListCell *cell = (CategoryListCell*) [tableView dequeueReusableCellWithIdentifier: @"CellForRowInEventList"];
    
    if(cell == nil) {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"CategoryListCell" owner:nil options:nil];
        
        cell = [array objectAtIndex: 0];
    }
    cell.categoryTitle.text = [[self.categoryList objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"goToSelectGameMode" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    SelectGameModeViewController *controller = segue.destinationViewController;
    controller.dictionary = [self.categoryList objectAtIndex:indexPath.row];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
