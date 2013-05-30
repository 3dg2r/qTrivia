//
//  SelectGameModeViewController.h
//  qTrivia
//
//  Created by Edgar Jan Balangue on 5/30/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectGameModeViewController : UIViewController {
    int gameModePicked;
}

@property (nonatomic,strong) NSDictionary *dictionary;

@end
