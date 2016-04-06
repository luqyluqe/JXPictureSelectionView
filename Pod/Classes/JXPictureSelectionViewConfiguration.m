//
//  JXPictureSelectionViewConfiguration.m
//

#import "JXPictureSelectionViewConfiguration.h"

@implementation JXPictureSelectionViewConfiguration

+(JXPictureSelectionViewConfiguration*)defaultConfiguration
{
    JXPictureSelectionViewConfiguration* config=[[JXPictureSelectionViewConfiguration alloc] init];
    config.capacity=9;
    config.numberOfColumns=3;
    config.paddingLeft=10;
    config.paddingRight=10;
    config.paddingTop=10;
    config.paddingBottom=10;
    config.gap=10;
    config.aspectRatio=1;
    config.removeButtonImage=[UIImage imageNamed:@"remove_button"];
    config.removeButtonSize=CGSizeMake(20,20);
    return config;
}

@end
