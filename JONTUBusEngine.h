//
//  JONTUBusEngine.h
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/26/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "JONTUBus.h"

@interface JONTUBusEngine : NSObject {
	NSArray *buses;
	NSArray *routes;
	NSArray *stops;
}

-(void) updateBusPositions;

-(void) updateRoutes;
-(void) updateStops;

@property (readonly) NSArray *buses;
@property (readonly) NSArray *routes;
@property (readonly) NSArray *stops;

/* generic methods */
+(JONTUBusEngine *)sharedJONTUBusEngine;
-(NSData *)sendXHRToURL:(NSString *)url PostValues:(NSDictionary *)postValues;

@end
