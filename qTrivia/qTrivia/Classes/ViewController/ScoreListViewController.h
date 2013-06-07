//
//  ScoreListViewController.h
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/30/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *bonusScore;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
