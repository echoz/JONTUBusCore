NTUBusArrival
=============

For want of a better name, this project basically abstracts the shuttle bus timings as well as other relevant data into Objective-C objects that can be used. It abstracts the need to send XHML HTTP requests to the StreetDirectory webservice and/or the parsing of the actual index page to get details like the bus stops and routes.

It is relatively simple to use.

The basic premise is that you need a `JONTUBusEngine` object to work with everything. It works as a singleton so within a project there is some sense of a central "data" repository.

	// Grab a JONTUBusEngine instance
	JONTUBusEngine *engine = [JONTUBusEngine sharedJONTUBusEngine];
	
	// Set cache timeout. This is the max time data will be returned before being refreshed.
	// A negative value sets the cache to hold the data forever without refreshing. You can 
	// force refresh using any calls that end with "withRefresh:YES";
	[engine setHoldCache:-1];
	
	// Start the engine to initialise baseline data.
	[engine start];

Data can be accessed via method calls to get relevant components. Apart from that, the other properties of the objects are readily readable as READONLY properties.

Queries through XML HTTP Requests are blocking so you will have to roll your own threaded operations to retrieve whatever information that is needed.

JONTUBusEngine
--------------
`-(void) start;` Initialize baseline data;

`-(NSArray *)routes;` Returns currently cached routes as an array of JONTUBusRoute objects  
`-(NSArray *)routesWithRefresh:(BOOL)refresh;` Returns an array of JONTUBusRoute objects with option to refresh the cache first  
`-(JONTUBusRoute *)routeForName:(NSString *)routename;` Hunt for route based on name from internal cache  
`-(JONTUBusRoute *)routeForId:(NSUInteger)routeid;` Hunt for route based on id from internal cache

`-(NSArray *)stops;` Returns currently cached bus stops as an array of JONTUBusStop objects  
`-(NSArray *)stopsWithRefresh:(BOOL)refresh;` Returns an array of JONTUBusStop objects with option to refresh the cache first  
`-(JONTUBusStop *)stopForId:(NSUInteger)stopid;` Hunt for a bus stop based on its id

`-(NSArray *)buses;` Returns internal cache of currently operating buses as an array of JONTUBus objects  
`-(NSArray *)busesWithRefresh:(BOOL)refresh;` Returns an array of currently operating buses (JONTUBus objects) with option to refresh the cache first

`-(NSData *)sendXHRToURL:(NSString *)url PostValues:(NSDictionary *)postValues;` Generic XHML HTTP Request method  
`-(NSData *)getIndexPage;` Returns and caches the index page

JONTUBusRoute
-------------
`-(NSArray *)stopsWithRefresh:(BOOL)refresh;` Returns an array of JONTUBusStop objects that are on this route with the option to refresh the cache first  
`-(NSArray *)stops;` Returns an array of JONTUBusStop objects that are on this route

JONTUBusStop
------------
`-(NSArray *) arrivals;` Gets the buses that will arrive as an array of the following structure,
	<Array>
		<NSDictionary of ETA for a single bus>
	</Array>
	
Example NSDictionary of ETA 
	
	{
        eta = "17 mins";
        order = 1;
        plate = PA4913U;
        routeid = 3;
        routename = "NTU-C";
    }

There is also the oft chance that a bus service is not currently in operation and hence the NSDictionary will look like the following instead,

	{
        err = "Not in service";
        routeid = 1;
        routename = "NTU-A";
    }

An example of such a usage of this method call is as follows,

	#import <Foundation/Foundation.h>
	#import "JONTUBusEngine.h"

	int main (int argc, const char * argv[]) {
	    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];


		JONTUBusEngine *engine = [JONTUBusEngine sharedJONTUBusEngine];

		[engine setHoldCache:-1];
		[engine start];

		NSLog(@"%i", [[engine stops] count]);

		NSLog(@"%@",[[[engine stops] objectAtIndex:0] arrivals]);

		[pool drain];
	    return 0;
	}
	
The results of such a query,

	2010-04-24 11:56:59.613 NTUBusArrival[12431:a0f] 40
	2010-04-24 11:57:00.040 NTUBusArrival[12431:a0f] (
	        {
	        err = "Not in service";
	        routeid = 1;
	        routename = "NTU-A";
	    },
	        {
	        eta = "7 mins";
	        order = 1;
	        plate = PA4934;
	        routeid = 4;
	        routename = "NTU-D (Pioneer)";
	    }
	)