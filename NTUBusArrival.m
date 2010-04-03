#import <Foundation/Foundation.h>
#import "JONTUBusEngine.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	JONTUBusEngine *engine = [JONTUBusEngine sharedJONTUBusEngine];
	NSMutableDictionary *post = [NSMutableDictionary dictionary];
	
	[post setValue:@"1" forKey:@"routeid"];
	[post setValue:[NSString stringWithFormat:@"%f", (float)arc4random()/10000000000] forKey:@"r"];
	NSData *recvData = [engine sendXHRToURL:@"http://campusbus.ntu.edu.sg/ntubus/index.php/main/getCurrentBusStop" PostValues:post];
	
	NSLog(@"%@",[[[NSString alloc] initWithData:recvData encoding:NSASCIIStringEncoding] autorelease]);
	
	
	[pool drain];
    return 0;
}
