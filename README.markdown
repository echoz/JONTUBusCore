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

Data can be accessed via method calls to get relevant components.

JONTUBusEngine
--------------
`-(void) start;` Initialize baseline data;

`-(NSArray *)routes;` Returns currently cached routes
`-(NSArray *)routesWithRefresh:(BOOL)refresh;` Returns routes with option to refresh the cache first
`-(JONTUBusRoute *)routeForName:(NSString *)routename;` Hunt for route based on name from internal cache
`-(JONTUBusRoute *)routeForId:(NSUInteger)routeid;` Hunt for route based on id from internal cache

`-(NSArray *)stops;` Returns currently cached bus stops
`-(NSArray *)stopsWithRefresh:(BOOL)refresh;` Returns bus stops with option to refresh the cache first
`-(JONTUBusStop *)stopForId:(NSUInteger)stopid;` Hunt for a bus stop based on its id

`-(NSArray *)buses;` Returns internal cache of currently operating buses
`-(NSArray *)busesWithRefresh:(BOOL)refresh;` Returns currently operating buses with option to refresh the cache first

`-(NSData *)sendXHRToURL:(NSString *)url PostValues:(NSDictionary *)postValues;` Generic XHML HTTP Request method
`-(NSData *)getIndexPage;` Returns and caches the index page

(more later)