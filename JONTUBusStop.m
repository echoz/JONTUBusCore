//
//  JONTUBusStop.m
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import "JONTUBusStop.h"


@implementation JONTUBusStop

@synthesize busstopid, code, desc, roadName, lon, lat, otherBus;
@synthesize routes;

-(id)initWithID:(NSUInteger)stopID code:(NSString *)stopCode description:(NSString *)stopDesc roadName:(NSString *)stopRdName longtitude:(NSNumber *)stopLong latitude:(NSNumber *)stopLat otherBuses:(NSArray *)stopOtherBus {
	if (self = [super init]) {
		busstopid = stopID;
		code = [stopCode copy];
		desc = [stopDesc copy];
		roadName = [stopRdName copy];
		lon = [stopLong copy];
		lat = [stopLat copy];
		otherBus = [stopOtherBus copy];
	}
	return self;
}

-(NSArray *) arrivals {
	// array of all buses arriving. buses are dictionaries stipulating order, plate number, eta, routeid, routename.
	return nil;
}

-(void)dealloc {
	[code release];
	[desc release];
	[roadName release];
	[lon release];
	[lat release];
	[otherBus release];
	[routes release];
	[super dealloc];
}

@end
