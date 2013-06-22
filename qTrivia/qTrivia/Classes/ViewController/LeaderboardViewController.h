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
@interface LeaderboardViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,SelectCategoryDelegate> {
    BOOL isCategory;
    int gameMOde;
    NSString *categoryID;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *arrayOfScores;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIButton *gameModeButton;

@property (nonatomic,retain) NSArray *categoryList;
@property (nonatomic,retain) NSArray *gameModeList;
@end
