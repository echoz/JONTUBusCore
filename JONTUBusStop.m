//
//  JONTUBusStop.m
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import "JONTUBusStop.h"
#import "JONTUBusEngine.h"

@implementation JONTUBusStop

static NSString *getEta = @"http://campusbus.ntu.edu.sg/ntubus/index.php/xml/getEta";

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
		arrivals = nil;
	}
	return self;
}

-(NSArray *) arrivals {
	// array of all buses arriving. buses are dictionaries stipulating order, plate number, eta, routeid, routename.
	currentRouteid = nil;
	currentRouteName = nil;
	[arrivals release];
	arrivals = [[NSMutableArray array] retain];
	
	JONTUBusEngine *engine = [JONTUBusEngine sharedJONTUBusEngine];
	
	NSMutableDictionary *post = [NSMutableDictionary dictionary];
	[post setValue:[self code] forKey:@"busstopcode"];
	[post setValue:[NSString stringWithFormat:@"%f", (float)arc4random()/10000000000] forKey:@"r"];
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[engine sendXHRToURL:getEta PostValues:post]];
	
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	
	[parser parse];
	[parser release];
	
	return arrivals;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"route"]) {
		currentRouteid = [attributeDict objectForKey:@"id"];
		currentRouteName = [attributeDict objectForKey:@"name"];
	}
	
	if ([elementName isEqualToString:@"bus"]) {
		NSMutableDictionary *bus = [NSMutableDictionary dictionary];

		if ([attributeDict objectForKey:@"err"]) {
			[bus setValue:[attributeDict objectForKey:@"err"] forKey:@"err"];
		} else {
			[bus setValue:[attributeDict objectForKey:@"order"] forKey:@"order"];
			[bus setValue:[attributeDict objectForKey:@"name"] forKey:@"plate"];
			[bus setValue:[attributeDict objectForKey:@"eta"] forKey:@"eta"];			
		}

		[bus setValue:currentRouteid forKey:@"routeid"];
		[bus setValue:currentRouteName forKey:@"routename"];
		[arrivals addObject:bus];
	}
}

-(void)dealloc {
	[code release];
	[desc release];
	[roadName release];
	[lon release];
	[lat release];
	[otherBus release];
	[routes release];
	[arrivals release];
	[currentRouteid release];
	[currentRouteName release];
	[super dealloc];
}

@end
