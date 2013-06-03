//
//  iAdView.m
//
//  Created by haarryy16 on 5/31/13.
//  Copyright (c) 2013 Harry Cabamalan. All rights reserved.
//

#import "iAdView.h"

@interface iAdView ()
{
    ADBannerView    *_adBannerView;
    BOOL            _isAdBannerVisible;
}
@end

@implementation iAdView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _adBannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _adBannerView.delegate = self;
        _adBannerView.backgroundColor = [UIColor clearColor];
        [self addSubview:_adBannerView];
    }
    return self;
}

#pragma mark - AdViewDelegates

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (qLogs)
        NSLog(@"failed to receive iad with error:%@",error);
    [[NSNotificationCenter defaultCenter] postNotificationName:qDidFailToReceiveAds object:nil];
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (qLogs)
        NSLog(@"loaded banner ad: %@",banner);
    [[NSNotificationCenter defaultCenter] postNotificationName:qDidReceiveAds object:nil];
}
-(void)bannerViewWillLoadAd:(ADBannerView *)banner
{
    if (qLogs)
        NSLog(@"banner ad will load");
    [[NSNotificationCenter defaultCenter] postNotificationName:qWillLoadAds object:nil];
}
-(void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    if (qLogs)
        NSLog(@"banner ad did finish action");
    [[NSNotificationCenter defaultCenter] postNotificationName:qDidFinishAdsAction object:nil];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    if (qLogs)
        NSLog(@"banner should begin action");
    [[NSNotificationCenter defaultCenter] postNotificationName:qWillStartAction object:nil];
    return YES;
}

@end
