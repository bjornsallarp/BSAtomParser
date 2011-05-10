//
//  Created by Bjšrn SŒllarp on 4/25/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSAtomParserTests.h"


@implementation BSAtomParserTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (NSData *)dataForFeed:(NSString *)feedName
{
    return [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[BSAtomParserTests class]] pathForResource:feedName ofType:nil]];
}


- (void)testFeedOne
{
    NSError *error = nil;
    BSAtomParser *parser = [BSAtomParser parser];
    BSAtomFeed *feed = [parser parseAtomFeedWithData:[self dataForFeed:@"samplefeed1.atom"] error:&error];
    
    STAssertNil(error, @"Did not expect an error. Reported error: %@", [error localizedDescription]);
    STAssertTrue([feed.title.content isEqualToString:@"Example Feed"], @"Invalid feed title. Title was: %@", feed.title.content);
    STAssertTrue([feed.id isEqualToString:@"urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6"], @"Invalid id. ID was: %@", feed.id);
    STAssertTrue([feed.entries count] == 1, @"Invalid amount of entries, should be 1 was %d", [feed.entries count]);
    STAssertTrue([feed.links count] == 1, @"Invalid amount of links, should be 1 was %d", [feed.entries count]);
    
    BSAtomFeedLink *link = [feed.links lastObject];
    STAssertTrue([link.href isEqualToString:@"http://example.org/"], @"Invalid link href, should be http://example.org/ was %@", link.href);
    
    BSAtomFeedEntry *entry = [feed.entries lastObject]; 
    STAssertTrue([entry.title.content isEqualToString:@"Atom-Powered Robots Run Amok"], @"Invalid entry title. Title was: %@", entry.title.content);
    BSAtomFeedLink *entrylink = [entry.links lastObject];
    STAssertTrue([entrylink.href isEqualToString:@"http://example.org/2003/12/13/atom03"], @"Invalid link href, should be http://example.org/2003/12/13/atom03 was %@", entrylink.href);
}
 
- (void)testFeedTwo
{
    NSError *error = nil;
    BSAtomParser *parser = [BSAtomParser parser];
    BSAtomFeed *feed = [parser parseAtomFeedWithData:[self dataForFeed:@"samplefeed2.atom"] error:&error];
    
    STAssertNil(error, @"Did not expect an error. Reported error: %@", [error localizedDescription]);
    STAssertTrue([feed.entries count] == 1, @"Invalid amount of entries, should be 1 was %d", [feed.entries count]);
    
    BSAtomFeedEntry *entry = [feed.entries lastObject]; 
    STAssertTrue([entry.title.content isEqualToString:@"Atom-Powered Robots Run Amok"], @"Invalid title. Title was: %@", entry.title.content);    
    STAssertTrue([entry.summary.content isEqualToString:@"<p>Some text.</p><span class=\"woot\">test</span>"], @"Invalid summary content. Summary was: %@", entry.summary.content);
}


- (void)testFeedThree
{
    NSError *error = nil;
    BSAtomParser *parser = [BSAtomParser parser];
    BSAtomFeed *feed = [parser parseAtomFeedWithData:[self dataForFeed:@"samplefeed3.atom"] error:&error];
    
    STAssertNil(error, @"Did not expect an error. Reported error: %@", [error localizedDescription]);
    STAssertTrue([feed.title.content isEqualToString:@"Valtech - mina gruppers poster"], @"Invalid feed title. Title was: %@", feed.title.content);
    STAssertTrue([feed.id isEqualToString:@"http://intranet.valtech.se/"], @"Invalid id. ID was: %@", feed.id);
    STAssertTrue([feed.entries count] == 1, @"Invalid amount of entries, should be 1 was %d", [feed.entries count]);
    
    BSAtomFeedEntry *entry = [feed.entries lastObject]; 
    
    STAssertTrue(entry.summary.contentType == 1, @"Invalid summary type. Should be html");
    STAssertNotNil(entry.customElements, @"Custom elements was not supposed to be nil");
    STAssertNotNil([entry.customElements valueForKey:@"slash:comments"], @"slash:comments should exist in customElements");
    BSAtomFeedCustomElement *customElem = [entry.customElements valueForKey:@"slash:comments"]; 
    STAssertTrue([customElem.content isEqualToString:@"9"], @"Comments should be 9, was: %@", customElem.content);
}

