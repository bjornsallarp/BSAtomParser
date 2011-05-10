//
//  Created by Björn Sållarp on 5/7/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import <Foundation/Foundation.h>


@interface BSAtomFeedGenerator : NSObject
@property (nonatomic, retain) NSString *uri;
@property (nonatomic, retain) NSString *version;
@property (nonatomic, retain) NSString *text;

+ (BSAtomFeedGenerator *)generator;
+ (BSAtomFeedGenerator *)generatorWithUri:(NSString *)uri version:(NSString *)version text:(NSString *)text;
- (id)initWithUri:(NSString *)uri version:(NSString *)version text:(NSString *)text;
@end
