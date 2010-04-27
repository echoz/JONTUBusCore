//  The MIT License
//  
//  Copyright (c) 2010 Jeremy Foo
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
	
	NSLog(@"%@", [[[engine stops] objectAtIndex:5] otherBus]);
	
	NSLog(@"%@", [[[engine stops] objectAtIndex:10] irisQueryForService:@"179" atStop:@"22529"]);
	
//	[JONTUBusEngine saveState:@"/Users/jeremy/test.dat"];
	
	
	[pool drain];
    return 0;
}
