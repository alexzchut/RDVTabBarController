//
//  BKFeedPost.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 03/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKImportPost.h"

@implementation BKImportPost

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"importItemID": @"import_item_id",
        @"createdAt": @"created_at.sec",
        @"importIcon": @"import_icon",
        @"importType": @"import_type",
        @"media": @"media",
        @"text": @"text",
        @"shortenedLinks": @"shortened_links",
        @"via": @"via",
        @"viaURL": @"via_url",
        @"link": @"media.link"
    };
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^(NSNumber *created) {
        NSTimeInterval createdTimeInterval = [created unsignedIntegerValue];
        return [NSDate dateWithTimeIntervalSince1970:createdTimeInterval];
    }];
}

+ (NSValueTransformer *)importIconJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)viaURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)linkJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
