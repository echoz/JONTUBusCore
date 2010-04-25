//
//  JONTUBusStop.h
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import "NSXMLParserDelegateFix.h"
#endif

@interface JONTUBusStop : NSObject <NSXMLParserDelegate, NSCoding> {
	NSUInteger busstopid;
	NSString *code;
	NSString *desc;
	NSString *roadName;
	NSNumber *lon;
	NSNumber *lat;
	NSArray *otherBus;
	NSArray *routes;
	
	// praser setuff
	NSString *currentRouteid;
	NSString *currentRouteName;
	NSMutableArray *arrivals;
}

-(id)initWithID:(NSUInteger)stopID code:(NSString *)stopCode description:(NSString *)stopDesc roadName:(NSString *)stopRdName longtitude:(NSNumber *)stopLong latitude:(NSNumber *)stopLat otherBuses:(NSArray *)stopOtherBus;
-(NSArray *) arrivals;

@property (nonatomic, retain) NSArray *routes;

@property (readonly) NSArray *otherBus;
@property (readonly) NSUInteger busstopid;
@property (readonly) NSString *code;
@property (readonly) NSString *desc;
@property (readonly) NSString *roadName;
@property (readonly) NSNumber *lon;
@property (readonly) NSNumber *lat;

@end
