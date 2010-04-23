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
-(NSArray *)routes;
-(NSArray *)stops;
-(NSArray *)buses;

/* generic methods */
+(JONTUBusEngine *)sharedJONTUBusEngine;
-(NSData *)sendXHRToURL:(NSString *)url PostValues:(NSDictionary *)postValues;

-(NSData *)getIndexPage;
@end
