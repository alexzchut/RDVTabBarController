//
//  BFRModalNavigationViewController.h
//  BFRUtils
//
//  Created by Jordan Morgan on 9/28/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 In iOS 9, if you present a controller modally in a navigation controller, the nav controller will be responsible for setting the status bar appearances. Use this class for those scenarios.
 */
@interface BFRModalNavigationViewController : UINavigationController


/**
 Default is NO. If set to YES, this will toggle the status bar to the default black when [self setNeedsStatusBarAppearanceUpdate] is invoked.
 */
@property (nonatomic, getter=shouldUseDarkStatusBar) BOOL useDarkStatusBar;


/**
 DEfault is NO. If set to YES, this will hide the status bar when [self setNeedsStatusBarAppearanceUpdate] is invoked.
 */
@property (nonatomic, getter=shouldHideStatusBar) BOOL hideStatusBar;

@end
