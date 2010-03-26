//
//  JONTUBusEngine.m
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "JONTUBusEngine.h"


@implementation JONTUBusEngine

static const NSString *getRouteURL = @"http://campusbus.ntu.edu.sg/ntubus/index.php/main/getCurrentBusStop";
static const NSString *getBusPosition = @"http://campusbus.ntu.edu.sg/ntubus/index.php/main/getCurrentPosition";
static const NSString *getEta = @"http://campusbus.ntu.edu.sg/ntubus/index.php/xml/getEta";

SYNTHESIZE_SINGLETON_FOR_CLASS(JONTUBusEngine);

-(NSData *) sendXHRToURL:(NSString *)url PostValues:(NSDictionary *)postValues {
	
	NSMutableString *post = [NSMutableString string];
	for (NSString *key in postValues) {
		if ([post length] > 0) {
			[post appendString:@"&"];
		}
		[post appendFormat:@"%@=%@",key,[postValues objectForKey:key]];
	}
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	NSData *recvData = [[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil] autorelease];
	
	[post release];
	[postData release];
	[postLength release];
	[request release];
	
	return recvData;
}

@end
