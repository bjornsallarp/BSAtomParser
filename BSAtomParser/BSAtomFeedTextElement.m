//
//  Created by Björn Sållarp on 5/2/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSAtomFeedTextElement.h"

@implementation BSAtomFeedTextElement
@synthesize content, contentType;

+ (BSAtomFeedTextElement *)textElementWithType:(NSString *) type
{
    return [[[self alloc] initWithType:type] autorelease];
}

- (id)initWithType:(NSString *)type
{
    if ((self == [super init])) {
        [self contentTypeFromString:type];
    }
    
    return self;
}

- (void)contentTypeFromString:(NSString *)type
{
    if (type == nil || [type isEqualToString:@"text"]) {
        self.contentType = kAtomText;                
    }
    else if ([type isEqualToString:@"xhtml"]) {
        self.contentType = kAtomXHTML;
    }
    else if ([type isEqualToString:@"html"]) {
        self.contentType = kAtomHTML;
    }
}

- (void)dealloc
{
    self.content = nil;
    [super dealloc];
}
@end
