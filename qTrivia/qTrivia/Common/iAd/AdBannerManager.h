//
//  AdBannerManager.h
//
//  Created by haarryy16 on 5/31/13.
//  Copyright (c) 2013 Harry Cabamalan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class iAdView;
@interface AdBannerManager : NSObject
@property (nonatomic, strong) iAdView *iAdBanner;
/**
 * create a singleton of AdBannerManager
 */
+ (AdBannerManager*)sharedManager;

/*
 *  @method addiAdInView:
 *
 *  @param the view where banner ads will appear. If view is nil, iAd will be added in defailt window
 *
 *  @discussion 
 *      AdBannerManager *adBannerMgr = [[AdBannerManager sharedManager] init];
 *      [_adBannerMgr addiAdInView:self.view];
 */
- (void)addiAdInView:(UIView*)view;
@end
