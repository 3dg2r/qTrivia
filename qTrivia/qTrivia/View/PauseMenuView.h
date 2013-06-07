//
//  PauseMenuView.h
//  qTrivia
//
//  Created by Edgar Jan Balangue on 6/7/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PauseMenuView;
@protocol PauseMenuViewDelegate <NSObject>

-(void)didPressedMenuButton:(PauseMenuView *)view;
-(void)didPressedRestartButton:(PauseMenuView *)view;
-(void)didPressedResumeButton:(PauseMenuView *)view;

@end

@interface PauseMenuView : UIView {
    CGPoint lastTouchLocation;
    CGRect originalFrame;
}

- (void)show;
- (void)hide;
@property (nonatomic) BOOL isShown;
@property (nonatomic,assign)id<PauseMenuViewDelegate>delegate;

@end
