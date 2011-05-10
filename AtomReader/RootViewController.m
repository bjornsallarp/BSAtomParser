//
//  Created by Björn Sållarp on 5/9/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "RootViewController.h"
#import "NewsArticleViewController.h"
#import "BSAtom.h"

@interface RootViewController()
@property (nonatomic, retain) BSAtomFeed *huffingtonFeed;
@end

@implementation RootViewController
@synthesize huffingtonFeed = huffingtonFeed_;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"HuffingtonPost.com";
    
    NSData *feedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://feeds.huffingtonpost.com/huffingtonpost/raw_feed"]];
    BSAtomParser *parser = [BSAtomParser parser];
    NSError *error = nil;
    self.huffingtonFeed = [parser parseAtomFeedWithData:feedData error:&error];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.huffingtonFeed.entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    BSAtomFeedEntry *entry = [self.huffingtonFeed.entries objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.text = entry.title.content;
    cell.detailTextLabel.text = entry.summary.content;

    // Configure the cell.
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsArticleViewController *news = [NewsArticleViewController newsArticleWithFeedEntry:[self.huffingtonFeed.entries objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:news animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    self.huffingtonFeed = nil;
    [super dealloc];
}

@end
