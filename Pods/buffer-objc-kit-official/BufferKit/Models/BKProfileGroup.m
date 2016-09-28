//
//  BKProfileGroup.m
//  Buffer
//
//  Created by Andrew Yates on 21/07/2014.
//
//

#import "BKProfileGroup.h"

@implementation BKProfileGroup

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"groupID": @"id",
        @"name": @"name",
        @"profileIDs": @"profile_ids",
        @"groupAvatar": @"avatar"
    };
}

@end
