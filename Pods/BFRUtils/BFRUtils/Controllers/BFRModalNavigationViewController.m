//
//  BFRModalNavigationViewController.m
//  BFRUtils
//
//  Created by Jordan Morgan on 9/28/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import "BFRModalNavigationViewController.h"

@implementation BFRModalNavigationViewController

#pragma mark - Status bar
- (BOOL)modalPresentationCapturesStatusBarAppearance {
    return YES;
}

-(BOOL)prefersStatusBarHidden{
    return self.shouldUseDarkStatusBar;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.shouldUseDarkStatusBar ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}

@end
