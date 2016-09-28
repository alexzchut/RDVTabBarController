//
//  UIFont+BFRFonts.h
//  BFRStyleGuide
//
//  Created by Andrew Yates on 22/06/2015.
//  Copyright © 2015 Andrew Yates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (BFRFonts)

+ (UIFont *)bfr_lightFontOfSize:(CGFloat)size;
+ (UIFont *)bfr_lightFontOfDynamicSize:(CGFloat)size;

+ (UIFont *)bfr_regularFontOfSize:(CGFloat)size;
+ (UIFont *)bfr_regularFontOfDynamicSize:(CGFloat)size;

+ (UIFont *)bfr_mediumFontOfSize:(CGFloat)size;
+ (UIFont *)bfr_mediumFontOfDynamicSize:(CGFloat)size;

+ (UIFont *)bfr_semiboldFontOfSize:(CGFloat)size;
+ (UIFont *)bfr_semiboldFontOfDynamicSize:(CGFloat)size;

@end
