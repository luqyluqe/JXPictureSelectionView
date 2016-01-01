//
//  JXViewController.m
//  JXPictureSelectionView
//
//  Created by luqyluqe on 04/05/2016.
//  Copyright (c) 2016 luqyluqe. All rights reserved.
//

#import "JXViewController.h"
#import "JXPictureSelectionViewController.h"

@interface JXViewController ()

@end

@implementation JXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor blueColor];
    CGRect bounds=self.view.bounds;
    JXPictureSelectionViewConfiguration* config=[JXPictureSelectionViewConfiguration defaultConfiguration];
    config.rowGap=20;
    config.columnGap=8;
    JXPictureSelectionViewController* pictureSelectionVC=[[JXPictureSelectionViewController alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y+20, bounds.size.width, bounds.size.height) configuration:config];
    UIImage* cannian=[UIImage imageNamed:@"cannian.jpg"];
    for (int i=0; i<20; i++) {
        [pictureSelectionVC addPicture:cannian];
    }
    [self.view addSubview:pictureSelectionVC.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
