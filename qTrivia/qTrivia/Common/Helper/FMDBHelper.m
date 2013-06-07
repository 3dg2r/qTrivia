//
//  FMDBHelper.m
//  Winas
//
//  Created by Edgar Jan Balangue on 1/23/13.
//  Copyright (c) 2013 Winas, Inc. All rights reserved.
//

#import "FMDBHelper.h"
#import "CommonFunctions.h"


@implementation FMDBHelper

static FMDBHelper* _sharedFMDBHelper = nil;


#pragma mark - singleton
+(FMDBHelper*)sharedFMDBHelper {
    @synchronized([FMDBHelper class])
    {
        if (!_sharedFMDBHelper)
            _sharedFMDBHelper = [[self alloc]init];
        return _sharedFMDBHelper;
    }
    return nil;
}

+(id)alloc
{
    @synchronized([FMDBHelper class])
    {
        NSAssert(_sharedFMDBHelper == nil, @"Attempted to allocate a second instance of the FMDB singleton");
        _sharedFMDBHelper = [super alloc];
        return _sharedFMDBHelper;
    }
    return nil;
}

#pragma mark - DB methods

#pragma mark - - DB properties
- (NSString*) applicationDocumentsDirectory {
    //return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    // We use this because we are supporting iOS 3.2 and above
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex: 0];
}

- (NSString*) sqliteStorePathWithSqlFileName:(NSString *)name {
    NSString *string = [NSString stringWithFormat:@"%@.sqlite",name];
    return [[self applicationDocumentsDirectory] stringByAppendingPathComponent: string];
}

- (NSURL*) sqliteStoreUrlWithSqlFileName:(NSString *)name {
    return [NSURL fileURLWithPath: [self sqliteStorePathWithSqlFileName:name]];
}

#pragma mark - - Schema and DB methods
- (BOOL) openDatabaseWithFileName:(NSString *)name {
    DLog(@"Opening database at %@", [self sqliteStorePathWithSqlFileName:name]);
    self.database = [FMDatabase databaseWithPath: [self sqliteStorePathWithSqlFileName:name]];
    
    // check thread safety
    DLog(@"Is SQLite compiled with it's thread safe options turned on? %@!", [FMDatabase isSQLiteThreadSafe] ? @"Yes" : @"No");
    
    // check if db is open
    if (![_database open]) {
        ALog(@"Could not open db.");
        self.database = nil;
        return NO;
    }
    
    return YES;
}

- (void) initializeDatabaseWithXMLName:(NSString *)XMLName {
    // initialize the database schema
    // upgrading as necessary
    
    NSInteger schemaIndex = [[NSUserDefaults standardUserDefaults]integerForKey:SCHEMA_INDEX];
    schemaIndex += 1;
    
    while (true) {
        // check if the next schema file exists
        
        NSString* filename = [NSString stringWithFormat: @"%@_%d", XMLName,schemaIndex];
        NSString* schemaPath = [[NSBundle mainBundle] pathForResource: filename ofType: @"xml"];
        if (!schemaPath) break;
        
        // get the queries from the schema file
        NSArray* queryList = [NSArray arrayWithContentsOfFile: schemaPath];
        
        // execute each query, ignoring any error
        for (NSString* query in queryList) {
            BOOL result = [_database executeUpdate: query];
            if (!result) {
                DLog(@"Execute FAILED for schema %@ with sql: %@", schemaPath, query);
            }
            else {
                [[NSUserDefaults standardUserDefaults]setInteger:schemaIndex forKey:SCHEMA_INDEX];
                [[NSUserDefaults standardUserDefaults]synchronize];
                DLog(@"Execute SUCCESS for schema %@ with sql: %@", schemaPath, query);
            }
        }
        
        schemaIndex++;
    }
}

- (void) closeDatabase {
    [_database close];
}


@end
