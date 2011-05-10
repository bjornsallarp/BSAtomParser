//
//  Created by Björn Sållarp on 5/9/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "AtomReaderAppDelegate.h"

@implementation AtomReaderAppDelegate


@synthesize window=_window;

@synthesize navigationController=_navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
