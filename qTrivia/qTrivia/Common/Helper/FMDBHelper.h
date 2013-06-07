//
//  FMDBHelper.h
//  Winas
//
//  Created by Edgar Jan Balangue on 1/23/13.
//  Copyright (c) 2013 Winas, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

#define SCHEMA_INDEX    @"schemaIndex"

@interface FMDBHelper : NSObject

+(FMDBHelper*)sharedFMDBHelper;

- (BOOL) openDatabaseWithFileName:(NSString *)name;
- (void) initializeDatabaseWithXMLName:(NSString *)XMLName;
- (void) closeDatabase;

@property (nonatomic, retain) FMDatabase* database;

@end
