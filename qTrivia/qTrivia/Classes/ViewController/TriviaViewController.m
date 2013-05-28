//
//  TriviaViewController.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/25/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "TriviaViewController.h"

@interface TriviaViewController ()

@end

@implementation TriviaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)menuButtonPressed:(id)sender {
}

- (IBAction)skipButtonPressed:(id)sender {
}

- (IBAction)answerButtonPressed:(id)sender {
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
