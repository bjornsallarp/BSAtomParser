//
//  Created by Björn Sållarp on 5/2/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import <Foundation/Foundation.h>

typedef enum {
    kAtomText = 0,
    kAtomHTML = 1,
    kAtomXHTML = 2
} BSAtomTextType;

@interface BSAtomFeedTextElement : NSObject
@property (nonatomic, assign) BSAtomTextType contentType;
@property (nonatomic, retain) NSString *content;

+ (BSAtomFeedTextElement *)textElementWithType:(NSString *) type;
- (id)initWithType:(NSString *)type;
- (void)contentTypeFromString:(NSString *)type;
@end
