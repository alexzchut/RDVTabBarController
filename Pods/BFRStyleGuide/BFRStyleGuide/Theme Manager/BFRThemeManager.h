//
//  BFRThemeManager.h
//  Buffer
//
//  Created by Andrew Yates on 27/08/2016.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BFRThemeManager : NSObject


+ (BFRThemeManager *)sharedManager;

@property (nonatomic, strong, readonly) NSDictionary *styles;
@property (nonatomic, strong, readwrite) NSString *currentThemeName;

- (UIFont *)fontForKey:(NSString *)key;

- (UIColor *)colorForKey:(NSString *)key;

- (UIImage *)imageForKey:(NSString *)key;

- (NSString *)stringForKey:(NSString *)key;

- (void)switchTheme:(NSString *)name;

@end
