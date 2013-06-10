//
//  SelectCategory.h
//  qTrivia
//
//  Created by Edgar Jan Balangue on 6/10/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryListCell.h"
@class SelectCategory;
@protocol SelectCategoryDelegate  <NSObject>

-(void)didSelectCategory:(SelectCategory *)view andCategoryID:(NSString *)title;

@end

@interface SelectCategory : UIView <UITableViewDataSource,UITableViewDelegate> {
    CGPoint lastTouchLocation;
    CGRect originalFrame;
}


- (void)show;
- (void)hide;
@property (nonatomic) BOOL isShown;

@property (nonatomic,retain)NSMutableArray *categoryList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) id<SelectCategoryDelegate>delegate;
@end
