//
//  TriviaViewController.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/25/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "TriviaViewController.h"
#import "PlistHelper.h"

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
    [self setUpNewQuestion];
}

-(void)setUpNewQuestion {
    [self setUpAnswerArrays];
    counter ++;
}

-(void)setUpAnswerArrays {
    [self.answerList removeAllObjects];
    NSString *categoryListAnswerPlistName = [NSString stringWithFormat:@"%@Answer_1",[self.categoryDictionary objectForKey:@"unique_id"]];
    self.categoryListAnswerArray = [[PlistHelper getArray:categoryListAnswerPlistName]mutableCopy];
    
    NSInteger indexOfAnswer = [[[self.categoryArray objectAtIndex:counter] objectForKey:@"key_answer"] integerValue];
    NSDictionary *dicOfAnswer = [self.categoryListAnswerArray objectAtIndex:indexOfAnswer];
    [self.answerList addObject:dicOfAnswer];
    [self.categoryListAnswerArray removeObjectAtIndex:indexOfAnswer];
    
    int ar[self.categoryListAnswerArray.count-1],i,d,tmp;
    for(i = 0; i < self.categoryListAnswerArray.count-1; i++) ar[i] = i+1;
    for(i = 0; i < 3; i++) {
        d = i + (arc4random()%(self.categoryListAnswerArray.count-i));
        tmp = ar[i];
        ar[i] = ar[d];
        ar[d] = tmp;
        NSDictionary *dic = [self.categoryListAnswerArray objectAtIndex:ar[i]];
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
}

- (IBAction)answerButtonPressed:(id)sender {
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
    [super viewDidUnload];
}
@end
