//
//  JXPictureSelectionViewController.m
//  Pods
//
//  Created by JIRENTIANXIANG on 1/1/16.
//
//

#import "JXPictureSelectionViewController.h"

@interface JXPictureSelectionViewController ()

@end

@implementation JXPictureSelectionViewController

-(instancetype)initWithFrame:(CGRect)frame configuration:(JXPictureSelectionViewConfiguration *)configuration
{
    if (self=[super init]) {
        self.view=[[JXPictureSelectionView alloc] initWithFrame:frame configuration:configuration];
    }
    return self;
}

-(void)addPicture:(UIImage*)picture
{
    [(JXPictureSelectionView*)self.view addPicture:picture];
}
-(void)addPictures:(NSArray*)pictures
{
    [(JXPictureSelectionView*)self.view addPictures:pictures];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
