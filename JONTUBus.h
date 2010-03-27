//
//  JONTUBus.h
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JONTUBus : NSObject {
	NSString *routename;
	NSUInteger *id;
	NSString *busPlate;
	NSNumber *lat;
	NSNumber *lon;
	NSUInteger speed;
	BOOL hide;
	NSNumber *iscdistance;
}

@end
