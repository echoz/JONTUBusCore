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

@interface JONTUBusEngine : NSObject <NSXMLParserDelegate,NSCoding> {
	NSMutableArray *buses;
	NSMutableArray *routes;
	NSMutableArray *stops;
	NSData *indexPageCache;
	NSDate *lastGetIndexPage;
	BOOL dirty;
	int holdCache;
}

@property (readonly) BOOL dirty;
@property (readwrite) int holdCache;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(JONTUBusEngine);

-(void) start;
-(NSArray *)routes;
-(NSArray *)routesWithRefresh:(BOOL)refresh;
-(JONTUBusRoute *)routeForName:(NSString *)routename;
-(JONTUBusRoute *)routeForId:(NSUInteger)routeid;

-(NSArray *)stops;
-(NSArray *)stopsWithRefresh:(BOOL)refresh;
-(JONTUBusStop *)stopForId:(NSUInteger)stopid;

-(NSArray *)buses;
-(NSArray *)busesWithRefresh:(BOOL)refresh;

/* generic methods */
+(JONTUBusEngine *)sharedJONTUBusEngine;
+(void)loadState:(NSString *)archiveFilePath;
+(void)saveState:(NSString *)archiveFilePath;
-(NSData *)sendXHRToURL:(NSString *)url PostValues:(NSDictionary *)postValues;
-(NSData *)getIndexPage;

@end