- (void)testFeedFour
{
    NSError *error = nil;
    BSAtomParser *parser = [BSAtomParser parser];
    BSAtomFeed *feed = [parser parseAtomFeedWithData:[self dataForFeed:@"samplefeed4.atom"] error:&error];
    
    STAssertNil(error, @"Did not expect an error. Reported error: %@", [error localizedDescription]);
    STAssertTrue([feed.entries count] == 20, @"Invalid amount of entries, should be 20 was %d", [feed.entries count]);
}

- (void)testFeedFive
{
    NSError *error = nil;
    BSAtomParser *parser = [BSAtomParser parser];
    BSAtomFeed *feed = [parser parseAtomFeedWithData:[self dataForFeed:@"samplefeed5.atom"] error:&error];
    
    STAssertNil(error, @"Did not expect an error. Reported error: %@", [error localizedDescription]);
    STAssertTrue([feed.entries count] == 5, @"Invalid amount of entries, should be 5 was %d", [feed.entries count]);
    STAssertTrue([feed.title.content isEqualToString:@"Mitt Saldo"], @"Invalid feed title. Title was: %@", feed.title.content);
    STAssertTrue([feed.subtitle.content isEqualToString:@"En multibank-app for iPhone och iPad, utvecklad av Bjorn Sallarp"], @"Invalid feed subtitle. Title was: %@", feed.subtitle.content);
    STAssertEquals([feed.contributors count], 2U, @"Contributors should be 2, was %d", [feed.contributors count]);
    STAssertTrue([feed.logo isEqualToString:@"logo.png"], @"Logo should be logo.png, was %@", feed.logo);
    STAssertTrue([feed.icon isEqualToString:@"icon.png"], @"Icon should be icon.png, was %@", feed.icon);
    STAssertTrue([feed.generator.text isEqualToString:@"WordPress"], @"Generator should be WordPress, was %@", feed.generator.text);
    STAssertTrue([feed.generator.version isEqualToString:@"3.1"], @"Generator should be 3.1, was %@", feed.generator.version);
    STAssertTrue([feed.generator.uri isEqualToString:@"http://wordpress.org/"], @"Generator should be http://wordpress.org/, was %@", feed.generator.uri);
    
    BSAtomFeedPerson *firstContributor = [feed.contributors objectAtIndex:0];
    STAssertTrue([firstContributor.uri isEqualToString:@"http://blog.sallarp.com"], @"Contributor uri should be http://blog.sallarp.com, was %@", firstContributor.uri);
    
    BSAtomFeedPerson *secondContributor = [feed.contributors lastObject];
    STAssertTrue([secondContributor.name isEqualToString:@"Fake Person"], @"Contributor name should be Fake Person, was %@", secondContributor.name);
    STAssertTrue([secondContributor.email isEqualToString:@"fake.person@anonymous.com"], @"Contributor name should be fake.person@anonymous.com, was %@", secondContributor.email);
    
    BSAtomFeedEntry *entry = [feed.entries objectAtIndex:0];
    STAssertEquals([entry.categories count], 2U, @"Entry should have two categories, had %d", [entry.categories count]);
    STAssertEquals([entry.authors count], 1U, @"Authors should be 1, was %d", [entry.authors count]);
    BSAtomFeedPerson *author = [entry.authors lastObject];
    STAssertTrue([author.email isEqualToString:@"bjorn.sallarp@gmail.com"], @"Author email should be bjorn.sallarp@gmail.com, was %@", author.email);
    
    
    BSAtomFeedCategory *category = [entry.categories objectAtIndex:0];
    STAssertTrue([category.term isEqualToString:@"Nyheter"], @"Category term should be Nyheter, was %@", category.term);
    STAssertTrue([category.scheme isEqualToString:@"http://www.mittsaldo.se"], @"Category term should be http://www.mittsaldo.se, was %@", category.scheme);
    STAssertNil(category.label, @"Category label should be nil!");
       
    STAssertEquals([entry.customElements count], 1U, @"Entry should have 1 externsion element, had %d", [entry.customElements count]);
    STAssertTrue([[[entry.customElements valueForKey:@"thr:total"] content] isEqualToString:@"0"], @"Inavlid thr:total extension value, shoyld be 0 was %@", [[entry.customElements valueForKey:@"thr:total"] content]);
}

