//
//  ScoreListViewController.h
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/30/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic,copy) NSString *score;
@end
