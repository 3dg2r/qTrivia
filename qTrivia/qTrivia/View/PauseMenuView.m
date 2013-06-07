//
//  PauseMenuView.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 6/7/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "PauseMenuView.h"

@implementation PauseMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - button pressed action

- (IBAction)didPressedMenuButton:(id)sender {
    [self hide];
    if ([_delegate respondsToSelector:@selector(didPressedMenuButton:)]) {
        [_delegate didPressedMenuButton:self];
    }
}

- (IBAction)didPressedRestartButton:(id)sender {
    [self hide];
    if ([_delegate respondsToSelector:@selector(didPressedRestartButton:)]) {
        [_delegate didPressedRestartButton:self];
    }
}
- (IBAction)didPressedResumeButton:(id)sender {
    [self hide];
    if ([_delegate respondsToSelector:@selector(didPressedResumeButton:)]) {
        [_delegate didPressedResumeButton:self];
    }
}

#pragma mark - animations

- (void)show
{
    self.isShown = YES;
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.alpha = 0;
    [UIView beginAnimations:@"showAlert" context:nil];
    [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 1;
    [UIView commitAnimations];
}

- (void)hide
{
    self.isShown = NO;
    [UIView beginAnimations:@"hideAlert" context:nil];
    [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.alpha = 0;
    [UIView commitAnimations];
}

- (void)toggle
{
    if (_isShown) {
        [self hide];
    } else {
        [self show];
    }
}

#pragma mark Animation delegate

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"showAlert"]) {
        if (finished) {
            [UIView beginAnimations:nil context:nil];
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            [UIView commitAnimations];
        }
    } else if ([animationID isEqualToString:@"hideAlert"]) {
        if (finished) {
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.frame = originalFrame;
        }
    }
}


@end
