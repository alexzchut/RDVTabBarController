//
//  BFRNoticeControl.h
//  Buffer
//
//  Created by Andrew Yates on 20/12/2013.
//
//

#import <UIKit/UIKit.h>

@interface BFRButton : UIButton

typedef enum BFRButtonStyle : NSInteger BFRButtonStyle;
enum BFRButtonStyle : NSInteger {
    BFRButtonStyleRed,
    BFRButtonStyleGreen,
    BFRButtonStyleYellow,
    BFRButtonStyleBlue,
    BFRButtonStyleWhite,
    BFRButtonStyleWhiteText,
    BFRButtonStyleLink,
    BFRButtonStyleDelete,
    BFRButtonStyleText
};

@property (nonatomic) BFRButtonStyle buttonStyle;

typedef enum BFRButtonIconFont : NSInteger BFRButtonIconFont;
enum BFRButtonIconFont : NSInteger {
    BFRButtonIconFontSSStandard,
    BFRButtonIconFontIon,
    BFRButtonIconFontIonLarger
};

@property (nonatomic) BFRButtonIconFont buttonIconFont;

@property(nonatomic, getter=isHighlighted) BOOL highlighted;

- (void)setTitle:(NSString *)title;
- (void)setTitle:(NSString *)title withCount:(NSString *)count;
- (void)setTitle:(NSString *)title withIcon:(NSString *)icon;
- (void)setTitle:(NSString *)title withCount:(NSString *)count withIcon:(NSString *)icon;

@end
