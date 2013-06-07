//
//  TriviaViewController.h
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/25/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSMutableArray+Shuffling.h"
#import "PauseMenuView.h"

typedef enum {
	GameModeTimeAttack = 0,
	GameModeSurvival,
	GameModeRelax,
} GameMode;

@interface TriviaViewController : UIViewController <PauseMenuViewDelegate>{
    int counter,streak,score,numOfLife;
    float timmerCounter;
    NSTimer *gameTimer;
    BOOL puase;
}

@property (strong, nonatomic) NSDictionary *categoryDictionary;

@property (weak, nonatomic) IBOutlet UIImageView *triviaImage1;
@property (weak, nonatomic) IBOutlet UIImageView *triviaImage2;
@property (weak, nonatomic) IBOutlet UIImageView *triviaImage3;
@property (weak, nonatomic) IBOutlet UIImageView *triviaImage4;

@property (weak, nonatomic) IBOutlet UIButton *triviaAnswer1;
@property (weak, nonatomic) IBOutlet UIButton *triviaAnswer2;
@property (weak, nonatomic) IBOutlet UIButton *triviaAnswer3;
@property (weak, nonatomic) IBOutlet UIButton *triviaAnswer4;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLifesTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLife;

@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (nonatomic) GameMode gameMode;
@end
