//
//  BFRImageProxies.m
//  BFRUtils
//
//  Created by Jordan Morgan on 2/22/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import "BFRImageProxies.h"
#import <UIKit/UIKit.h>

@interface BFRImageProxies()

@end

@implementation BFRImageProxies


- (instancetype)initWithService:(BFRImageProxyServiceType)service width:(NSUInteger)width height:(NSUInteger)height {
    return [self initWithWidth:width height:height];;
}


- (instancetype)initWithWidth:(NSUInteger)width height:(NSUInteger)height {
    self = [super init];
    
    if (self) {
        self.width = width;
        self.height = height;
        self.weServImageQuality = 100;
    }
    
    return self;
}

+ (NSString *)URLStringFromMedia:(NSDictionary *)media {
    NSString *imageURLString;
    if([media valueForKey:@"picture"] && ![[media valueForKey:@"picture"] isKindOfClass:[NSNull class]]){
        imageURLString = [media valueForKey:@"picture"];
    } else if([media valueForKey:@"photo"] && ![[media valueForKey:@"photo"] isKindOfClass:[NSNull class]]){
        imageURLString = [media valueForKey:@"photo"];
    } else if([media valueForKey:@"fullsize"] && ![[media valueForKey:@"fullsize"] isKindOfClass:[NSNull class]]){
        imageURLString = [media valueForKey:@"fullsize"];
    } else if([media valueForKey:@"imageURL"] && ![[media valueForKey:@"imageURL"] isKindOfClass:[NSNull class]]){
        imageURLString = [media valueForKey:@"imageURL"];
    } else if([media valueForKey:@"thumbnail"] && ![[media valueForKey:@"thumbnail"] isKindOfClass:[NSNull class]]){
        imageURLString = [media valueForKey:@"thumbnail"];
    }
    return imageURLString;
}

+ (BOOL)mediaIsGIF:(NSDictionary *)media {
    if (media == nil) {
        return NO;
    }
    if ([[media valueForKey:@"type"] isEqualToString:@"gif"]) {
        return YES;
    }
    
    NSString *urlString = [self URLStringFromMedia:media];
    
    return [self URLStringIsGIF:urlString];
}

+ (BOOL)URLStringIsGIF:(NSString *)urlString {
    if (urlString == nil) {
        return NO;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [self URLIsGIF:url];
}

+ (BOOL)URLIsGIF:(NSURL *)url {
    if (url == nil) {
        return NO;
    }
    
    return [@"gif" isEqualToString:[url.pathExtension lowercaseString]];
}

+ (BOOL)assetIsGif:(PHAsset *)asset {
    if (asset == nil) {
        return NO;
    }
    
    return [asset valueForKey:@"uniformTypeIdentifier"] && [((NSString *)[asset valueForKey:@"uniformTypeIdentifier"]).lowercaseString containsString:@"gif"];
}

- (NSURL *)proxyURLForMedia:(NSDictionary *)media {
    NSString *imageURLString = [BFRImageProxies URLStringFromMedia:media];
    if (imageURLString == nil) {
        return nil;
    }
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    if (imageURL == nil) {
        return nil;
    }
    return [self proxyURLForURL:imageURL];
}

//Overloads for proxyURLforURL
- (NSURL *)proxyURLForURL:(NSURL *)imageURL {
    NSString *imageURLString = [imageURL absoluteString];
    return [self proxyURLForURLString:imageURLString type:BFRImageProxyTransformationNone];
}

- (NSURL *)proxyURLForURLString:(NSString *)imageURLString type:(BFRImageProxyTransformation)transformationType {
    return [self proxyURLForURLString:imageURLString type:transformationType width:self.width height:self.height];
}

- (NSURL *_Nullable)proxyURLForURLString:(NSString *_Nonnull)imageURLString type:(BFRImageProxyTransformation)transformationType service:(BFRImageProxyServiceType)type {
    return [self proxyURLForURLString:imageURLString type:transformationType width:self.width height:self.height];
}

- (NSURL *)proxyURLForURLString:(NSString *)imageURLString type:(BFRImageProxyTransformation)transformationType width:(NSUInteger)width height:(NSUInteger)height service:(BFRImageProxyServiceType)type {
    return [self proxyURLForURLString:imageURLString type:transformationType width:width height:height];
}

- (NSURL *)proxyURLForURLString:(NSString *)imageURLString type:(BFRImageProxyTransformation)transformationType width:(NSUInteger)width height:(NSUInteger)height {
    
    // Generate image url using weserv proxy
    NSString *encodedImageURL = [imageURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodedImageURL = [encodedImageURL stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    encodedImageURL = [encodedImageURL stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    
    NSString *transformation = @"";
    if (transformationType == BFRImageProxyTransformationSquare) {
        transformation = @"&t=square";
    }
    
    //Already proxied?
    NSRange rangeOfParams = [encodedImageURL rangeOfString:@"?"];
    if (rangeOfParams.length > 0) {
        encodedImageURL = [encodedImageURL substringToIndex:rangeOfParams.location];
    }
    
    imageURLString = [NSString stringWithFormat:@"https://images.weserv.nl/?url=%@&w=%lu&h=%lu%@&q=%lu", encodedImageURL, (long)width, (long)height, transformation, (long)self.weServImageQuality];
    
    return [NSURL URLWithString:imageURLString];
}

- (NSArray *_Nonnull)proxyURLsForURLList:(NSArray *_Nonnull)imageURLList skipGIF:(BOOL)skipGIF service:(BFRImageProxyServiceType)service {
    return [self proxyURLsForURLList:imageURLList skipGIF:skipGIF];
}

- (NSArray *)proxyURLsForURLList:(NSArray *)imageURLList skipGIF:(BOOL)skipGIF {
    NSMutableArray *result = [NSMutableArray array];
    for (NSURL *url in imageURLList) {
        if (skipGIF && [BFRImageProxies URLIsGIF:url]) {
            // Skip GIF
            [result addObject:url];
        } else {
            NSURL *proxyURL = [self proxyURLForURL:url];
            [result addObject:proxyURL];
        }
    }
    return result;
}

- (NSArray *)proxyURLsForURLList:(NSArray *)imageURLList skipGIF:(BOOL)skipGIF type:(BFRImageProxyTransformation)transformationType width:(NSUInteger)width height:(NSUInteger)height service:(BFRImageProxyServiceType)service {
    return [self proxyURLsForURLList:imageURLList skipGIF:skipGIF type:transformationType width:width height:height];
}

- (NSArray *)proxyURLsForURLList:(NSArray *)imageURLList skipGIF:(BOOL)skipGIF type:(BFRImageProxyTransformation)transformationType width:(NSUInteger)width height:(NSUInteger)height {
    NSMutableArray *result = [NSMutableArray array];
    for (NSURL *url in imageURLList) {
        if (skipGIF && [BFRImageProxies URLIsGIF:url]) {
            // Skip GIF
            [result addObject:url];
        } else {
            NSURL *proxyURL = [self proxyURLForURLString:url.absoluteString type:transformationType width:width height:height];
            [result addObject:proxyURL];
        }
    }
    return result;
}
@end
