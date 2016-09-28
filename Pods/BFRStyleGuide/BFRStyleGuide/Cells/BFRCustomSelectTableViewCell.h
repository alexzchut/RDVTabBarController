//
//  BFRCustomSelectTableViewCell.h
//  BFRStyleGuide
//
//  Created by Jordan Morgan on 6/16/16.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFRStyleGuide.h"

/**
 *  Subclass this table cell if you want to have selection styles on your cell. This takes care of
 *  the views and the top separator disappearing on selection.
 */
@interface BFRCustomSelectTableViewCell : UITableViewCell

/**
 *  If the cell is at the first index, you'll likely want to hide the top separator with this BOOL.
 */
@property (nonatomic) BOOL hideTopSeparator;

/**
 *  The cell's top separator color. A light gray is the default.
 */
@property (strong, nonatomic, nullable) UIColor *topSeparatorColor;
/**
 *  The background hight light color. A light gray is the default.
 */
@property (strong, nonatomic, nullable) UIColor *selectedBackgroundColor;
/**
 *  In this block, you should set your view's desired background color you want during selection.
 */
@property (copy, nullable) void (^setViewsForSelectedState)();

@end
