#import <Foundation/Foundation.h>
#import "JONTUBusEngine.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

//	[JONTUBusEngine loadState:@"/Users/jeremy/test.dat"];
	
	JONTUBusEngine *engine = [JONTUBusEngine sharedJONTUBusEngine];
	
	[engine setHoldCache:-1];	// comment along with loadState to test archived data
	[engine start];				// comment along with loadState to test archived data

	for (int i=0;i<[[engine stops] count];i++) {
		
		NSLog(@"%@: %@, %@", [[[engine stops] objectAtIndex:i] desc], [[[engine stops] objectAtIndex:i] lat], [[[engine stops] objectAtIndex:i] lon]);
	}
	
	for (int j=0;j<[[engine buses] count];j++) {
		NSLog(@"%@", [[[engine buses] objectAtIndex:j] busPlate]);
	}

	NSLog(@"%i", [[engine stops] count]);
	
	NSLog(@"%@",[[[engine stops] objectAtIndex:10] desc]);
	
	NSLog(@"%@", [[[engine stops] objectAtIndex:10] arrivals]);
	
	
//	[JONTUBusEngine saveState:@"/Users/jeremy/test.dat"];
	
	
	[pool drain];
    return 0;
}
