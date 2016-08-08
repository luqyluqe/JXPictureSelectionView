//
//  JXPictureSelectionViewController.m
//  Pods
//
//  Created by JIRENTIANXIANG on 1/1/16.
//
//

#import "JXPictureSelectionViewController.h"

@interface JXPictureSelectionViewController ()

@property (nonatomic,strong) NSMutableArray<UIImageView*>* pictureViews;

@end

@implementation JXPictureSelectionViewController

-(instancetype)initWithFrame:(CGRect)frame configuration:(JXPictureSelectionViewConfiguration *)configuration
{
    if (self=[super init]) {
        self.view=[[JXPictureSelectionView alloc] initWithFrame:frame configuration:configuration];
        self.pictureViews=[[NSMutableArray alloc] init];
        NSAssert(self.pictureViews!=nil, @"....");
    }
    return self;
}

-(void)addPicture:(UIImage*)picture
{
    if(!self.pictureViews){
        self.pictureViews=[[NSMutableArray alloc] init];
    }
    UIImageView* pictureView=[(JXPictureSelectionView*)self.view addPicture:picture];
    if (pictureView) {
        [self.pictureViews addObject:pictureView];
    }
}
-(void)addPictures:(NSArray*)pictures
{
    [(JXPictureSelectionView*)self.view addPictures:pictures];
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
    NSAssert(self.pictureViews!=nil, @"....");
    NSAssert(self.pictureViews.count>0,@"....");
    for (UIImageView* pictureView in self.pictureViews) {
        pictureView.userInteractionEnabled=YES;
        UITapGestureRecognizer* tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureViewTapped:)];
        [pictureView addGestureRecognizer:tapGestureRecognizer];
    }
}

-(void)pictureViewTapped:(UITapGestureRecognizer*)tapGestureRecognizer
{
    UIImageView* sender=(UIImageView*)tapGestureRecognizer.view;
    if ([self respondsToSelector:@selector(pictureSelectionView:didTapOnPictureView:atIndex:)]) {
        [self pictureSelectionView:(JXPictureSelectionView*)self.view didTapOnPictureView:sender atIndex:sender.tag];
    }
}

@end
