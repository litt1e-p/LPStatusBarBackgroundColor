//
//  NavigationController.m
//  LPStatusBarBackgroundColorSample
//
//  Created by litt1e-p on 16/1/7.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//

#import "NavigationController.h"
#import "LPStatusBarBackgroundColor/UINavigationBar+StatusBarColor.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize barSize = CGSizeMake(self.navigationBar.frame.size.width, 44);
    [self.navigationBar setBackgroundImage:[self.class imageWithColor:[UIColor purpleColor] andSize:barSize]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationBar.statusBarBackgroundColor = [UIColor blackColor];
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)imageSize
{
    if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
        imageSize = CGSizeMake(1, 1);
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
