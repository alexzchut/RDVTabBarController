//
//  NSString+Utils.h
//  BFRUtils
//
//  Created by Jordan Morgan on 2/23/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

/**
 *  Returns a new @c NSString instance created from this instance if UTF8 encoded, and without http:// or https:// prepended.
 *
 *  @return The newly encoded string.
 */
- (NSString *)encodeImageURL;

/**
 *  Detects whether or not the instance has no content.
 *
 *  @return YES if the string is equal to "" or yet to be initialized.
 */
- (BOOL)isEmpty;

/**
 *  Detects whether or not the instance has content.
 *
 *  @return YES if the string has any content.
 */
- (BOOL)isNotEmpty;

/**
 *  Detects whether or not the instance is a well formed email
 *
 *  @return YES if the string represents a valid email
 */
- (BOOL)isValidEmail;

/**
 *  Detects the current device and returns it as a string.
 *
 *  @return The device model, i.e. "iPad2,1" for iPad 2.
 */
+ (NSString *)currentDeviceString;

/**
 *  Returns YES for objectively older and less powerful devices. Currently, that's iPhone 5S and below as well as iPad Mini 2 and below.
 *
 *  @return YES if the device meets the current criteria for being an older device as listed above.
 */
+ (BOOL)deviceIsLowerEnd;

@end
