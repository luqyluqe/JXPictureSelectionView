//
//  JXPictureSelectionView.h
//

#import <UIKit/UIKit.h>
#import "JXPictureSelectionViewConfiguration.h"

typedef void(^JXPictureSelectionViewAddButtonAction)();
typedef void(^JXPictureSelectionViewLoadRemotePictureAction)(UIImageView* pictureView,NSURL* url);

@class JXPictureSelectionView;

@protocol JXPictureSelectionViewDelegate <NSObject>

-(void)pictureSelectionView:(JXPictureSelectionView*)pictureSelectionView didClickOnAddButton:(id)sender;
-(void)pictureSelectionView:(JXPictureSelectionView*)pictureSelectionView loadRemotePictureAtURL:(NSURL*)url intoPictureView:(UIImageView*)pictureView;
-(void)pictureSelectionView:(JXPictureSelectionView*)pictureSelectionView didClickOnPicture:(UIImage*)picture inPictureView:(UIImageView*)pictureView;

@end

@interface JXPictureSelectionView : UIView

@property (weak,nonatomic) id<JXPictureSelectionViewDelegate> delegate;
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
