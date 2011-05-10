//
//  Created by Björn Sållarp on 4/25/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSAtomFeed.h"
#import "BSAtomFeedPerson.h"

@implementation BSAtomFeed
@synthesize entries;
@synthesize generator;
@synthesize icon;
@synthesize logo;
@synthesize rights;
@synthesize subtitle;

+ (BSAtomFeed *)atomFeed
{
    return [[[self alloc] init] autorelease];
}

- (void)dealloc {
    self.entries = nil;
    self.generator = nil;
    self.icon = nil;
    self.logo = nil;
    self.rights = nil;
    self.subtitle = nil;
    [super dealloc];
}

- (void)addEntry:(BSAtomFeedEntry *)entry
{
    if (self.entries == nil) {
        self.entries = [NSMutableArray array];
    }
    
    [self.entries addObject:entry];
}

@end
