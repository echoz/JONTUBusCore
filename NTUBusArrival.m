#import <Foundation/Foundation.h>
#import "JONTUBusEngine.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	
	JONTUBusEngine *engine = [JONTUBusEngine sharedJONTUBusEngine];

	[engine setHoldCache:-1];
	[engine start];
	
	[pool drain];
    return 0;
}
