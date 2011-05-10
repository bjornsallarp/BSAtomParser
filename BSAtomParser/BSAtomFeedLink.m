//
//  Created by Björn Sållarp on 4/25/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSAtomFeedLink.h"


@implementation BSAtomFeedLink
@synthesize href = href_;
@synthesize rel = rel_;

+ (BSAtomFeedLink *)linkWithHref:(NSString *)href rel:(NSString *)rel
{
    return [[[self alloc] initWithHref:href rel:rel] autorelease];
}

- (id)initWithHref:(NSString *)href rel:(NSString *)rel
{
    if ((self == [super init])) {
        self.href = href;
        self.rel = rel;
    }
    
    return self;
}

- (void)dealloc
{
    self.href = nil;
    self.rel = nil;
    [super dealloc];
}
@end
