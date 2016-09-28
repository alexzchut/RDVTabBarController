//
//  BKSubprofile.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 04/05/2015.
//  Copyright (c) 2015 Andrew Yates. All rights reserved.
//

#import "BKSubprofile.h"

@implementation BKSubprofile

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"profileID": @"id",
             @"avatarHTTPS": @"avatar",
             @"isShared": @"is_shared",
             @"name": @"name",
             @"service": @"service",
             @"url": @"url",
             @"userID": @"user_id"
             };
}

+ (NSValueTransformer *)avatarHTTPSJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end