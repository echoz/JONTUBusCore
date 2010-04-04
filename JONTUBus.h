//
//  JONTUBus.h
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JONTUBusRoute.h"

@interface JONTUBus : NSObject {
	NSUInteger busid;
	JONTUBusRoute *route;
	NSString *busPlate;
	NSNumber *lat;
	NSNumber *lon;
	NSUInteger speed;
	BOOL hide;
	NSNumber *iscdistance;
}

-(id)initWithID:(NSUInteger)busID route:(JONTUBusRoute *)busRoute plateNumber:(NSString *)busPlate longtitude:(NSNumber *)busLong latitude:(NSNumber *)busLat speed:(NSUInteger)busSpeed hide:(BOOL)busHide icsDistance:(NSNumber *)icsdist;
@property (nonatomic, retain) NSNumber *lat;
@property (nonatomic, retain) NSNumber *lon;
@property (nonatomic, readwrite) NSUInteger speed;

@property (readonly) NSUInteger busid;
@property (readonly) JONTUBusRoute *route;
@property (readonly) NSString *busPlate;
@property (readonly) BOOL hide;
@property (readonly) NSNumber *icsdistance;

@end
