//
//  Created by Björn Sållarp on 4/29/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import <Foundation/Foundation.h>

@interface BSAtomFeedCustomElement : NSObject 
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDictionary *attributes;
@property (nonatomic, retain) NSString *content;

+ (BSAtomFeedCustomElement *)elementWithName:(NSString *)name content:(NSString *)content attributes:(NSDictionary *)attributes;
- (id)initWithName:(NSString *)name content:(NSString *)content attributes:(NSDictionary *)attributes;

@end
