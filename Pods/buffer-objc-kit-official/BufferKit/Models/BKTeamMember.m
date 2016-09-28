//
//  BKTeamMember.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKTeamMember.h"

@implementation BKTeamMember

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"userID": @"_id",
        @"avatarURL": @"avatar",
        @"email": @"email",
        @"status": @"status",
        @"statusCode": @"status_code",
        @"isTFAEnabled": @"tfa_is_enabled",
    };
}

+ (NSValueTransformer *)avatarURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
