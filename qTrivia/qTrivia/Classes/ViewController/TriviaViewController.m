//
//  TriviaViewController.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/25/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "TriviaViewController.h"
#import "PlistHelper.h"
#import <QuartzCore/QuartzCore.h>
#import "ScoreListViewController.h"

#define TIMER 45.0f
#define NUMOFLIFE 3


@interface TriviaViewController ()
@property (nonatomic,strong) NSMutableArray *categoryArray;
@property (nonatomic,strong) NSMutableArray *categoryListAnswerArray;
@property (nonatomic,strong) NSMutableArray *answerList;
@end

@implementation TriviaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addWillStart:) name:@"willStartAction" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDidFinish:) name:@"didFinishAdsAction" object:nil];
    
    
    self.answerList = [[NSMutableArray alloc]init];
    
    self.triviaImage1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.triviaImage1.layer.borderWidth = 4;
    self.triviaImage2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.triviaImage2.layer.borderWidth = 4;
    self.triviaImage3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.triviaImage3.layer.borderWidth = 4;
    self.triviaImage4.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.triviaImage4.layer.borderWidth = 4;
    
    [self restart];
    
}

#pragma mark - ad
-(void)addWillStart:(NSNotification *)notification {
    puase = YES;
}

-(void)addDidFinish:(NSNotification *)notification {
    puase = NO;
}

#pragma mark - restart Button Pressed 

-(void)restart {
    [self.categoryArray removeAllObjects];
    NSString *categoryPlistName = [NSString stringWithFormat:@"%@_1",[self.categoryDictionary objectForKey:@"unique_id"]];
    self.categoryArray = [[PlistHelper getArray:categoryPlistName]mutableCopy];
    //shuffle category
    [self.categoryArray shuffle];
    counter = 0;
    timmerCounter = TIMER;
    streak = 1;
    score = 0;
    numOfLife = NUMOFLIFE;
    
    self.scoreLabel.text = @"0";
    
    switch (self.gameMode) {
        case GameModeTimeAttack:
            self.numberOfLifesTextLabel.hidden = YES;
            self.numberOfLife.hidden = YES;
            self.timerLabel.text = [NSString stringWithFormat:@"%.2f",timmerCounter];
            [self startCountdown];
            break;
        case GameModeSurvival:
            self.numberOfLifesTextLabel.hidden = YES;
            self.numberOfLife.hidden = YES;
            self.timerLabel.text = [NSString stringWithFormat:@"%.2f",timmerCounter];
            [self startCountdown];
            break;
        case GameModeRelax:
            self.timerLabel.hidden = YES;
            self.numberOfLife.text = [NSString stringWithFormat:@"%d",numOfLife];
            break;
        default:
            break;
    }
    
    [self setUpNewQuestion];
    puase = NO;
}
#pragma mark - set up timer

- (void)startCountdown
{
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.03
                                                 target:self
                                               selector:@selector(advanceTimer:)
                                               userInfo:nil
                                                repeats:YES];
}

