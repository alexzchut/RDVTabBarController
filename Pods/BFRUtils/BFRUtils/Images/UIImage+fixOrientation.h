//
//  UIImage+fixOrientation.h
//  Buffer
//
//  Created by Andrew Yates on 07/11/2012.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (fixOrientation)

/**
 *  An instance fixed transformed correctly depending on the image orientation.
 */
@property (nonatomic, readonly, strong) UIImage *fixOrientation;

@end