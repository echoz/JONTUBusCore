//
//  JONTUBusEngine.m
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/26/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import "JONTUBusEngine.h"
#import "RegexKitLite.h"

@implementation JONTUBusEngine

@synthesize buses, routes, stops;

static NSString *getRouteURL = @"http://campusbus.ntu.edu.sg/ntubus/index.php/main/getCurrentBusStop";
static NSString *getBusPosition = @"http://campusbus.ntu.edu.sg/ntubus/index.php/main/getCurrentPosition";
static NSString *getEta = @"http://campusbus.ntu.edu.sg/ntubus/index.php/xml/getEta";
static NSString *indexPage = @"http://campusbus.ntu.edu.sg/ntubus/";

static NSString *regexBusStop = @"ntu.busStop.push\\(\\{\\s*id:(\\d*),\\s*code:(\\d*),\\s*description:\"(.*)\",\\s*roadName:\"(.*)\",\\s*x:([\\d.]*),\\s*y:([\\d.]*),\\s*lon:([\\d.]*),\\s*lat:([\\d.]*),\\s*otherBus:\"(.*)\",\\s*marker:.*,\\s*markerShadow:.*\\s*\\}\\);";
static NSString *regexRoute = @"ntu.routes.push\\(\\{\\s*id:([\\d]*),\\s*name:\"(.*)\",\\s*centerMetric:.*,\\s*centerLonLat:new GeoPoint\\(([\\d.]*), ([\\d.]*)\\),\\s*color:.*,\\s*colorAlt:.*,\\s*zone:.*,\\s*busStop:.*\\s*\\}\\);";

#define HOLD_CACHE_TIME 120

SYNTHESIZE_SINGLETON_FOR_CLASS(JONTUBusEngine);

-(void)updateBusPositions {
	
}

-(void)start {
	stops = [[NSMutableArray array] retain];
	routes = [[NSMutableArray array] retain];
	[self updateStops];
	[self updateRoutes];
}

-(void)updateStops {
	NSString *matchString = [[NSString alloc] initWithData:[self getIndexPage] encoding:NSASCIIStringEncoding];
	NSArray *busstops = [matchString arrayOfCaptureComponentsMatchedByRegex:regexBusStop];
	JONTUBusStop *stop;
	
	[stops removeAllObjects];
	[matchString release];
		
	for (int i=0;i<[busstops count];i++) {
		
		stop = [[JONTUBusStop alloc] initWithID:[[[busstops objectAtIndex:i] objectAtIndex:1] intValue] code:[busstops objectAtIndex:2] 
									description:[[busstops objectAtIndex:i] objectAtIndex:3] 
									   roadName:[[busstops objectAtIndex:i] objectAtIndex:4]
									 longtitude:[[busstops objectAtIndex:i] objectAtIndex:7]
									   latitude:[[busstops objectAtIndex:i] objectAtIndex:8]
									 otherBuses:[[[busstops objectAtIndex:i] objectAtIndex:9] componentsSeparatedByString:@","]];
		[stops addObject:stop];
		[stop release];
	}
	
}

-(void)updateRoutes {
	NSString *matchString = [[NSString alloc] initWithData:[self getIndexPage] encoding:NSASCIIStringEncoding];
	NSArray *busroutes = [matchString arrayOfCaptureComponentsMatchedByRegex:regexRoute];
	JONTUBusRoute *route;
		
	[routes removeAllObjects];
	[matchString release];	
	
	for (int i=0;i<[busroutes count];i++) {
		route = [[JONTUBusRoute alloc] initWithID:[[[busroutes objectAtIndex:i] objectAtIndex:1] intValue] 
											 name:[[busroutes objectAtIndex:i] objectAtIndex:2] stops:nil];
		[routes addObject:route];
		[route release];
		
	}

}


-(NSData *) getIndexPage {
	if (indexPageCache == nil) {
		indexPageCache = [[self sendXHRToURL:indexPage PostValues:nil] retain];
		lastGetIndexPage = [NSDate date];		
	}
	
	if ([[NSDate date] timeIntervalSinceDate:lastGetIndexPage] > HOLD_CACHE_TIME) {
		[indexPageCache release];
		indexPageCache = [[self sendXHRToURL:indexPage PostValues:nil] retain];
		[lastGetIndexPage release];
		lastGetIndexPage = [NSDate date];
	}
	return indexPageCache;
}

-(NSData *) sendXHRToURL:(NSString *)url PostValues:(NSDictionary *)postValues {

	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];

	if (postValues != nil) {
	
		NSMutableString *post = [NSMutableString string];
		for (NSString *key in postValues) {
			if ([post length] > 0) {
				[post appendString:@"&"];
			}
			[post appendFormat:@"%@=%@",key,[postValues objectForKey:key]];
		}
		
		NSLog(@"Post String: %@", post);
		NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
		NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
		[request setHTTPMethod:@"POST"];
		[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
		[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		[request setHTTPBody:postData];
		
	}
	
	[request setURL:[NSURL URLWithString:url]];
	
	NSData *recvData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	
	[request release];
	
	return recvData;
}

-(void)dealloc {
	[buses release];
	[stops release];
	[routes release];
	[super dealloc];
}

@end
