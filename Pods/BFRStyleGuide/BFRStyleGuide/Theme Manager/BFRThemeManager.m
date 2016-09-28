//
//  BFRThemeManager.m
//  Buffer
//
//  Created by Andrew Yates on 27/08/2016.
//
//

#import "BFRThemeManager.h"

NSString * const BFRThemeManagerDidChangeTheme = @"BFRThemeManagerDidChangeTheme";

@interface BFRThemeManager()

@property (nonatomic, strong, readwrite) NSDictionary *styles;
    
@end
    
@implementation BFRThemeManager

+ (BFRThemeManager *)sharedManager {
    static BFRThemeManager *_sharedTheme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTheme = [[self alloc] init];
    });
    
    return _sharedTheme;
}


- (id)init {
    if (self = [super init]) {
        NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.buffer.buffer"];
        NSString *themeName = [defaults objectForKey:@"com.buffer.BFRThemeManager.defaulttheme"];
        if (! themeName) {
            themeName = @"default";
        }
        
        [self switchTheme:themeName];
    }
    return self;
}

#pragma mark - Setters

- (void)setStyles:(NSDictionary *)styles {
    BOOL isFirst = _styles == nil;
    _styles = styles;
    if (! isFirst) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BFRThemeManagerDidChangeTheme object:nil];
    }
}

- (void)setCurrentThemeName:(NSString *)currentThemeName {
    _currentThemeName = currentThemeName;
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.buffer.buffer"];
    [defaults setObject:currentThemeName forKey:@"com.buffer.BFRThemeManager.defaulttheme"];
    [defaults synchronize];
}

#pragma mark - Actions

- (void)switchTheme:(NSString *)name {
    if ([name isEqualToString:self.currentThemeName]) {
        return;
    }
    
    self.currentThemeName = name;
    NSString *path = [[NSBundle mainBundle] pathForResource:self.currentThemeName ofType:@"plist"];
    NSDictionary *styles = [NSDictionary dictionaryWithContentsOfFile:path];
    
    // if our theme inherits from another, merge
    if (styles[@"INHERITED_THEME"] != nil) {
        styles = [self inheritedThemeWithParentTheme:styles[@"INHERITED_THEME"] childTheme:styles];
    }
    
    self.styles = styles;
}

- (NSDictionary *)inheritedThemeWithParentTheme:(NSString *)parentThemeName childTheme:(NSDictionary *)childTheme {
    NSString *path = [[NSBundle mainBundle] pathForResource:parentThemeName ofType:@"plist"];
    NSMutableDictionary *parent = [[NSDictionary dictionaryWithContentsOfFile:path] mutableCopy];
    
    // merge child into parent overriding parent values
    [childTheme enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        parent[key] = obj;
    }];
    
    return parent;
}

#pragma mark - Constants

#pragma mark - Fonts

- (UIFont *)fontForKey:(NSString*)key {
    NSString *sizeKey = [key stringByAppendingString:@"Size"];
    
    NSString *fontName = self.styles[key];
    NSString *size = self.styles[sizeKey];
    
    while (self.styles[fontName]) {
        fontName = self.styles[fontName];
    }
    
    while (self.styles[size]) {
        size = self.styles[size];
    }
    
    if (fontName && size) {
        return [UIFont fontWithName:fontName size:size.floatValue];
    }
    return nil;
}

#pragma mark - Colors

- (UIColor *)colorForKey:(NSString *)key {
    NSString *hexString = self.styles[key];
    
    while (self.styles[hexString]) {
        hexString = self.styles[hexString];
    }
    
    if (hexString) {
        return [self colorFromHexString:hexString];
    }
    return nil;
}

#pragma mark - Images

- (UIImage *)imageForKey:(NSString *)key {
    NSString *imageName = self.styles[key];
    
    while (self.styles[imageName]) {
        imageName = self.styles[imageName];
    }
    
    if (imageName) {
        return [UIImage imageNamed:imageName];
    }
    return nil;
}

#pragma mark - String

- (NSString *)stringForKey:(NSString *)key {
    NSString *string = self.styles[key];
    
    while (self.styles[string]) {
        string = self.styles[string];
    }
    
    if (string) {
        return string;
    }
    return nil;
}

#pragma mark - Color from Hex

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
