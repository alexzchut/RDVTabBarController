
//
//  NSString+Utils.m
//  BFRUtils
//
//  Created by Jordan Morgan on 2/23/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import "NSString+Utils.h"
#import <sys/utsname.h> 

@implementation NSString (Utils)

- (NSString *)encodeImageURL {
    NSString *encodedImageURL = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodedImageURL = [encodedImageURL stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    encodedImageURL = [encodedImageURL stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    
    return encodedImageURL;
}

- (BOOL)isEmpty {
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isNotEmpty {
    return ![self isEmpty];
}

- (BOOL)isValidEmail {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

+ (NSString *)currentDeviceString {
    struct utsname systemInfo;
    uname(&systemInfo);

    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (BOOL)deviceIsLowerEnd {
    NSDictionary *lowerEndDevices = @{  @"iPod1,1"   :@"iPod Touch",        // (Original)
                                        @"iPod2,1"   :@"iPod Touch",        // (Second Generation)
                                        @"iPod3,1"   :@"iPod Touch",        // (Third Generation)
                                        @"iPod4,1"   :@"iPod Touch",        // (Fourth Generation)
                                        @"iPod7,1"   :@"iPod Touch",        // (6th Generation)
                                        @"iPhone1,1" :@"iPhone",            // (Original)
                                        @"iPhone1,2" :@"iPhone",            // (3G)
                                        @"iPhone2,1" :@"iPhone",            // (3GS)
                                        @"iPad1,1"   :@"iPad",              // (Original)
                                        @"iPad2,1"   :@"iPad 2",            //
                                        @"iPad3,1"   :@"iPad",              // (3rd Generation)
                                        @"iPhone3,1" :@"iPhone 4",          // (GSM)
                                        @"iPhone3,3" :@"iPhone 4",          // (CDMA/Verizon/Sprint)
                                        @"iPhone4,1" :@"iPhone 4S",         //
                                        @"iPhone5,1" :@"iPhone 5",          // (model A1428, AT&T/Canada)
                                        @"iPhone5,2" :@"iPhone 5",          // (model A1429, everything else)
                                        @"iPad3,4"   :@"iPad",              // (4th Generation)
                                        @"iPad2,5"   :@"iPad Mini",         // (Original)
                                        @"iPhone5,3" :@"iPhone 5c",         // (model A1456, A1532 | GSM)
                                        @"iPhone5,4" :@"iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                                        @"iPhone6,1" :@"iPhone 5s",         // (model A1433, A1533 | GSM)
                                        @"iPhone6,2" :@"iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                                        @"iPad4,4"   :@"iPad Mini",         // (2nd Generation iPad Mini - Wifi)
                                        @"iPad4,5"   :@"iPad Mini",         // (2nd Generation iPad Mini - Cellular)
                                    };
    
    return lowerEndDevices[[NSString currentDeviceString]] != nil;
}

@end
