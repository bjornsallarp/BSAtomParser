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


@interface BSAtomFeedLink : NSObject 
@property (nonatomic, retain) NSString *href;
@property (nonatomic, retain) NSString *rel;

+ (BSAtomFeedLink *)linkWithHref:(NSString *)href rel:(NSString *)rel;
- (id)initWithHref:(NSString *)href rel:(NSString *)rel;
@end
