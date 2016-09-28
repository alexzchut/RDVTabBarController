//
//  UIFont+BFRFonts.m
//  BFRStyleGuide
//
//  Created by Andrew Yates on 22/06/2015.
//  Copyright © 2015 Andrew Yates. All rights reserved.
//

#import "UIFont+BFRFonts.h"

typedef NS_ENUM(NSUInteger, BFRFontWeight) {
    BFRFontWeightRegular,
    BFRFontWeightLight,
    BFRFontWeightMedium,
    BFRFontWeightSemibold,
    BFRFontWeightBold,
};

@implementation UIFont (BFRFonts)

#pragma mark - Light

+ (UIFont *)bfr_lightFontOfSize:(CGFloat)size {
    return [UIFont bfr_fontWithSize:size weight:BFRFontWeightLight];
}

+ (UIFont *)bfr_lightFontOfDynamicSize:(CGFloat)size {
    return [UIFont bfr_fontWithSize:(size + 2 + [self preferredFontSizeDelta]) weight:BFRFontWeightLight];
}

#pragma - Regular

+ (UIFont *)bfr_regularFontOfSize:(CGFloat)size {
    return [UIFont bfr_fontWithSize:size weight:BFRFontWeightRegular];
}

+ (UIFont *)bfr_regularFontOfDynamicSize:(CGFloat)size {
    return [UIFont bfr_fontWithSize:(size + 2 + [self preferredFontSizeDelta]) weight:BFRFontWeightRegular];
}

#pragma mark - Medium

+ (UIFont *)bfr_mediumFontOfSize:(CGFloat)size {
    return [UIFont bfr_fontWithSize:size weight:BFRFontWeightMedium];
}

+ (UIFont *)bfr_mediumFontOfDynamicSize:(CGFloat)size {
    return [UIFont bfr_fontWithSize:(size + 2 + [self preferredFontSizeDelta]) weight:BFRFontWeightMedium];
}


#pragma mark - Semibold

+ (UIFont *)bfr_semiboldFontOfSize:(CGFloat)size {
    return [UIFont bfr_fontWithSize:size weight:BFRFontWeightSemibold];
}

+ (UIFont *)bfr_semiboldFontOfDynamicSize:(CGFloat)size {
    return [UIFont bfr_fontWithSize:(size + 2 + [self preferredFontSizeDelta]) weight:BFRFontWeightSemibold];
}


#pragma mark - Internal Methods

+ (UIFont *)bfr_fontWithSize:(CGFloat)size weight:(BFRFontWeight)bfrWeight {
    if (![UIFont respondsToSelector:@selector(systemFontOfSize:weight:)]) {
        NSString *fontName = [self bfr_fontNameForVenmoWeight:bfrWeight];
        return [UIFont fontWithName:fontName size:size];
    }
    CGFloat weight = [self bfr_weightForVenmoWeight:bfrWeight];
    return [UIFont systemFontOfSize:size weight:weight];
}

+ (NSString *)bfr_fontNameForVenmoWeight:(BFRFontWeight)bfrWeight {
    NSString *fontName;
    switch (bfrWeight) {
        case BFRFontWeightRegular: {
            fontName = @"HelveticaNeue";
            break;
        }
        case BFRFontWeightLight: {
            fontName = @"HelveticaNeue-Light";
            break;
        }
        case BFRFontWeightMedium: {
            fontName = @"HelveticaNeue-Medium";
            break;
        }
        case BFRFontWeightSemibold: {
            fontName = @"HelveticaNeue-Semibold";
            break;
        }
        case BFRFontWeightBold: {
            fontName = @"HelveticaNeue-Bold";
            break;
        }
    }
    return fontName;
}

+ (CGFloat)bfr_weightForVenmoWeight:(BFRFontWeight)bfrWeight {
    CGFloat weight;
    switch (bfrWeight) {
        case BFRFontWeightRegular: {
            weight = UIFontWeightRegular;
            break;
        }
        case BFRFontWeightLight: {
            weight = UIFontWeightLight;
            break;
        }
        case BFRFontWeightMedium: {
            weight = UIFontWeightMedium;
            break;
        }
        case BFRFontWeightSemibold: {
            weight = UIFontWeightSemibold;
            break;
        }
        case BFRFontWeightBold: {
            weight = UIFontWeightBold;
            break;
        }
    }
    return weight;
}


+ (NSInteger)preferredFontSizeDelta {
    static NSArray *fontSizes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fontSizes = @[
                      UIContentSizeCategoryExtraSmall,
                      UIContentSizeCategorySmall,
                      UIContentSizeCategoryMedium,
                      UIContentSizeCategoryLarge,
                      UIContentSizeCategoryExtraLarge,
                      UIContentSizeCategoryExtraExtraLarge,
                      UIContentSizeCategoryExtraExtraExtraLarge,
                      UIContentSizeCategoryAccessibilityMedium,
                      UIContentSizeCategoryAccessibilityLarge,
                      UIContentSizeCategoryAccessibilityExtraLarge,
                      UIContentSizeCategoryAccessibilityExtraExtraLarge,
                      UIContentSizeCategoryAccessibilityExtraExtraExtraLarge,
                      ];
    });
    
    NSInteger currentSize = (NSInteger)[fontSizes indexOfObject:[UIApplication sharedApplication].preferredContentSizeCategory];
    
    if (currentSize == NSNotFound) {
        return 0;
    }
    
    // Default size is 'Large'
    return currentSize - [fontSizes indexOfObject:UIContentSizeCategoryLarge];
}


@end
