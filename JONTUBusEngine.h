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
#import "JONTUBusStop.h"
#import "JONTUBusRoute.h"

@interface JONTUBusEngine : NSObject {
	NSMutableArray *buses;
	NSMutableArray *routes;
	NSMutableArray *stops;
	NSData *indexPageCache;
	NSDate *lastGetIndexPage;
}

-(void) updateBusPositions;
-(void) start;
-(void) updateRoutes;
-(void) updateStops;

@property (readonly) NSMutableArray *buses;
@property (readonly) NSMutableArray *routes;
@property (readonly) NSMutableArray *stops;

/* generic methods */
+(JONTUBusEngine *)sharedJONTUBusEngine;
-(NSData *)sendXHRToURL:(NSString *)url PostValues:(NSDictionary *)postValues;

-(NSData *) getIndexPage;
@end
