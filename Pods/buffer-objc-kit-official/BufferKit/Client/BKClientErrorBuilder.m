//
//  BKClientErrorBuilder.m
//  Pods
//
//  Created by Humberto Aquino on 11/4/15.
//
//

#import "BKClientErrorBuilder.h"

@implementation BKClientErrorBuilder

+ (NSError *)errorForCustomScheduleTimeFailure:(NSDate *)time {
    NSString *msg =  [NSString stringWithFormat: @"There was an error on our side with the selected schedule: '%@'. Please try again.", time];
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:msg};
    NSError *error = [NSError errorWithDomain:BKClientErrorDomain code:BKClientErrorCodesUnexpected userInfo:userInfo];
    return error;
}

@end
