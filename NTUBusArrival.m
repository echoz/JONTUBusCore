#import <Foundation/Foundation.h>
#import "JONTUBusEngine.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	
	JONTUBusEngine *engine = [JONTUBusEngine sharedJONTUBusEngine];

	[engine start];
	
	NSLog(@"%i", [[engine stops] count]);
	NSLog(@"%@", [engine stops]);
	NSLog(@"%i", [[engine routes] count]);
	NSLog(@"%@", [engine routes]);
	
	[pool drain];
    return 0;
}
