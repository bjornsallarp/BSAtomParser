//
//  Created by Björn Sållarp on 4/29/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSAtomFeedCustomElement.h"


@implementation BSAtomFeedCustomElement
@synthesize name = name_;
@synthesize content = content_;
@synthesize attributes = attributes_;

+ (BSAtomFeedCustomElement *)elementWithName:(NSString *)name content:(NSString *)content attributes:(NSDictionary *)attributes
{
    return [[[self alloc] initWithName:name content:content attributes:attributes] autorelease];
}

- (id)initWithName:(NSString *)name content:(NSString *)content attributes:(NSDictionary *)attributes
{
    if ((self == [super init])) {
        self.name = name;
        self.content = content;
        self.attributes = attributes;
    }
    
    return self;
}

- (void)dealloc
{
    self.name = nil;
    self.content = nil;
    self.attributes = nil;
    [super dealloc];
}
@end
