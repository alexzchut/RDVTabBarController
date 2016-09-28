//
//  UIColor+BufferColors.h
//  Buffer
//
//  Created by Andrew Yates on 07/11/2013.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (BufferColors)

+ (UIColor *)bfr_primaryColor;
+ (UIColor *)bfr_headingColor;
+ (UIColor *)bfr_bodyColor;
+ (UIColor *)bfr_borderColor;
+ (UIColor *)bfr_lightBorderColor;
+ (UIColor *)bfr_fillColor;
+ (UIColor *)bfr_errorColor;
+ (UIColor *)bfr_warningColor;

+ (UIColor *)bfr_googleColor;
+ (UIColor *)bfr_twitterColor;
+ (UIColor *)bfr_facebookColor;
+ (UIColor *)bfr_linkedinColor;
+ (UIColor *)bfr_pinterestColor;
+ (UIColor *)bfr_adnColor;
+ (UIColor *)bfr_instagramColor;

+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end
