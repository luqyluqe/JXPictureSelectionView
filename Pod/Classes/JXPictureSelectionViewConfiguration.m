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
    config.rowGap=10;
    config.columnGap=10;
    config.aspectRatio=1;
    config.cornerRadius=0;
    config.removeButtonImage=[UIImage imageNamed:@"remove_button"];
    config.removeButtonSize=CGSizeMake(20,20);
    config.addButtonImage=[UIImage imageNamed:@"plus"];
    config.addButtonBackgroundColor=[UIColor clearColor];
    config.animationDuration=0.4;
    return config;
}

@end
