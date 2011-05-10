//
//  Created by Björn Sållarp on 4/25/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import <Foundation/Foundation.h>
#import "BSAtomFeedBase.h"

@interface BSAtomFeedEntry : BSAtomFeedBase
@property (nonatomic, retain) BSAtomFeedTextElement *summary;
@property (nonatomic, retain) BSAtomFeedTextElement *content;
@property (nonatomic, retain) NSMutableDictionary *customElements;

+ (BSAtomFeedEntry *)entry;

@end
