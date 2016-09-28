//
//  UIAlertController+Utils.h
//  BFRUtils
//
//  Created by Jordan Morgan on 2/23/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Utils)

/**
 *  Attaches action objects to the alert or action sheet.
 *
 *  @param actions An @c NSArray of actions to add to the controller. They will appear in the same order of their index in the array.
 */
- (void)addActions:(NSArray <UIAlertAction *> * _Nonnull)actions;

@end