- (void)testFeedSix
{
    NSError *error = nil;
    BSAtomParser *parser = [BSAtomParser parser];
    BSAtomFeed *feed = [parser parseAtomFeedWithData:[self dataForFeed:@"samplefeed6.atom"] error:&error];
    
    STAssertNil(error, @"Did not expect an error. Reported error: %@", [error localizedDescription]);
    STAssertEquals([feed.entries count], 35U, @"Entires should be 35, was %d", [feed.entries count]);
    
    BSAtomFeedEntry *entry = [feed.entries objectAtIndex:0];
    STAssertTrue([entry.id isEqualToString:@"tag:github.com,2008:IssueCommentEvent/1352511158"], @"Entry id is invalid, should be tag:github.com,2008:IssueCommentEvent/1352511158, was %@", entry.id);
    
    BSAtomFeedCustomElement *customElem = [entry.customElements valueForKey:@"media:thumbnail"];
    STAssertNotNil(customElem, @"Custom element should not be nil!");
    STAssertEquals([customElem.attributes count], 3U, @"The custom element should have two attributes, was %d", [customElem.attributes count]);
    STAssertTrue([[customElem.attributes valueForKey:@"url"] isEqualToString:@"https://secure.gravatar.com/avatar/4b00d57778194e69ef79695bc4270d53?s=30&d=https://d3nwyuy0nl342s.cloudfront.net%2Fimages%2Fgravatars%2Fgravatar-140.png"], @"The custom element attribute url does not contain the expected content!");
    STAssertTrue([[customElem.attributes valueForKey:@"height"] isEqualToString:@"30"], @"height attribute should be 30!");
    STAssertTrue([[customElem.attributes valueForKey:@"width"] isEqualToString:@"30"], @"width attribute should be 30!");
}

- (void)testFeedSeven
{
    NSError *error = nil;
    BSAtomParser *parser = [BSAtomParser parser];
    BSAtomFeed *feed = [parser parseAtomFeedWithData:[self dataForFeed:@"samplefeed7.atom"] error:&error];
    
    STAssertNil(error, @"Did not expect an error. Reported error: %@", [error localizedDescription]);
    STAssertEquals([feed.entries count], 15U, @"There should be 10 entries, was: %d", [feed.entries count]);
    STAssertTrue([feed.rights.content isEqualToString:@"Copyright 2007, HuffingtonPost.com, Inc."], @"Title should be Copyright 2007, HuffingtonPost.com, Inc., was %@", feed.rights.content);    
    STAssertEquals([feed.links count], 4U, @"Feed should have 4 links, was %d", [feed.links count]);
    
    BSAtomFeedEntry *entry = [feed.entries objectAtIndex:0];
    STAssertEquals([entry.links count], 1U, @"Entry should have one link, was %d", [entry.links count]);
}

#pragma mark - Tests with delegate

- (void)testWithDelegate
{
    BSAtomParser *parser = [BSAtomParser parser];
    [parser parseAtomFeedWithData:[self dataForFeed:@"samplefeed1.atom"] delegate:self];
    
    // Fetch the feed (it's private but we know it's there). The feed should not have entries.
    BSAtomFeed *feed = [parser performSelector:@selector(atomFeed)];
    STAssertTrue([feed.entries count] == 0, @"Invalid amount of entries, should be 0 was %d", [feed.entries count]);
}


#pragma mark - BSAtomParserDelegate methods
- (void)atomParser:(BSAtomParser *)parser didFailWithError:(NSError *)error
{
    STAssertFalse(NO, @"Feed parsing shouldn't fail");
}

- (void)atomParser:(BSAtomParser *)parser didParseAtomFeed:(BSAtomFeed *)feed
{
    STAssertTrue([feed.title.content isEqualToString:@"Example Feed"], @"Invalid feed title. Title was: %@", feed.title.content);
    STAssertTrue([feed.id isEqualToString:@"urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6"], @"Invalid id. ID was: %@", feed.id);
    STAssertTrue([feed.entries count] == 0, @"Invalid amount of entries, should be 0 was %d", [feed.entries count]);
    STAssertTrue([feed.links count] == 1, @"Invalid amount of links, should be 1 was %d", [feed.entries count]);
    
    BSAtomFeedLink *link = [feed.links lastObject];
    STAssertTrue([link.href isEqualToString:@"http://example.org/"], @"Invalid link href, should be http://example.org/ was %@", link.href);
}

- (void)atomParser:(BSAtomParser *)parser didParseAtomFeedEntry:(BSAtomFeedEntry *)entry
{
    STAssertTrue([entry.title.content isEqualToString:@"Atom-Powered Robots Run Amok"], @"Invalid entry title. Title was: %@", entry.title.content);
    BSAtomFeedLink *entrylink = [entry.links lastObject];
    STAssertTrue([entrylink.href isEqualToString:@"http://example.org/2003/12/13/atom03"], @"Invalid link href, should be http://example.org/2003/12/13/atom03 was %@", entrylink.href);
}

@end
