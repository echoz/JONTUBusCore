//
//  JONTUBusStop.h
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JONTUBusStop : NSObject {
	NSUInteger id;
	NSString *code;
	NSString *desc;
	NSString *roadName;
	NSNumber *lon;
	NSNumber *lat;
	NSArray *otherBus;
	NSArray *_routes;
}

@end
