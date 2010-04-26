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
@synthesize busid, route, busPlate, hide, iscdistance;

-(id)initWithID:(NSUInteger)bID route:(JONTUBusRoute *)busRoute plateNumber:(NSString *)plateNumber longtitude:(NSNumber *)busLong latitude:(NSNumber *)busLat speed:(NSUInteger)busSpeed hide:(BOOL)busHide iscDistance:(NSNumber *)iscdist {
	if (self = [super init]) {
		busid = bID;
		route = [busRoute retain];
		busPlate = [plateNumber copy];
		lon = [busLong copy];
		lat = [busLat copy];
		speed = busSpeed;
		hide = busHide;
		iscdistance = [iscdist copy];
	}
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		busid = [aDecoder decodeIntegerForKey:@"busid"];
		route = [[aDecoder decodeObjectForKey:@"route"] retain];
		busPlate = [[aDecoder decodeObjectForKey:@"busPlate"] retain];
		lon = [[aDecoder decodeObjectForKey:@"lon"] retain];
		lat = [[aDecoder decodeObjectForKey:@"lat"] retain];
		speed = [aDecoder decodeIntegerForKey:@"speed"];
		hide = [aDecoder decodeBoolForKey:@"hide"];
		iscdistance = [[aDecoder decodeObjectForKey:@"iscdistance"] retain];		
	}
	return self;
	
}

-(void)encodeWithCoder:(NSCoder *)aCoder {	
	NSLog(@"Encoding bus object: %@", busPlate);
	[aCoder encodeInteger:busid forKey:@"busid"];
	[aCoder encodeObject:route forKey:@"route"];
	[aCoder encodeObject:busPlate forKey:@"busPlate"];
	[aCoder encodeObject:lat forKey:@"lat"];
	[aCoder encodeObject:lon forKey:@"lon"];
	[aCoder encodeInteger:speed forKey:@"speed"];
	[aCoder encodeBool:hide forKey:@"hide"];
	[aCoder encodeObject:iscdistance forKey:@"iscdistance"];
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
