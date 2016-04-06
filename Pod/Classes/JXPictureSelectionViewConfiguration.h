//
//  JXPictureSelectionViewConfiguration.h
//

#import <UIKit/UIKit.h>

@interface JXPictureSelectionViewConfiguration : NSObject

@property (assign,nonatomic) NSUInteger numberOfColumns;
@property (assign,nonatomic) CGFloat paddingLeft;
@property (assign,nonatomic) CGFloat paddingRight;
@property (assign,nonatomic) CGFloat paddingTop;
@property (assign,nonatomic) CGFloat paddingBottom;
@property (assign,nonatomic) CGFloat gap;
@property (assign,nonatomic) CGFloat aspectRatio;
@property (strong,nonatomic) UIImage* removeButtonImage;
@property (assign,nonatomic) CGSize removeButtonSize;

+(JXPictureSelectionViewConfiguration*)defaultConfiguration;

@end
