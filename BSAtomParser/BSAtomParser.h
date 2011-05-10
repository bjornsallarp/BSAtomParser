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

@class BSAtomParser;
@class BSAtomFeed;
@class BSAtomFeedEntry;

@protocol BSAtomParserDelegate <NSObject>
@required
- (void)atomParser:(BSAtomParser *)parser didParseAtomFeedEntry:(BSAtomFeedEntry *)entry;
- (void)atomParser:(BSAtomParser *)parser didParseAtomFeed:(BSAtomFeed *)feed;
- (void)atomParser:(BSAtomParser *)parser didFailWithError:(NSError *)error;
@end

@interface BSAtomParser : NSObject<NSXMLParserDelegate>
+ (BSAtomParser *)parser;
- (BSAtomFeed *)parseAtomFeedWithData:(NSData *)feedData error:(NSError **)error;
- (void)parseAtomFeedWithData:(NSData *)feedData delegate:(id<BSAtomParserDelegate>)delegate;
@end
