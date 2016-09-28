//
//  NSURL+Utils.m
//  BFRUtils
//
//  Created by Jordan Morgan on 4/13/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import "NSURL+Utils.h"
#import <UIKit/UIKit.h>
#import "NSString+Utils.h"

@implementation NSURL (Utils)

// Adds http scheme to the URL
- (NSURL *)urlWithScheme {

    if ([self.absoluteString isEmpty]) {
        return nil;
    }
    
    NSURL *testURL = [self copy];
    
    //Add the '//' in front, since 'http:buffer.com' will not produce a host, whereas 'http://buffer.com' does.
    //You can't set the '://' in the scheme property directly since it'll throw an exception.
    NSUInteger absoluteStringLength = [self.absoluteString length];

    if (absoluteStringLength < 2) {
        if ([self.absoluteString isEqualToString:@"/"]) {
            // Perhaps there are more cases we should handle and not only "/"
            return nil;
        } else {
            testURL = [NSURL URLWithString:[NSString stringWithFormat:@"//%@", self.absoluteString]];
        }
    } else {
        if (![[self.absoluteString substringToIndex:2] isEqualToString:@"//"] && !testURL.scheme) {
            testURL = [NSURL URLWithString:[NSString stringWithFormat:@"//%@", self.absoluteString]];
        }
    }
    
    NSURLComponents *componentsHTTP = [NSURLComponents componentsWithURL:testURL resolvingAgainstBaseURL:YES];
    componentsHTTP.scheme = @"http";
    NSURL *httpURL = componentsHTTP.URL;
    BOOL canOpenHTTP = [[UIApplication sharedApplication] canOpenURL:httpURL];
    if (canOpenHTTP && [httpURL isValidHTTPorHTTPS]) {
        return httpURL;
    }
    
    NSURLComponents *componentsHTTPS = [NSURLComponents componentsWithURL:testURL resolvingAgainstBaseURL:YES];
    componentsHTTPS.scheme = @"https";
    NSURL *httpsURL = componentsHTTPS.URL;
    BOOL canOpenHTTPS = [[UIApplication sharedApplication] canOpenURL:httpsURL];
    if (canOpenHTTPS && [httpsURL isValidHTTPorHTTPS]) {
        return httpsURL;
    }
    
    return nil;
}

- (BOOL)isValidHTTPorHTTPS {
    if (!self.scheme.length) {
        return NO;
    }
    
    // Ref: http://stackoverflow.com/a/5081447/223228
    if ([[self.scheme lowercaseString] isEqualToString:@"http"] ||  [[self.scheme lowercaseString] isEqualToString:@"https"]) {
        return YES;
    }
    
    // A non empty scheme that isn't HTTP nor HTTPS
    return NO;
}

- (BOOL)isValidURL {
    if (![self isValidHTTPorHTTPS]) {
        return NO;
    }
    
    if (!self.host || self.host.length <= 0) {
        return NO;
    }
    
    //Do domain parsing. See if there's a domain as part of the host, as "http://buffer" isn't valid
    if ([self.host rangeOfString:@"."].location == NSNotFound) {
        return NO;
    }
    
    NSURL *candidateURL = [NSURL URLWithString:self.absoluteString];
    
    if (!candidateURL) {
        return NO;
    }
    
    return YES;
}
@end
