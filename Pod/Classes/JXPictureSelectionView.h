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
-(void)pictureSelectionView:(JXPictureSelectionView*)pictureSelectionView didTapOnPictureView:(UIImageView*)pictureView atIndex:(NSInteger)index;
-(void)pictureSelectionView:(JXPictureSelectionView*)pictureSelectionView didRemovePictureAtIndex:(NSInteger)index;

@end

@interface JXPictureSelectionView : UIView

@property (weak,nonatomic) id<JXPictureSelectionViewDelegate> delegate;
@property (strong,nonatomic) JXPictureSelectionViewConfiguration* config;
@property (strong,nonatomic) NSMutableArray* pictures;
@property (strong,nonatomic) NSMutableArray<UIImageView*>* pictureViews;
@property (copy,nonatomic) JXPictureSelectionViewAddButtonAction addButtonAction;
@property (copy,nonatomic) JXPictureSelectionViewLoadRemotePictureAction loadRemotePictureAction;

-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame configuration:(JXPictureSelectionViewConfiguration*)configuration;

-(UIImageView*)addPicture:(UIImage*)picture bindTapAction:(BOOL)bindTapAction;
-(UIImageView*)addPicture:(UIImage*)picture;
-(void)addPictures:(NSArray*)pictures;
-(void)addRemotePictureWithURL:(NSURL*)url;

-(void)bindTapOnPictureAction;
-(void)unbindTapOnPictureAction;

@end
