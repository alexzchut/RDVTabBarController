//
//  UIColor+BufferColors.m
//  Buffer
//
//  Created by Andrew Yates on 07/11/2013.
//
//

#import "UIColor+BFRColors.h"

@implementation UIColor (BFRColors)

#pragma mark - Style Guide Colors

+ (UIColor *)bfr_primaryColor {
    return [UIColor colorFromHexString:@"#168eea"];
}

+ (UIColor *)bfr_headingColor {
    return [UIColor colorFromHexString:@"#323b43"];
}

+ (UIColor *)bfr_bodyColor {
    return [UIColor colorFromHexString:@"#59626a"];
}

+ (UIColor *)bfr_borderColor {
    return [UIColor colorFromHexString:@"#ced7df"];
}

+ (UIColor *)bfr_lightBorderColor {
    return [UIColor colorFromHexString:@"#eff3f6"];
}

+ (UIColor *)bfr_fillColor {
    return [UIColor colorFromHexString:@"#f4f7f9"];
}

+ (UIColor *)bfr_errorColor {
    return [UIColor colorFromHexString:@"#ee4f4f"];
}

+ (UIColor *)bfr_warningColor {
    return [UIColor colorFromHexString:@"#fff9ea"];
}

#pragma mark - iOS Style Colors


#pragma mark - Social Networks

+ (UIColor *)bfr_googleColor {
    return [UIColor colorFromHexString:@"#dd4b39"];
}

+ (UIColor *)bfr_twitterColor {
    return [UIColor colorFromHexString:@"#55acee"];
}

+ (UIColor *)bfr_facebookColor {
    return [UIColor colorFromHexString:@"#3b5998"];
}

+ (UIColor *)bfr_linkedinColor {
    return [UIColor colorFromHexString:@"#007bb6"];
}

+ (UIColor *)bfr_pinterestColor {
    return [UIColor colorFromHexString:@"#bd081c"];
}

+ (UIColor *)bfr_adnColor {
    return [UIColor colorWithRed:74.0/255.0 green:72.0/255.0 blue:76.0/255.0 alpha:1.0];
}

+ (UIColor *)bfr_instagramColor {
    return [UIColor colorFromHexString:@"#e53c5f"];
}


#pragma mark - Color from Hex

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


@end
