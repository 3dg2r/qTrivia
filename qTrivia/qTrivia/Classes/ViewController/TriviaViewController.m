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

@interface TriviaViewController ()
@property (nonatomic,strong) NSArray *categoryArray;
@property (nonatomic,strong) NSMutableArray *categoryListAnswerArray;
@property (nonatomic,strong) NSMutableArray *answerList;
@end

@implementation TriviaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.answerList = [[NSMutableArray alloc]init];
    NSString *categoryPlistName = [NSString stringWithFormat:@"%@_1",[self.categoryDictionary objectForKey:@"unique_id"]];
    self.categoryArray = [PlistHelper getArray:categoryPlistName];
    //shuffle category
    self.categoryArray = [self shuffleArray:self.categoryArray];
    counter = 0;
    timmerCounter = 60.0f;
    streak = 1;
    score = 0;
    
    self.triviaImage1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.triviaImage1.layer.borderWidth = 4;
    self.triviaImage2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.triviaImage2.layer.borderWidth = 4;
    self.triviaImage3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.triviaImage3.layer.borderWidth = 4;
    self.triviaImage4.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.triviaImage4.layer.borderWidth = 4;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%.2f",timmerCounter];
    [self startCountdown];
    [self setUpNewQuestion];
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
        if (timmerCounter <= 0) { [timer invalidate]; }
    }
}



#pragma mark - setup arrays

-(void)setUpNewQuestion {
    NSArray *arrayOfImage = [[self.categoryArray objectAtIndex:counter] objectForKey:@"image_array"];
    arrayOfImage = [self shuffleArray:arrayOfImage];
    
    self.triviaImage1.image = [UIImage imageNamed:[arrayOfImage objectAtIndex:0]];
    self.triviaImage2.image = [UIImage imageNamed:[arrayOfImage objectAtIndex:1]];
    self.triviaImage3.image = [UIImage imageNamed:[arrayOfImage objectAtIndex:2]];
    self.triviaImage4.image = [UIImage imageNamed:[arrayOfImage objectAtIndex:3]];
    [self setUpAnswerArrays];
    counter ++;
}

-(void)setUpAnswerArrays {
    [self.answerList removeAllObjects];
    NSString *categoryListAnswerPlistName = [NSString stringWithFormat:@"%@Answer_1",[self.categoryDictionary objectForKey:@"unique_id"]];
    self.categoryListAnswerArray = [[PlistHelper getArray:categoryListAnswerPlistName]mutableCopy];
    
    NSInteger indexOfAnswer = [[[self.categoryArray objectAtIndex:counter] objectForKey:@"key_answer"] integerValue];
    NSLog(@"%i",indexOfAnswer);
    NSDictionary *dicOfAnswer = [self.categoryListAnswerArray objectAtIndex:indexOfAnswer];
    [self.answerList addObject:dicOfAnswer];
    [self.categoryListAnswerArray removeObjectAtIndex:indexOfAnswer];
    
    self.categoryListAnswerArray = [[self shuffleArray:self.categoryListAnswerArray]mutableCopy];
    for(int i = 0; i < 3; i++) {
        NSDictionary *dic = [self.categoryListAnswerArray objectAtIndex:i];
        [self.answerList addObject:dic];
    }
    self.answerList = [[self shuffleArray:self.answerList]mutableCopy];
    [self.triviaAnswer1 setTitle:[[self.answerList objectAtIndex:0] objectForKey:@"name"] forState:UIControlStateNormal];
    [self.triviaAnswer2 setTitle:[[self.answerList objectAtIndex:1] objectForKey:@"name"] forState:UIControlStateNormal];
    [self.triviaAnswer3 setTitle:[[self.answerList objectAtIndex:2] objectForKey:@"name"] forState:UIControlStateNormal];
    [self.triviaAnswer4 setTitle:[[self.answerList objectAtIndex:3] objectForKey:@"name"] forState:UIControlStateNormal];
}


- (NSArray *)shuffleArray:(NSArray *)array{
    NSMutableArray *listArray = [[NSMutableArray alloc]initWithArray:array];
    id temp;
    for (int x=listArray.count-1; x>=0; x--) {
        int i = 1 + arc4random() % ((array.count-1)-1);
        temp = listArray[i];
        listArray[i] = listArray[i-1];
        listArray[i-1] = temp;
    }
    return [[NSArray alloc]initWithArray:listArray];
}

#pragma mark - button pressed

- (IBAction)menuButtonPressed:(id)sender {
}

- (IBAction)skipButtonPressed:(id)sender {
    [self setUpNewQuestion];
    timmerCounter -= 0.5f;
}

- (IBAction)answerButtonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger buttonTag = button.tag - 100;
    NSDictionary *dic = [self.answerList objectAtIndex:buttonTag];
    NSInteger keyOfAnswerPicked = [[dic objectForKey:@"id"] integerValue];
    NSInteger indexOfAnswer = [[[self.categoryArray objectAtIndex:counter-1] objectForKey:@"key_answer"] integerValue];
    if (indexOfAnswer == keyOfAnswerPicked) {
        score += 10*streak;
        self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
        streak += 1;
        [self setUpNewQuestion];
    }
    else {
        streak = 1;
        timmerCounter -= 1.0f;
    }
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
    [super viewDidUnload];
}
@end
