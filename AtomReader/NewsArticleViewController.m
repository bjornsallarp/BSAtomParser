//
//  Created by Björn Sållarp on 5/9/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//


#import "NewsArticleViewController.h"
#import "BSAtom.h"

@interface NewsArticleViewController()
@property (nonatomic, retain) BSAtomFeedEntry *feedEntry;
@end

@implementation NewsArticleViewController
@synthesize browserView;
@synthesize feedEntry = feedEntry_;


+ (NewsArticleViewController *)newsArticleWithFeedEntry:(BSAtomFeedEntry *)feedEntry
{
    return [[[self alloc] initWithAtomEntry:feedEntry] autorelease];
}

- (id)initWithAtomEntry:(BSAtomFeedEntry *)feedEntry
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.feedEntry = feedEntry;
    }
    return self;
}

- (void)dealloc
{
    self.feedEntry = nil;
    self.browserView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    BSAtomFeedLink *link = [self.feedEntry.links lastObject];
    [self.browserView loadHTMLString:self.feedEntry.content.content baseURL:[NSURL URLWithString:link.href]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - Accessors

- (NSString *)nibName
{
    return @"NewsArticleViewController";
}

- (NSBundle *)nibBundle
{
    return [NSBundle bundleForClass:[self class]];
}

@end
