//
//  Created by Björn Sållarp on 4/25/11.
//  NO Copyright, NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "BSAtom.h"

NSString * const BSParserErrorDomain = @"BSParserErrorDomain";
NSString * const kBSXMLParserAtomNamespaceURI = @"http://www.w3.org/2005/Atom";

@interface BSAtomParser()
@property (nonatomic, retain) BSAtomFeed *atomFeed;
@property (nonatomic, retain) NSString *baseNamespace;
@property (nonatomic, retain) NSMutableString *elementContent;
@property (nonatomic, retain) NSMutableArray *elementHeirarchy;
@property (nonatomic, retain) NSString *tagSoupElement;
@property (nonatomic, assign) id<BSAtomParserDelegate> delegate;
@end

@implementation BSAtomParser
@synthesize tagSoupElement = tagSoupElement_;
@synthesize atomFeed = atomFeed_;
@synthesize baseNamespace = baseNamespace_;
@synthesize elementContent = elementContent_;
@synthesize elementHeirarchy = elementHeirarchy_; 
@synthesize delegate = delegate_;

+ (BSAtomParser *)parser
{
    return [[[self alloc] init] autorelease];
}

- (BSAtomFeed *)parseAtomFeedWithData:(NSData *)feedData error:(NSError **)error
{
    NSXMLParser *atomParser = [[NSXMLParser alloc] initWithData:feedData];
    if (atomParser == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:BSParserErrorDomain code:1 userInfo:nil];
        }
		return nil;
	}
    
    self.elementHeirarchy = [NSMutableArray array];

	[atomParser setDelegate:self];
	[atomParser setShouldProcessNamespaces:YES];
	if (![atomParser parse] && error != NULL) {
        *error = [atomParser parserError];
    }
    
    [atomParser release];
    return self.atomFeed;
}

- (void)parseAtomFeedWithData:(NSData *)feedData delegate:(id<BSAtomParserDelegate>)delegate
{
    self.delegate = delegate;
    
    NSXMLParser *atomParser = [[NSXMLParser alloc] initWithData:feedData];
    if (atomParser == nil) {
        [self.delegate atomParser:self didFailWithError:[NSError errorWithDomain:BSParserErrorDomain code:1 userInfo:nil]];
	}
    else {
        self.elementHeirarchy = [NSMutableArray array];
        [atomParser setDelegate:self];
        [atomParser setShouldProcessNamespaces:YES];
        if (![atomParser parse]) {
            [self.delegate atomParser:self didFailWithError:[atomParser parserError]];
        }        
    }
    
    [atomParser release];
}


- (void)dealloc
{
    self.tagSoupElement = nil;
    self.elementContent = nil;
    self.elementHeirarchy = nil;
    self.atomFeed = nil;
    self.baseNamespace = nil;
    [super dealloc];
}

#pragma mark - Help methiods
- (void)setPropertyValueForObject:(id)destination value:(id)value withPropertyPrefix:(NSString *)prefix andPropertyName:(NSString *)propertyName
{
    NSString *selectorString = [NSString stringWithFormat:@"%@%@%@:", prefix, [[propertyName substringToIndex:1] uppercaseString], [propertyName substringFromIndex:1]];
    SEL selector = NSSelectorFromString(selectorString);
    if ([destination respondsToSelector:selector]) {
        [destination performSelector:selector withObject:value];
    }
}

- (BOOL)isPlainTextElement:(NSString *)elementName
{
    if ([elementName isEqualToString:@"id"] || 
        [elementName isEqualToString:@"updated"] || 
        [elementName isEqualToString:@"name"] ||
        [elementName isEqualToString:@"email"] ||
        [elementName isEqualToString:@"uri"] ||
        [elementName isEqualToString:@"icon"] ||
        [elementName isEqualToString:@"logo"]) {
        return true;
    }
    
    return false;
}

- (BOOL)isAtomTextConstruct:(NSString *)elementName
{
    if ([elementName isEqualToString:@"title"] || 
        [elementName isEqualToString:@"summary"] || 
        [elementName isEqualToString:@"content"] ||
        [elementName isEqualToString:@"subtitle"] ||
        [elementName isEqualToString:@"rights"]) {
            return true;
    }
    
    return false;
}

