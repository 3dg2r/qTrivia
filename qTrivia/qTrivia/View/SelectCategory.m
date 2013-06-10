//
//  SelectCategory.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 6/10/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "SelectCategory.h"
#import <QuartzCore/QuartzCore.h>

@implementation SelectCategory

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setUpTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.layer.borderColor = [UIColor colorWithRed:(CGFloat)(86/255.0f) green:(CGFloat)(171/255.0f) blue:(CGFloat)(8/255.0f) alpha:1].CGColor;
    self.tableView.layer.borderWidth = 4;
    [self.tableView reloadData];
}

- (void)show
{
    [self setUpTableView];
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

#pragma mark - TableView Delegate and Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryListCell *cell = (CategoryListCell*) [tableView dequeueReusableCellWithIdentifier: @"CellForRowInEventList"];
    
    if(cell == nil) {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"CategoryListCell" owner:nil options:nil];
        
        cell = [array objectAtIndex: 0];
    }
    cell.categoryTitle.text = [self.categoryList objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(didSelectCategory:andCategoryID:)]) {
        [_delegate didSelectCategory:self andCategoryID:[self.categoryList objectAtIndex:indexPath.row]];
    }
}


@end
