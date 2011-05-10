//
//  Created by Björn Sållarp on 5/7/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSAtomFeedGenerator.h"


@implementation BSAtomFeedGenerator
@synthesize uri = uri_;
@synthesize version = version_;
@synthesize text = text_;

+ (BSAtomFeedGenerator *)generator
{
    return [[[self alloc] init] autorelease];
}

+ (BSAtomFeedGenerator *)generatorWithUri:(NSString *)uri version:(NSString *)version text:(NSString *)text
{
    return [[[self alloc] initWithUri:uri version:version text:text] autorelease];
}

- (id)initWithUri:(NSString *)uri version:(NSString *)version text:(NSString *)text
{
    if ((self == [super init])) {
        self.uri = uri;
        self.version = version;
        self.text = text;
    }
    
    return self;
}

- (void)dealloc
{
    self.uri = nil;
    self.version = nil;
    self.text = nil;
    [super dealloc];
}
@end
