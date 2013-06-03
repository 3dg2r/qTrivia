//
//  ViewController.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/25/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "TopViewController.h"
#import "AdBannerManager.h"

@interface TopViewController ()

@end

@implementation TopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    AdBannerManager *adBanner = [[AdBannerManager sharedManager] init];
    [adBanner addiAdInView:nil];
    
}

@end
