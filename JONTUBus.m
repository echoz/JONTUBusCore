//
//  JONTUBus.m
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import "JONTUBus.h"


@implementation JONTUBus
@synthesize speed, lon, lat;
@synthesize busid, route, busPlate, hide, icsdistance;

-(id)initWithID:(NSUInteger)bID route:(JONTUBusRoute *)busRoute plateNumber:(NSString *)plateNumber longtitude:(NSNumber *)busLong latitude:(NSNumber *)busLat speed:(NSUInteger)busSpeed hide:(BOOL)busHide icsDistance:(NSNumber *)icsdist {
	if (self = [super init]) {
		busid = bID;
		route = busRoute;
		busPlate = plateNumber;
		lon = busLong;
		lat = busLat;
		speed = busSpeed;
		hide = busHide;
		icsdist = icsdist;
	}
	return self;
}

-(void)dealloc {
	[lon release];
	[lat release];
	[route release];
	[busPlate release];
	[iscdistance release];
	[super dealloc];
}

@end
