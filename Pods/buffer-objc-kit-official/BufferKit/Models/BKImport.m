//
//  BKImport.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKImport.h"

@implementation BKImport

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"importID": @"id",
        @"createdAt": @"created_at",
        @"iconURL": @"icon",
        @"name": @"name",
        @"feedURL": @"parameters.feed_url",
        @"profileID": @"profile_id",
        @"twitterUsername": @"twitter_username",
        @"type": @"type",
    };
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^(NSNumber *date) {
        NSTimeInterval timeInterval = [date unsignedIntegerValue];
        return [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }];
}

+ (NSValueTransformer *)iconURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)feedURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
