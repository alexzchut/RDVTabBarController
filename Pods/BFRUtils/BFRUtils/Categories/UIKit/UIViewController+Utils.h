//
//  UIViewController+Utils.h
//  BFRUtils
//
//  Created by Jordan Morgan on 2/23/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

/**
 *  Displays a @c UIAlertController displaying the error's localized description as the message.
 *
 *  @param error The error that has occurred.
 *  @param title The title to display in the alert controller.
 */
- (void)showError:(NSError * _Nonnull)error title:(NSString * _Nonnull)title;

/**
 *  Displays a @c UIAlertController with the given title and message with a close action.
 *
 *  @param title   The desired title of the prompt.
 *  @param message The desired message of the prompt.
 */
- (void)showAlertControllerWithTitle:(NSString * _Nonnull)title message:(NSString * _Nonnull)message;

/**
 *  Displays a @c UIAlertController with the given title and message with a the supplied actions.
 *
 *  @param title   The desired title of the prompt.
 *  @param message The desired message of the prompt.
 *  @param actions The @c UIAlertAction instances that will be added to the alert controller.
 */
- (void)showAlertControllerWithTitle:(NSString * _Nonnull)title message:(NSString * _Nonnull)message actions:(NSArray <UIAlertAction *> * _Nonnull)actions;

/**
 *  Displays a @c UIAlertController with the given title and message with a the supplied actions.
 *
 *  @param title   The desired title of the prompt.
 *  @param message The desired message of the prompt.
 *  @param actions The @c UIAlertAction instances that will be added to the alert controller.
 *  @param completion An optional completion handler that will be invoked after the controller is dimissed, if supplied.
 */
- (void)showAlertControllerWithTitle:(NSString * _Nonnull)title message:(NSString * _Nonnull)message actions:(NSArray <UIAlertAction *> * _Nonnull)actions completion:(void (^ _Nullable)())completion;
@end
