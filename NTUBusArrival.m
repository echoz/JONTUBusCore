#import <Foundation/Foundation.h>
#import "JONTUBusEngine.h"
#import "RegexKitLite.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	NSString *regexBusStop = @"ntu.busStop.push\\(\\{\\s+id:(0-9)+,\\s+code:(0-9)+,\\s+description:\"(^\"\\r\\n)*\",\\s+roadName:\"(\\w )*\",\\s+x:(\\d.)+,\\s+y:(\\d.)+,\\s+lon:(\\d.)+,\\s+lat:(\\d.)+,\\s+otherBus:\"(\\w ,)*\",\\s+marker:.*,\\s+markerShadow:.*\\s+\\}\\);";
	NSString *regexRoute = @"ntu.routes.push\\(\\{\\s+id:[0-9]+,\\s+name:\"[^\\r\"\\n]*\".\\s+centerMetric:.*,\\s+centerLonLat:.*,\\s+color:\".*\",\\s+colorAlt:\".*\",\\s+zone:.*,\\s+busSTop:.*\\s*\\}\\);";
	
	JONTUBusEngine *engine = [JONTUBusEngine sharedJONTUBusEngine];
/*
	NSMutableDictionary *post = [NSMutableDictionary dictionary];
	[post setValue:@"1" forKey:@"routeid"];
	[post setValue:[NSString stringWithFormat:@"%f", (float)arc4random()/10000000000] forKey:@"r"];
	
	NSData *recvData = [engine sendXHRToURL:@"http://campusbus.ntu.edu.sg/ntubus/index.php/main/getCurrentBusStop" PostValues:post];
*/
	
	NSData *recvData = [engine sendXHRToURL:@"http://campusbus.ntu.edu.sg/ntubus/" PostValues:nil];
//	NSLog(@"%@",[[[NSString alloc] initWithData:recvData encoding:NSASCIIStringEncoding] autorelease]);

	NSString *matchString = [[[NSString alloc] initWithData:recvData encoding:NSASCIIStringEncoding] autorelease];
	
	NSLog(@"%@",[matchString arrayOfCaptureComponentsMatchedByRegex:regexBusStop]);
	
	
	[pool drain];
    return 0;
}
