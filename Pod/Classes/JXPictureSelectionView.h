//
//  JXPictureSelectionView.h
//

#import <UIKit/UIKit.h>
#import "JXPictureSelectionViewConfiguration.h"

typedef void(^JXPictureSelectionViewAddButtonAction)();
typedef void(^JXPictureSelectionViewLoadRemotePictureAction)(UIImageView* pictureView);

@interface JXPictureSelectionView : UIView

@property (strong,nonatomic) JXPictureSelectionViewConfiguration* config;
@property (strong,nonatomic) NSMutableArray* pictures;
@property (copy,nonatomic) JXPictureSelectionViewAddButtonAction addButtonAction;
@property (copy,nonatomic) JXPictureSelectionViewLoadRemotePictureAction loadRemotePictureAction;

-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame configuration:(JXPictureSelectionViewConfiguration*)configuration;

-(void)addPicture:(UIImage*)picture;
-(void)addPictures:(NSArray*)pictures;

-(void)addRemotePictureWithURL:(NSURL*)url;

@end
