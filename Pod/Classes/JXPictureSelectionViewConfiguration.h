//
//  JXPictureSelectionViewConfiguration.h
//

#import <UIKit/UIKit.h>

@interface JXPictureSelectionViewConfiguration : NSObject

@property (assign,nonatomic) NSUInteger capacity;
@property (assign,nonatomic) NSUInteger numberOfColumns;
@property (assign,nonatomic) CGFloat paddingLeft;
@property (assign,nonatomic) CGFloat paddingRight;
@property (assign,nonatomic) CGFloat paddingTop;
@property (assign,nonatomic) CGFloat paddingBottom;
@property (assign,nonatomic) CGFloat rowGap;
@property (assign,nonatomic) CGFloat columnGap;
@property (assign,nonatomic) CGFloat aspectRatio;
@property (strong,nonatomic) UIImage* removeButtonImage;
@property (assign,nonatomic) CGSize removeButtonSize;
@property (strong,nonatomic) UIImage* addButtonImage;
@property (copy,nonatomic) UIColor* addButtonBackgroundColor;
@property (assign,nonatomic) NSTimeInterval animationDuration;

+(JXPictureSelectionViewConfiguration*)defaultConfiguration;

@end
