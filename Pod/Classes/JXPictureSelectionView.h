//
//  JXPictureSelectionView.h
//

#import <UIKit/UIKit.h>
#import "JXPictureSelectionViewConfiguration.h"

@interface JXPictureSelectionView : UIView

@property (strong,nonatomic) JXPictureSelectionViewConfiguration* config;
@property (strong,nonatomic) NSMutableArray* pictures;

-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame configuration:(JXPictureSelectionViewConfiguration*)configuration;

-(void)addPicture:(UIImage*)picture;
-(void)addPictures:(NSArray*)pictures;

@end
