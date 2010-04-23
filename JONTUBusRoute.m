//
//  JONTUBusRoute.m
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import "JONTUBusRoute.h"
#import "JONTUBusEngine.h"
#import "JONTUBusStop.h"

@implementation JONTUBusRoute

@synthesize routeid, name;

static NSString *getRouteBusStops = @"http://campusbus.ntu.edu.sg/ntubus/index.php/main/getCurrentBusStop";

-(id)initWithID:(NSUInteger)rid name:(NSString *)rname stops:(NSArray *)busstops{
	if (self = [super init]) {
		routeid = rid;
		name = [rname copy];
		stops = [busstops copy];
	}
	return self;
}

-(NSArray *)stops {
	return [self stopsWithRefresh:NO];
}

-(NSArray *)stopsWithRefresh:(BOOL)refresh {
	if (refresh) {
		[stops removeAllObjects];
		JONTUBusEngine *engine = [JONTUBusEngine sharedJONTUBusEngine];
		
		NSMutableDictionary *post = [NSMutableDictionary dictionary];
		[post setValue:[NSString stringWithFormat:@"%i",routeid] forKey:@"routeid"];
		[post setValue:[NSString stringWithFormat:@"%f", (float)arc4random()/10000000000] forKey:@"r"];
		
		NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[engine sendXHRToURL:getRouteBusStops PostValues:post]];
		[parser setDelegate:self];
		[parser setShouldProcessNamespaces:NO];
		[parser setShouldReportNamespacePrefixes:NO];
		[parser setShouldResolveExternalEntities:NO];
		
		[stops release];
		stops = [[NSMutableArray array] retain];
		
		[parser parse];

		// fuck care error handling for now
		
		[parser release];
	} 
	return stops;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	JONTUBusEngine *engine = [JONTUBusEngine sharedJONTUBusEngine];
	JONTUBusStop *stop;

	if ([elementName isEqualToString:@"bus_stop"]) {
		stop = [engine stopOfId:[[attributeDict valueForKey:@"id"] intValue]];
		[stops addObject:stop];
	}
}

-(void)dealloc {
	[name release];
	[stops release];
	[super dealloc];
}

@end
