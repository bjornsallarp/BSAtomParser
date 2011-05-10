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

@class BSAtomFeedEntry;
@class BSAtomFeedGenerator;

@interface BSAtomFeed : BSAtomFeedBase
@property (nonatomic, retain) NSMutableArray *entries;
@property (nonatomic, retain) BSAtomFeedGenerator *generator;
@property (nonatomic, retain) NSString *icon;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) BSAtomFeedTextElement *rights;
@property (nonatomic, retain) BSAtomFeedTextElement *subtitle;

+ (BSAtomFeed *)atomFeed;
- (void)addEntry:(BSAtomFeedEntry *)entry;
@end
