//
//  Created by Björn Sållarp on 4/25/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSAtomFeedBase.h"
#import "BSAtomFeedLink.h"
#import "BSAtomFeedCategory.h"
#import "BSAtomFeedPerson.h"

@implementation BSAtomFeedBase
@synthesize id;
@synthesize title;
@synthesize updated;
@synthesize links;
@synthesize categories;
@synthesize authors;
@synthesize contributors;

- (void)dealloc {
    self.id = nil;
    self.title = nil;
    self.updated = nil;
    self.links = nil;
    self.categories = nil;
    self.authors = nil;
    self.contributors = nil;
    [super dealloc];
}

- (void)addLink:(BSAtomFeedLink *)link
{
    if (self.links == nil) {
        self.links = [NSMutableArray array];
    }
    
    [self.links addObject:link];
}

- (void)addCategory:(BSAtomFeedCategory *)category
{
    if (self.categories == nil) {
        self.categories = [NSMutableArray array];
    }
    
    [self.categories addObject:category];
}

- (void)addAuthor:(BSAtomFeedPerson *)person
{
    if (self.authors == nil) {
        self.authors = [NSMutableArray array];
    }
    
    [self.authors addObject:person];    
}

- (void)addContributor:(BSAtomFeedPerson *)person
{
    if (self.contributors == nil) {
        self.contributors = [NSMutableArray array];
    }
    
    [self.contributors addObject:person];    
}

+ (NSDate *)rfc3339DateFromString:(NSString *)string
{
    NSString *dateFormat = nil;
    
    if (string.length > 25) {
        string = [string stringByReplacingOccurrencesOfString:@":" 
                                                   withString:@""
                                                      options:0
                                                        range:NSMakeRange(25, string.length-25)];
        dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSZ";
    }
    else if (string.length >= 20) {
        string = [string stringByReplacingOccurrencesOfString:@":" 
                                                   withString:@""
                                                      options:0
                                                        range:NSMakeRange(20, string.length-20)];
    
        dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ssZ";
    }
    if (dateFormat) {
        if ([string hasSuffix:@"Z"]) {
            dateFormat = [dateFormat stringByReplacingOccurrencesOfString:@"Z" withString:@"'Z'"];
        }
        
        NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        NSLocale* enUSPOSIXLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease];
        assert(enUSPOSIXLocale != nil);
        [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setDateFormat:dateFormat];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        return [dateFormatter dateFromString:string];
    }
    
    return nil;
}

- (NSDate *)updatedDate 
{
    return [BSAtomFeedBase rfc3339DateFromString:self.updated];
}

@end
