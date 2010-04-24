#import <Foundation/Foundation.h>
#import "JONTUBusEngine.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	
	JONTUBusEngine *engine = [JONTUBusEngine sharedJONTUBusEngine];

	[engine setHoldCache:-1];
	[engine start];

	for (int i=0;i<[[engine stops] count];i++) {
		
		NSLog(@"%@: %@, %@", [[[engine stops] objectAtIndex:i] desc], [[[engine stops] objectAtIndex:i] lat], [[[engine stops] objectAtIndex:i] lon]);
	}

	NSLog(@"%i", [[engine stops] count]);
	
	NSLog(@"%@",[[[engine stops] objectAtIndex:10] desc]);
	
	[pool drain];
    return 0;
}
