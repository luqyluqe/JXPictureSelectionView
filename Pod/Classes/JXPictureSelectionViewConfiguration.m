//
//  JXPictureSelectionViewConfiguration.m
//

#import "JXPictureSelectionViewConfiguration.h"

@implementation JXPictureSelectionViewConfiguration

+(JXPictureSelectionViewConfiguration*)defaultConfiguration
{
    JXPictureSelectionViewConfiguration* config=[[JXPictureSelectionViewConfiguration alloc] init];
    config.numberOfColumns=3;
    config.paddingLeft=10;
    config.paddingRight=10;
    config.paddingTop=10;
    config.paddingBottom=10;
    config.gap=10;
    config.aspectRatio=1;
    return config;
}

@end
