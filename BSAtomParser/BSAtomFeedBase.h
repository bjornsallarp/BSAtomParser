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
#import "BSAtomFeedTextElement.h"

@interface BSAtomFeedBase : NSObject
@property (nonatomic, retain) BSAtomFeedTextElement *title;
@property (nonatomic, retain) NSString *updated;
@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSMutableArray *links;
@property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic, retain) NSMutableArray *contributors;
@property (nonatomic, retain) NSMutableArray *authors;

+ (NSDate *)rfc3339DateFromString:(NSString *)string;
- (NSDate *)updatedDate;

@end
