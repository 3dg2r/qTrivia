//
//  ScoreListViewController.h
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/30/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveToLeaderboardView.h"
#import "FMDBManager.h"
#import "LeaderboardCell.h"

@interface ScoreListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,SaveToLeaderboardViewDelegate> {
    int totScore;
}
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic,copy) NSString *score;
@property (nonatomic) int gameMode;
@property (nonatomic,copy) NSString *bonusScore;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain)NSDictionary *categoryDic;
@property (nonatomic,retain) NSMutableDictionary *dicToBeSave;
@property (nonatomic,retain) NSArray *arrayOfScores;
@end
