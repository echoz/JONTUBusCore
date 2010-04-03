//
//  JONTUBusRoute.h
//  NTUBusArrival
//
//  Created by Jeremy Foo on 3/24/10.
//  Copyright 2010 THIRDLY. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JONTUBusRoute : NSObject {
	NSUInteger id;
	NSString *name;
	NSArray *_stops;
}
-(id)initWithID:(NSUInteger)routeid name:(NSString *)routename;

@end