#pragma mark - NSXMLParser delegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.atomFeed = [BSAtomFeed atomFeed];
    [self.elementHeirarchy addObject:self.atomFeed];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (!self.baseNamespace && [namespaceURI isEqualToString:kBSXMLParserAtomNamespaceURI]) {
        self.baseNamespace = namespaceURI;
    }
    
    if (!self.baseNamespace) {
        [parser abortParsing];
    }
    
    id currentElement = [self.elementHeirarchy lastObject];
    
    if (self.tagSoupElement) {
        [self.elementContent appendFormat:@"<%@", elementName];            
        for (NSString *key in attributeDict) {
            [self.elementContent appendFormat:@" %@=\"%@\"", key, [attributeDict valueForKey:key]];                
        }
        [self.elementContent appendString:@">"];
    }
    else if ([self isAtomTextConstruct:elementName]) {
        [self.elementHeirarchy addObject:[BSAtomFeedTextElement textElementWithType:[attributeDict valueForKey:@"type"]]];
        self.elementContent = [NSMutableString string];
        self.tagSoupElement = qName;
    }
    else if ([self isPlainTextElement:elementName]) {
            self.elementContent = [NSMutableString string];
    }
    else if ([elementName isEqualToString:@"contributor"] || [elementName isEqualToString:@"author"]) {
        [self.elementHeirarchy addObject:[BSAtomFeedPerson person]];
    }
    else if ([elementName isEqualToString:@"entry"]) {
        [self.elementHeirarchy addObject:[BSAtomFeedEntry entry]];
    }
    else if ([elementName isEqualToString:@"generator"]) {
        [self.elementHeirarchy addObject:[BSAtomFeedGenerator generatorWithUri:[attributeDict valueForKey:@"uri"] version:[attributeDict valueForKey:@"version"] text:nil]];
        self.elementContent = [NSMutableString string];
    }
    else if ([elementName isEqualToString:@"category"] && [currentElement respondsToSelector:@selector(addCategory:)]) {
        BSAtomFeedCategory *category = [BSAtomFeedCategory categoryWithTerm:[attributeDict valueForKey:@"term"] scheme:[attributeDict valueForKey:@"scheme"] label:[attributeDict valueForKey:@"label"]];
        [currentElement performSelector:@selector(addCategory:) withObject:category];
    }
    else if ([currentElement class] == [BSAtomFeedEntry class]) {    
        if (![namespaceURI isEqualToString:kBSXMLParserAtomNamespaceURI]) {
            BSAtomFeedEntry *entry = (BSAtomFeedEntry *)currentElement;
            if (entry.customElements == nil) {
                entry.customElements = [NSMutableArray array];
            }
            
            BSAtomFeedCustomElement *customElement = [BSAtomFeedCustomElement elementWithName:qName content:nil attributes:attributeDict];
            [entry.customElements addObject:customElement];
            
            self.tagSoupElement = qName;
            self.elementContent = [NSMutableString string];
        }
    }
    
    if ([elementName isEqualToString:@"link"] && [[self.elementHeirarchy lastObject] respondsToSelector:@selector(addLink:)]) {
        BSAtomFeedLink *link = [BSAtomFeedLink linkWithHref:[attributeDict valueForKey:@"href"] rel:[attributeDict valueForKey:@"rel"]];
        [[self.elementHeirarchy lastObject] performSelector:@selector(addLink:) withObject:link];
    }
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    [self.delegate atomParser:self didFailWithError:validationError];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    id currentElement = [self.elementHeirarchy lastObject];
    
    if (self.tagSoupElement && ![self.tagSoupElement isEqualToString:qName]) {
        [self.elementContent appendFormat:@"</%@>", elementName];
    }
    else if ([elementName isEqualToString:@"entry"]) {
        if (self.delegate) {
            [self.delegate atomParser:self didParseAtomFeedEntry:currentElement];
        }
        else {
            [self.atomFeed addEntry:currentElement];
        }
        
        [self.elementHeirarchy removeLastObject];
    }
    else if ([self isAtomTextConstruct:elementName]) {
        BSAtomFeedTextElement *textElement = [(BSAtomFeedTextElement *)currentElement retain];
        textElement.content = self.elementContent;
        self.elementContent = nil;
        self.tagSoupElement = nil;
        [self.elementHeirarchy removeLastObject];        
        
        [self setPropertyValueForObject:[self.elementHeirarchy lastObject] value:textElement withPropertyPrefix:@"set" andPropertyName:elementName];
        [textElement release];
    }
    else if ([elementName isEqualToString:@"generator"]) {
        [self setPropertyValueForObject:currentElement value:self.elementContent withPropertyPrefix:@"set" andPropertyName:@"text"];
        id value = [currentElement retain];
        [self.elementHeirarchy removeLastObject];
        
        [self setPropertyValueForObject:[self.elementHeirarchy lastObject] value:value withPropertyPrefix:@"set" andPropertyName:elementName];
        [value release];
    }
    else if ([elementName isEqualToString:@"contributor"] || [elementName isEqualToString:@"author"]) {
        id value = [currentElement retain];
        [self.elementHeirarchy removeLastObject];
        [self setPropertyValueForObject:[self.elementHeirarchy lastObject] value:value withPropertyPrefix:@"add" andPropertyName:elementName];
        [value release];
    }
    else if ([self.tagSoupElement isEqualToString:qName] && [currentElement respondsToSelector:@selector(customElements)]) {
        NSMutableArray *array = [currentElement performSelector:@selector(customElements)];
        BSAtomFeedCustomElement *customElem = [array lastObject];
        customElem.content = self.elementContent;
        self.elementContent = nil;
        self.tagSoupElement = nil;     
    }
    else if ([elementName isEqualToString:@"feed"]) {
        if (self.delegate) {
            [self.delegate atomParser:self didParseAtomFeed:self.atomFeed];
        }
    }
    else if (self.elementContent) {
        [self setPropertyValueForObject:currentElement value:self.elementContent withPropertyPrefix:@"set" andPropertyName:elementName];
    }
     
    if (!self.tagSoupElement) {
        self.elementContent = nil;
    }
}
        
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.elementContent appendString:string];
}

@end
