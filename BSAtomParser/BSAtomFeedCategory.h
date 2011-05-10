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


@interface BSAtomFeedCategory : NSObject
@property (nonatomic, retain) NSString *term;
@property (nonatomic, retain) NSString *scheme;
@property (nonatomic, retain) NSString *label;

+ (BSAtomFeedCategory *)category;
+ (BSAtomFeedCategory *)categoryWithTerm:(NSString *)term scheme:(NSString *)scheme label:(NSString *)label;
- (id)initWithTerm:(NSString *)term scheme:(NSString *)scheme label:(NSString *)label;
@end
