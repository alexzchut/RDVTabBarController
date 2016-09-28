//
//  BKRetweetData.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKRetweetData.h"

@implementation BKRetweetData

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
         @"tweetID": @"id",
         @"createdAt": @"created_at",
         @"name": @"user.name",
         @"screenname": @"user.screen_name",
         @"userID": @"user.id_str",
         @"text": @"text",
         @"avatarHTTP": @"user.profile_image_url",
         @"avatarHTTPS": @"user.profile_image_url_https",
         @"tweetURL" : @"entities.media.expanded_url"
    };
}

+ (NSValueTransformer *)avatarHTTPJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)avatarHTTPSJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
