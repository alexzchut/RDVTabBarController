//
//  BKFriend.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKFriend.h"

@implementation BKFriend

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"avatarURL": @"avatar",
        @"friendID": @"id",
        @"name": @"name",
        @"screenname": @"screen_name",
        @"canonicalSearchTerm": @"canonicalSearchTerm"
    };
}

+ (NSValueTransformer *)avatarURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
