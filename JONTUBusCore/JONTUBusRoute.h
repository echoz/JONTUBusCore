//
//  JONTUBusRoute.h
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import "NSXMLParserDelegateFix.h"
#endif

@interface JONTUBusRoute : NSObject <NSXMLParserDelegate, NSCoding> {
	NSUInteger routeid;
	NSString *name;
	NSMutableArray *stops;
	NSDate *lastGetStops;
	BOOL dirty;
}
-(id)initWithID:(NSUInteger)rid name:(NSString *)rname stops:(NSArray *)busstops;

-(NSArray *)stopsWithRefresh:(BOOL)refresh;
-(NSArray *)stops;

@property (readonly) NSUInteger routeid;
@property (readonly) NSString *name;
@property (readwrite) BOOL dirty;
@end
