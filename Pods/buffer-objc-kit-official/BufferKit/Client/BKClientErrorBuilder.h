//
//  BKClientErrorBuilder.h
//  Pods
//
//  Created by Humberto Aquino on 11/4/15.
//
//

#import <Foundation/Foundation.h>

// Domains
static NSString *const BKClientErrorDomain = @"buffer-objc-kit";
// Error codes
typedef enum BKClientErrorCodes : NSInteger {
    BKClientErrorCodesUnexpected = 1000
} BKClientErrorCodes;


// This class groups utility methods to create error objects for the buffer-objc-kit project
@interface BKClientErrorBuilder : NSObject

+ (NSError *)errorForCustomScheduleTimeFailure:(NSDate *)time;

@end
