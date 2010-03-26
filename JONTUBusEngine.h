//
//  JONTUBusEngine.h
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface JONTUBusEngine : NSObject {
	NSArray *_buses;
	NSArray *_routes;
	NSArray *_busstops;
}

+(JONTUBusEngine *)sharedJONTUBusEngine;
-(NSData *)sendXHRToURL:(NSString *)url PostValues:(NSDictionary *)postValues;

@end
