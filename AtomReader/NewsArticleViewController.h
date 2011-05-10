//
//  Created by Björn Sållarp on 5/9/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//


#import <UIKit/UIKit.h>

@class BSAtomFeedEntry;

@interface NewsArticleViewController : UIViewController
@property (nonatomic, retain) IBOutlet UIWebView *browserView;

+ (NewsArticleViewController *)newsArticleWithFeedEntry:(BSAtomFeedEntry *)feedEntry;
- (id)initWithAtomEntry:(BSAtomFeedEntry *)feedEntry;
@end
