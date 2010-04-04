//
//  JONTUBusEngine.m
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/26/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import "JONTUBusEngine.h"


@implementation JONTUBusEngine

@synthesize buses, routes, stops;

static const NSString *getRouteURL = @"http://campusbus.ntu.edu.sg/ntubus/index.php/main/getCurrentBusStop";
static const NSString *getBusPosition = @"http://campusbus.ntu.edu.sg/ntubus/index.php/main/getCurrentPosition";
static const NSString *getEta = @"http://campusbus.ntu.edu.sg/ntubus/index.php/xml/getEta";

static const NSString *regexBusStop = @"ntu.busStop.push\\(\\{\\s+id:[0-9]+,\\s+code:[0-9]+,\\s+description:\"[^\"\\r\\n]*\",\\s+roadName:\"[\\w ]*\",\\s+x:[\\d.]+,\\s+y:[\\d.]+,\\s+lon:[\\d.]+,\\s+lat:[\\d.]+,\\s+otherBus:\"[\\w ,]*\",\\s+marker:.*,\\s+markerShadow:.*\\s+\\}\\);";
static const NSString *regexRoute = @"ntu.routes.push\\(\\{\\s+id:[0-9]+,\\s+name:\"[^\\r\"\\n]*\".\\s+centerMetric:.*,\\s+centerLonLat:.*,\\s+color:\".*\",\\s+colorAlt:\".*\",\\s+zone:.*,\\s+busSTop:.*\\s*\\}\\);";

SYNTHESIZE_SINGLETON_FOR_CLASS(JONTUBusEngine);

-(void)updateBusPositions {
	
}

-(void)updateStops {
	
}

-(void)updateRoutes {
	
}

-(NSData *) sendXHRToURL:(NSString *)url PostValues:(NSDictionary *)postValues {
	
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
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
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
