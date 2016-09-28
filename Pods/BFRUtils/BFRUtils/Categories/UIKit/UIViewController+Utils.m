//
//  UIViewController+Utils.m
//  BFRUtils
//
//  Created by Jordan Morgan on 2/23/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

#import "UIViewController+Utils.h"
#import "UIAlertController+Utils.h"

@implementation UIViewController (Utils)

- (void)showError:(NSError *)error title:(NSString *)title {
    [self showAlertControllerWithTitle:title message:error.localizedDescription];
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *close = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [ac addAction:close];
    
    [self presentViewController:ac animated:YES completion:nil];
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray<UIAlertAction *> *)actions {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addActions:actions];
    
    [self presentViewController:ac animated:YES completion:nil];
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message actions:(NSArray<UIAlertAction *> *)actions completion:(void (^)())completion {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addActions:actions];
    
    if (completion) {
        [self presentViewController:ac animated:YES completion:completion];
    } else {
        [self presentViewController:ac animated:YES completion:nil];
    }
}

@end
