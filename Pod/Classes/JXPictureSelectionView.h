//
//  JXPictureSelectionView.h
//

#import <UIKit/UIKit.h>
#import "JXPictureSelectionViewConfiguration.h"

typedef void(^JXPictureSelectionViewAddButtonAction)();

@interface JXPictureSelectionView : UIView

@property (strong,nonatomic) JXPictureSelectionViewConfiguration* config;
@property (strong,nonatomic) NSMutableArray* pictures;
@property (copy,nonatomic) JXPictureSelectionViewAddButtonAction addButtonAction;

-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame configuration:(JXPictureSelectionViewConfiguration*)configuration;

-(void)addPicture:(UIImage*)picture;
-(void)addPictures:(NSArray*)pictures;

@end
