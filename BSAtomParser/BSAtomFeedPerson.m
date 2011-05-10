//
//  Created by Björn Sållarp on 5/7/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSAtomFeedPerson.h"


@implementation BSAtomFeedPerson
@synthesize name = name_;
@synthesize uri = uri_;
@synthesize email = email_;

+ (BSAtomFeedPerson *)person
{
    return [[[self alloc] init] autorelease];
}

+ (BSAtomFeedPerson *)personWithName:(NSString *)name uri:(NSString *)uri email:(NSString *)email
{
    return [[[self alloc] initWithName:name uri:uri email:email] autorelease];
}

- (id)initWithName:(NSString *)name uri:(NSString *)uri email:(NSString *)email
{
    if ((self == [super init])) {
        self.name = name;
        self.uri = uri;
        self.email = email;
    }
    
    return self;
}


- (void)dealloc
{
    self.name = nil;
    self.uri = nil;
    self.email = nil;
    [super dealloc];
}

@end
