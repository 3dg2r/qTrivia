//
//  FMDBManager.h
//  qTrivia
//
//  Created by Edgar Jan Balangue on 6/7/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBManager : NSObject

+(BOOL)addHighScoreToLeaderBoard:(NSDictionary *)dictionary;
+(NSArray*)getAllScores;
+(NSArray *)getScoreByCategory:(NSString *)category;
@end
