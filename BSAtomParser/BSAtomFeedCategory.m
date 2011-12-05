//
//  Created by Björn Sållarp on 5/7/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSAtomFeedCategory.h"


@implementation BSAtomFeedCategory
@synthesize term = term_;
@synthesize scheme = scheme_;
@synthesize label = label_;

+ (BSAtomFeedCategory *)category
{
    return [[[self alloc] init] autorelease];
}
+ (BSAtomFeedCategory *)categoryWithTerm:(NSString *)term scheme:(NSString *)scheme label:(NSString *)label
{
    return [[[self alloc] initWithTerm:term scheme:scheme label:label] autorelease];
}

- (id)initWithTerm:(NSString *)term scheme:(NSString *)scheme label:(NSString *)label
{
    if ((self = [super init])) {
        self.term = term;
        self.scheme = scheme;
        self.label = label;
    }
    
    return self;
}

- (void)dealloc
{
    self.term = nil;
    self.scheme = nil;
    self.label = nil;
    [super dealloc];
}

@end
