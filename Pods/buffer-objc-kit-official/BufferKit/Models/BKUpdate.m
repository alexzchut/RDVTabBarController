//
//  BKUpdateBase.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 17/07/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKUpdate.h"

@implementation BKUpdate

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"updateID": @"id",
        @"createdAt": @"created_at",
        @"dueDay": @"day",
        @"dueTime": @"due_time",
        @"dueDate": @"due_at",
        @"scheduledDate": @"scheduled_at",
        @"error": @"error",
        @"media": @"media",
        @"extraMedia": @"extra_media",
        @"profileID": @"profile_id",
        @"profileService": @"profile_service",
        @"retweet": @"retweet",
        @"status": @"status",
        @"text": @"text",
        @"textFormatted": @"text_formatted",
        @"type": @"type",
        @"updatedAt": @"updated_at",
        @"userID": @"user_id",
        @"client": @"client",
        @"via": @"via",
        @"sourceURL": @"source_url",
        @"isApprovable": @"perm_approvable",
        @"isEditable": @"perm_editable",
        @"isTopUpdate": @"is_top_update",
        @"serviceLink": @"service_link",
        @"statistics": @"statistics",
        @"sentDate": @"sent_at",
        @"sharedBy": @"shared_by",
        @"serviceUpdateId": @"service_update_id"
    };
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^(NSNumber *date) {
        NSTimeInterval timeInterval = [date unsignedIntegerValue];
        return [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }];
}

+ (NSValueTransformer *)dueDateJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^(NSNumber *created) {
        NSTimeInterval createdTimeInterval = [created unsignedIntegerValue];
        return [NSDate dateWithTimeIntervalSince1970:createdTimeInterval];
    }];
}

+ (NSValueTransformer *)scheduledDateJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^(NSNumber *created) {
        NSTimeInterval createdTimeInterval = [created unsignedIntegerValue];
        return [NSDate dateWithTimeIntervalSince1970:createdTimeInterval];
    }];
}

+ (NSValueTransformer *)serviceLinkJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)sentDateJSONTransformer {
    return [MTLValueTransformer transformerWithBlock:^(NSNumber *date) {
        NSTimeInterval timeInterval = [date unsignedIntegerValue];
        return [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }];
}

+ (NSValueTransformer *)subprofileJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[BKSubprofile class]];
}


@end
