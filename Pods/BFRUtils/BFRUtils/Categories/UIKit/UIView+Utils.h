//
//  UIView+Utils.h
//  BFRUtils
//
//  Created by Jordan Morgan on 2/23/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

/**
 *  Adds the collection of views to the view hierarchy of the view instance.
 *
 *  @param views The views to be added as a subview to this view.
 */
- (void)addSubviews:(NSArray <UIView *> * _Nonnull)views;

/**
 *  Removes all of the receiver's subviews.
 */
- (void)removeSubviews;

/** View's X Position */
@property (nonatomic, assign) CGFloat   x;

/** View's Y Position */
@property (nonatomic, assign) CGFloat   y;

/** View's width */
@property (nonatomic, assign) CGFloat   width;

/** View's height */
@property (nonatomic, assign) CGFloat   height;

/** View's origin - Sets X and Y Positions */
@property (nonatomic, assign) CGPoint   origin;

/** View's size - Sets Width and Height */
@property (nonatomic, assign) CGSize    size;

/** Y value representing the bottom of the view **/
@property (nonatomic, assign) CGFloat   bottom;

/** X Value representing the right side of the view **/
@property (nonatomic, assign) CGFloat   right;

/** X Value representing the top of the view (alias of x) **/
@property (nonatomic, assign) CGFloat   left;

/** Y Value representing the top of the view (alias of y) **/
@property (nonatomic, assign) CGFloat   top;

/** X value of the object's center **/
@property (nonatomic, assign) CGFloat   centerX;

/** Y value of the object's center **/
@property (nonatomic, assign) CGFloat   centerY;

/** Returns the Subview with the highest X value **/
@property (nonatomic, strong, readonly) UIView *_Nullable lastSubviewOnX;

/** Returns the Subview with the highest Y value **/
@property (nonatomic, strong, readonly) UIView *_Nullable lastSubviewOnY;

/** View's bounds X value **/
@property (nonatomic, assign) CGFloat   boundsX;

/** View's bounds Y value **/
@property (nonatomic, assign) CGFloat   boundsY;

/** View's bounds width **/
@property (nonatomic, assign) CGFloat   boundsWidth;

/** View's bounds height **/
@property (nonatomic, assign) CGFloat   boundsHeight;

/**
 Centers the view to its parent view (if exists)
 */
-(void) centerToParent;

@end
