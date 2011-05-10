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


@interface BSAtomFeedPerson : NSObject 
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *uri;
@property (nonatomic, retain) NSString *email;

+ (BSAtomFeedPerson *)person;
+ (BSAtomFeedPerson *)personWithName:(NSString *)name uri:(NSString *)uri email:(NSString *)email;
- (id)initWithName:(NSString *)name uri:(NSString *)uri email:(NSString *)email;

@end
