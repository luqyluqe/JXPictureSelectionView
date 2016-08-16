//
//  JXPictureSelectionViewController.m
//  Pods
//
//  Created by JIRENTIANXIANG on 1/1/16.
//
//

#import "JXPictureSelectionViewController.h"

@interface JXPictureSelectionViewController ()

@property (nonatomic,assign) BOOL viewDidAppear;

@end

@implementation JXPictureSelectionViewController

-(instancetype)initWithFrame:(CGRect)frame configuration:(JXPictureSelectionViewConfiguration *)configuration
{
    if (self=[super init]) {
        JXPictureSelectionView* view=[[JXPictureSelectionView alloc] initWithFrame:frame configuration:configuration];
        view.delegate=self;
        self.view=view;
        self.viewDidAppear=NO;
    }
    return self;
}

-(void)addPicture:(UIImage*)picture
{
    [(JXPictureSelectionView*)self.view addPicture:picture bindTapAction:self.viewDidAppear];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.viewDidAppear=YES;
    [(JXPictureSelectionView*)self.view bindTapOnPictureAction];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [(JXPictureSelectionView*)self.view unbindTapOnPictureAction];
    self.viewDidAppear=NO;
    [super viewWillDisappear:animated];
}

#pragma mark - JXPictureSelectionViewDelegate
-(void)pictureSelectionView:(JXPictureSelectionView *)pictureSelectionView didTapOnPictureView:(UIImageView *)pictureView atIndex:(NSInteger)index
{
    
}

@end
