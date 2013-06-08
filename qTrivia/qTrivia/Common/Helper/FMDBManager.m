//
//  FMDBManager.m
//  qTrivia
//
//  Created by Edgar Jan Balangue on 6/7/13.
//  Copyright (c) 2013 Edgar Jan Balangue. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDBHelper.h"

@implementation FMDBManager

+(BOOL)addHighScoreToLeaderBoard:(NSDictionary *)dictionary withScore:(NSNumber*)score {
    FMDBHelper *helper = [FMDBHelper sharedFMDBHelper];
    NSString* sql = @"INSERT INTO leaderboard ("
    @"       category_id"
    @"      ,name"
    @"      ,score"
    @" )"
    @" VALUES (?,?,?)";
    return  ([helper.database executeUpdate: sql, [dictionary objectForKey:@"category_id"],[dictionary objectForKey:@"name"],score]);
    
}

+(NSArray*)getAllScores {
    FMDBHelper *helper = [FMDBHelper sharedFMDBHelper];
    NSString* sql = @"SELECT * FROM leaderboard ORDER BY score DESC";
    
    NSMutableArray* scoreArray = [NSMutableArray array];
    
    FMResultSet* rs = [helper.database executeQuery: sql];
    while ([rs next]) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        [dictionary setObject:[rs stringForColumn: @"category_id"] forKey:@"category_id"];
        [dictionary setObject:[rs stringForColumn: @"name"] forKey:@"name"];
        NSNumber *number = [NSNumber numberWithInt:[rs intForColumn: @"score"]];
        [dictionary setObject:number forKey:@"score"];
        [scoreArray addObject: dictionary];
    }
    
    return scoreArray;
}

+(NSArray *)getScoreByCategory:(NSString *)category {
    FMDBHelper *helper = [FMDBHelper sharedFMDBHelper];
    NSString* sql = @"SELECT * FROM leaderboard WHERE category_id = ? ORDER BY score DESC";
    
    NSMutableArray* scoreArray = [NSMutableArray array];
    
    FMResultSet* rs = [helper.database executeQuery: sql,category];
    while ([rs next]) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        [dictionary setObject:[rs stringForColumn: @"category_id"] forKey:@"category_id"];
        [dictionary setObject:[rs stringForColumn: @"name"] forKey:@"name"];
        NSNumber *number = [NSNumber numberWithInt:[rs intForColumn: @"score"]];
        [dictionary setObject:number forKey:@"score"];
        [scoreArray addObject: dictionary];
    }
    
    return scoreArray;
}
@end
