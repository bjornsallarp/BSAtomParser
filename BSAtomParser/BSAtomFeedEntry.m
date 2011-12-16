//
//  Created by Björn Sållarp on 4/25/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSAtomFeedEntry.h"
#import "BSAtomFeedCustomElement.h"

@implementation BSAtomFeedEntry
@synthesize summary;
@synthesize customElements;
@synthesize content;

+ (BSAtomFeedEntry *)entry
{
    return [[[self alloc] init] autorelease];
}

- (NSArray *)customElementsWithName:(NSString *)name
{
    NSMutableArray *matchingElements = nil;

    for (BSAtomFeedCustomElement *elem in self.customElements) {
        if ([elem.name isEqualToString:name]) {
            if (!matchingElements) {
                matchingElements = [NSMutableArray array];
            }
            [matchingElements addObject:elem];
        }
    }

    return matchingElements;
}

- (void)dealloc {
    self.content = nil;
    self.customElements = nil;
    self.summary = nil;
    [super dealloc];
}

@end
