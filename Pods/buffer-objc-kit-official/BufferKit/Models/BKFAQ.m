//
//  BKFAQ.m
//  BufferKitDemo
//
//  Created by Jordan Morgan on 2/9/16.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import "BKFAQ.h"

@implementation BKFAQ

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"answer": @"answer",
             @"categoryID": @"category_id",
             @"isDraft": @"draft",
             @"faqID": @"id",
             @"orderInCategory": @"order_in_category",
             @"faqURL": @"url",
             };
}

+ (NSValueTransformer *)faqURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