- (void)advanceTimer:(NSTimer *)timer
{
    if (!puase) {
        timmerCounter -= 0.03f;
        self.timerLabel.text = [NSString stringWithFormat:@"%.2f",timmerCounter];
        if (timmerCounter <= 0) {
            [timer invalidate];
            [self performSegueWithIdentifier:@"goToScoreVC" sender:self];
        }
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ScoreListViewController *controller = segue.destinationViewController;
    controller.score = [NSString stringWithFormat:@"%d",score];
    controller.categoryDic = self.categoryDictionary;
    if (timmerCounter < 0) {
        timmerCounter = 0;
    }
    if (numOfLife < 0) {
        numOfLife = 0;
    }
    
    int bonusScore = timmerCounter;
    switch (self.gameMode) {
        case GameModeTimeAttack:
            
            controller.bonusScore = [NSString stringWithFormat:@"%d",bonusScore *10];
            break;
        case GameModeSurvival:
            controller.bonusScore = [NSString stringWithFormat:@"%d",bonusScore *10];
            break;
        case GameModeRelax:
            controller.bonusScore = [NSString stringWithFormat:@"%d",numOfLife *100];
            
            break;
        default:
            break;
    }
    
}


#pragma mark - setup arrays

-(void)setUpNewQuestion {
    if (counter == self.categoryArray.count) {
        [self performSegueWithIdentifier:@"goToScoreVC" sender:self];
    }
    else {
        [self.triviaAnswer1 setBackgroundImage:[UIImage imageNamed:@"button_blueline.png"] forState:UIControlStateNormal];
        [self.triviaAnswer2 setBackgroundImage:[UIImage imageNamed:@"button_blueline.png"] forState:UIControlStateNormal];
        [self.triviaAnswer3 setBackgroundImage:[UIImage imageNamed:@"button_blueline.png"] forState:UIControlStateNormal];
        [self.triviaAnswer4 setBackgroundImage:[UIImage imageNamed:@"button_blueline.png"] forState:UIControlStateNormal];
        NSMutableArray *arrayOfImage = [[[self.categoryArray objectAtIndex:counter] objectForKey:@"image_array"]mutableCopy];
        [arrayOfImage shuffle];
        
        self.triviaImage1.image = [UIImage imageNamed:[arrayOfImage objectAtIndex:0]];
        self.triviaImage2.image = [UIImage imageNamed:[arrayOfImage objectAtIndex:1]];
        self.triviaImage3.image = [UIImage imageNamed:[arrayOfImage objectAtIndex:2]];
        self.triviaImage4.image = [UIImage imageNamed:[arrayOfImage objectAtIndex:3]];
        [self setUpAnswerArrays];
        counter ++;
    }
}

-(void)setUpAnswerArrays {
    [self.answerList removeAllObjects];
    NSString *categoryListAnswerPlistName = [NSString stringWithFormat:@"%@Answer_1",[self.categoryDictionary objectForKey:@"unique_id"]];
    self.categoryListAnswerArray = [[PlistHelper getArray:categoryListAnswerPlistName]mutableCopy];
    
    NSInteger indexOfAnswer = [[[self.categoryArray objectAtIndex:counter] objectForKey:@"key_answer"] integerValue];
    NSDictionary *dicOfAnswer = [self.categoryListAnswerArray objectAtIndex:indexOfAnswer];
    [self.answerList addObject:dicOfAnswer];
    [self.categoryListAnswerArray removeObjectAtIndex:indexOfAnswer];
    
    [self.categoryListAnswerArray shuffle];
    for(int i = 0; i < 3; i++) {
        NSDictionary *dic = [self.categoryListAnswerArray objectAtIndex:i];
        [self.answerList addObject:dic];
    }
    [self.answerList shuffle];
    [self.triviaAnswer1 setTitle:[[self.answerList objectAtIndex:0] objectForKey:@"name"] forState:UIControlStateNormal];
    [self.triviaAnswer2 setTitle:[[self.answerList objectAtIndex:1] objectForKey:@"name"] forState:UIControlStateNormal];
    [self.triviaAnswer3 setTitle:[[self.answerList objectAtIndex:2] objectForKey:@"name"] forState:UIControlStateNormal];
    [self.triviaAnswer4 setTitle:[[self.answerList objectAtIndex:3] objectForKey:@"name"] forState:UIControlStateNormal];
}

#pragma mark - button pressed

- (IBAction)menuButtonPressed:(id)sender {
    puase = YES;
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"PauseMenuView" owner:nil options:nil];
    PauseMenuView * popupView = [array objectAtIndex: 0];
    popupView.delegate = self;
    popupView.tag = 1;
    popupView.frame = self.view.frame;
    popupView.center = self.view.center;
    [self.view addSubview:popupView];
    [popupView show];
}

#pragma mark - pause menu delegate 

-(void)didPressedResumeButton:(PauseMenuView *)view {
    [view removeFromSuperview];
    puase = NO;
}

-(void)didPressedRestartButton:(PauseMenuView *)view {
    [view removeFromSuperview];
    [self restart];
}

-(void)didPressedMenuButton:(PauseMenuView *)view {
    [view removeFromSuperview];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)answerPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger buttonTag = button.tag - 100;
    NSDictionary *dic = [self.answerList objectAtIndex:buttonTag];
    NSInteger keyOfAnswerPicked = [[dic objectForKey:@"id"] integerValue];
    NSInteger indexOfAnswer = [[[self.categoryArray objectAtIndex:counter-1] objectForKey:@"key_answer"] integerValue];
    if (indexOfAnswer == keyOfAnswerPicked) {
        switch (self.gameMode) {
            case GameModeSurvival:
                timmerCounter += 2.0f;
                break;
            default:
                break;
        }
        [button setBackgroundImage:[UIImage imageNamed:@"button_blue.png"] forState:UIControlStateHighlighted];
        score += 10*streak;
        self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
        streak += 1;
    }
    else {
        streak = 1;
        [button setBackgroundImage:[UIImage imageNamed:@"button_red.png"] forState:UIControlStateHighlighted];
        switch (self.gameMode) {
            case GameModeTimeAttack:
                timmerCounter -= 1.0f;
                break;
            case GameModeSurvival:
                timmerCounter -= 1.0f;
                break;
            case GameModeRelax:
                numOfLife -= 1;
                if (numOfLife == 0) {
                    [self performSegueWithIdentifier:@"goToScoreVC" sender:self];
                }
                else if (numOfLife == 1) {
                    self.skipButton.hidden = YES;
                }
                self.numberOfLife.text = [NSString stringWithFormat:@"%d",numOfLife];
                break;
            default:
                break;
        }
    }
    [self setUpNewQuestion];
}

- (void)viewDidUnload {
    [self setTriviaImage1:nil];
    [self setTriviaImage2:nil];
    [self setTriviaImage3:nil];
    [self setTriviaImage4:nil];
    [self setTriviaAnswer1:nil];
    [self setTriviaAnswer2:nil];
    [self setTriviaAnswer3:nil];
    [self setTriviaAnswer4:nil];
    [self setTimerLabel:nil];
    [self setScoreLabel:nil];
    [self setNumberOfLifesTextLabel:nil];
    [self setNumberOfLife:nil];
    [self setSkipButton:nil];
    [super viewDidUnload];
}
@end
