//
//  JXPictureSelectionViewController.h
//  Pods
//
//  Created by JIRENTIANXIANG on 1/1/16.
//
//

#import "JXPictureSelectionView.h"

@interface JXPictureSelectionViewController : UIViewController<JXPictureSelectionViewDelegate>

-(instancetype)initWithFrame:(CGRect)frame configuration:(JXPictureSelectionViewConfiguration*)configuration;

-(void)addPicture:(UIImage*)picture;
-(void)addPictures:(NSArray*)pictures;

@end
