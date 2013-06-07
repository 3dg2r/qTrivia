//
//  CommonFunctions.h
//  Winas
//
//  Created by Glenn Marintes on 12/23/12.
//  Copyright (c) 2012 Winas, Inc. All rights reserved.
//

#ifndef Winas_CommonFunctions_h
#define Winas_CommonFunctions_h

#ifdef DEBUG
#define DLog(fmt, ...) NSLog(@"%s [Line %d] " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...) ;
#endif
#define ALog(...) NSLog(__VA_ARGS__)

#endif
