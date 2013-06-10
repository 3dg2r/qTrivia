//
//  LeaderboardViewController.h
//  qTrivia
//
//  Created by Edgar Jan Balangue on 6/7/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeaderboardCell.h"
#import "FMDBManager.h"
#import "SelectCategory.h"
#import "PlistHelper.h"
@interface LeaderboardViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,SelectCategoryDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *arrayOfScores;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;

@property (nonatomic,retain) NSArray *categoryList;
@end
