//
//  UIAlertController+Utils.m
//  BFRUtils
//
//  Created by Jordan Morgan on 2/23/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import "UIAlertController+Utils.h"

@implementation UIAlertController (Utils)
- (void)addActions:(NSArray<UIAlertAction *> *)actions {
    for (UIAlertAction *action in actions) {
        if ([action isKindOfClass:[UIAlertAction class]]) {
            [self addAction:action];
        }
    }
}
@end
