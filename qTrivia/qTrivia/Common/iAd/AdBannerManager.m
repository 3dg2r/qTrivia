//
//  AdBannerManager.m
//
//  Created by haarryy16 on 5/31/13.
//  Copyright (c) 2013 Harry Cabamalan. All rights reserved.
//

#import "AdBannerManager.h"
#import "iAdView.h"

@interface AdBannerManager ()
{
    UIView     *_windowView;
}
@end

@implementation AdBannerManager

static AdBannerManager *_adManager = nil;

+ (AdBannerManager*)sharedManager
{
    @synchronized([AdBannerManager class])
    {
        if (_adManager == nil)
            _adManager = [[self class] alloc];
        
        return _adManager;
    }
    
    return nil;
}

+ (id)alloc
{
    @synchronized([AdBannerManager class])
    {
        NSAssert(_adManager == nil, @"Attempted to allocate a second instance of singleton");
        _adManager = [super alloc];
        return _adManager;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        _windowView = [[window rootViewController] view];
        _windowView.backgroundColor = [UIColor redColor];
        _iAdBanner = [[iAdView alloc] initWithFrame:iAD_RECT];
    }
    return self;
}


- (void)addiAdInView:(UIView*)view
{
    [_iAdBanner setBackgroundColor:[UIColor clearColor]];
    if (!view)
        [_windowView addSubview:_iAdBanner];
    else
        [view addSubview:_iAdBanner];
}

@end
