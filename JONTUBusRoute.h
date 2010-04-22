//
//  JONTUBusRoute.h
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JONTUBusRoute : NSObject {
	NSUInteger routeid;
	NSString *name;
	NSArray *stops;
}
-(id)initWithID:(NSUInteger)rid name:(NSString *)rname stops:(NSArray *)busstops;

@property (readonly) NSUInteger routeid;
@property (readonly) NSString *name;
@property (readonly) NSArray *stops;

@end
