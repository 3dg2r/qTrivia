//
//  SaveToLeaderboardView.h
//  qTrivia
//
//  Created by Edgar Jan Balangue on 6/7/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SaveToLeaderboardView;
@protocol SaveToLeaderboardViewDelegate <NSObject>

-(void)didPressedSubmitButton:(SaveToLeaderboardView *)view andName:(NSString *)name;

-(void)didPressedBackButton:(SaveToLeaderboardView *)view;

@end

@interface SaveToLeaderboardView : UIView <UITextFieldDelegate>{
    CGPoint lastTouchLocation;
    CGRect originalFrame;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
- (void)show;
- (void)hide;
@property (nonatomic) BOOL isShown;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign) id<SaveToLeaderboardViewDelegate>delegate;
@end
