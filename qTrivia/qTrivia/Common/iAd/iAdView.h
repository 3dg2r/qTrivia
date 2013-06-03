//
//  iAdView.h
//
//  Created by haarryy16 on 5/31/13.
//  Copyright (c) 2013 Harry Cabamalan. All rights reserved.
//

#import <iAd/iAd.h>

#define qLogs                   1
#define qDidFailToReceiveAds    @"didFailToReceiveAds"
#define qDidReceiveAds          @"didReceiveAds"
#define qDidFinishAdsAction     @"didFinishAdsAction"
#define qWillLoadAds            @"willLoadAds"
#define qWillStartAction        @"willStartAction"
#define iAD_RECT                CGRectMake(0, 430, 320, 50)

@interface iAdView : UIView <ADBannerViewDelegate>

@end
