//
//  JONTUBusRoute.m
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import "JONTUBusRoute.h"


@implementation JONTUBusRoute

@synthesize routeid, name, stops;

-(id)initWithID:(NSUInteger)rid name:(NSString *)rname stops:(NSArray *)busstops{
	if (self = [super init]) {
		routeid = rid;
		name = rname;
		stops = busstops;
	}
	return self;
}

-(void)dealloc {
	[name release];
	[stops release];
	[super dealloc];
}

@end
