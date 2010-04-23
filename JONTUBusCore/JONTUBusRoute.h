//
//  JONTUBusRoute.h
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JONTUBusRoute : NSObject <NSXMLParserDelegate> {
	NSUInteger routeid;
	NSString *name;
	NSMutableArray *stops;
	NSDate *lastGetStops;
	
}
-(id)initWithID:(NSUInteger)rid name:(NSString *)rname stops:(NSArray *)busstops;

-(NSArray *)stopsWithRefresh:(BOOL)refresh;
-(NSArray *)stops;

@property (readonly) NSUInteger routeid;
@property (readonly) NSString *name;

@end
