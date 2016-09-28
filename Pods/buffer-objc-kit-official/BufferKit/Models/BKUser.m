//
//  BKUser.m
//  Buffer
//
//  Created by Andrew Yates on 01/08/2014.
//
//

#import "BKUser.h"

@implementation BKUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"billingGateway": @"billing_gateway",
             @"userID": @"id",
             @"email": @"email",
             @"experiments": @"experiments",
             @"features": @"features",
             @"hasBufferedUpdate": @"has_buffered_update",
             @"hasCardDetails": @"has_card_Details",
             @"hasHadTrial": @"has_had_trial",
             @"isNewUser": @"is_new_user",
             @"isOnTrial": @"on_trial",
             @"isAdmin": @"is_admin",
             @"name": @"name",
             @"plan": @"plan",
             @"profileLimit": @"profile_limit",
             @"profileUsage": @"profile_usage",
             @"profileGroups": @"profile_groups",
             @"secretEmail": @"secret_email",
             @"tags": @"tags",
             @"timezone": @"timezone",
             @"twentyfourHourTimeEnabled": @"twentyfour_hour_time",
             @"s3VideoSignature" : @"s3_video_signature",
    };
}

@end
