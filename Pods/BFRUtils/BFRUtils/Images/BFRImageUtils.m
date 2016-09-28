//
//  BFRImageUtils.m
//  BFRComposer
//
//  Created by Humberto Aquino on 1/6/16.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import "BFRImageUtils.h"

@implementation BFRImageUtils

#pragma mark - Gif Detection

+ (BOOL)isGIF:(CGImageSourceRef)imageSource {
    return UTTypeConformsTo(CGImageSourceGetType(imageSource), kUTTypeGIF);
}

+ (BOOL)isAnimatedGIF:(CGImageSourceRef)imageSource {
    return [self isGIF:imageSource] && CGImageSourceGetCount(imageSource) > 1;
}

+ (UIImage *)GIFToPng:(NSData *)gifData {
    UIImage *animatedGIF = [UIImage imageWithData:gifData];
    NSData *dataForPNGFile = UIImagePNGRepresentation(animatedGIF);
    UIImage *image = [UIImage imageWithData:dataForPNGFile];
    return image;
}

+ (CGRect)scaleImage:(UIImage *)image toView:(UIView *)view {
    //Set the aspect ratio of the image
    float hfactor = image.size.width / view.bounds.size.width;
    float vfactor = image.size.height / view.bounds.size.height;
    float factor = fmax(hfactor, vfactor);
    
    //Divide the size by the greater of the vertical or horizontal shrinkage factor
    float newWidth = image.size.width / factor;
    float newHeight = image.size.height / factor;
    
    //Then figure out offset to center vertically or horizontally
    float leftOffset = (view.bounds.size.width - newWidth) / 2;
    float topOffset = (view.bounds.size.height - newHeight) / 2;
    
    //Reposition image view
    CGRect newRect = CGRectMake(leftOffset, topOffset, newWidth, newHeight);
    
    //Check for any NaNs, which should get corrected in the next drawing cycle
    BOOL isInvalidRect = (isnan(leftOffset) || isnan(topOffset) || isnan(newWidth) || isnan(newHeight));
    return isInvalidRect ? CGRectZero : newRect;
}

@end
