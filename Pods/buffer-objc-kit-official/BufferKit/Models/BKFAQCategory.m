//
//  BKFAQCategory.m
//  BufferKitDemo
//
//  Created by Jordan Morgan on 2/9/16.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import "BKFAQCategory.h"

@implementation BKFAQCategory

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"categoryID": @"id",
             @"categoryURL": @"url",
             };
}

+ (NSValueTransformer *)categoryURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
