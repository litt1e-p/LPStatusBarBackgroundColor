//
//  UINavigationBar+StatusBarColor.m
//
//  Created by litt1e-p on 16/1/5.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//

#import <objc/runtime.h>
#import "UINavigationBar+StatusBarColor.h"

@implementation UINavigationBar (StatusBarColor)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzle:@selector(layoutSubviews)];
    });
}

+ (void)swizzle:(SEL)selector
{
    NSString *name = [NSString stringWithFormat:@"swizzled_%@", NSStringFromSelector(selector)];
    Method m1 = class_getInstanceMethod(self.class, selector);
    Method m2 = class_getInstanceMethod(self.class, NSSelectorFromString(name));
    method_exchangeImplementations(m1, m2);
}

- (void)swizzled_layoutSubviews
{
    [self swizzled_layoutSubviews];
    BOOL iOS10_OR_LATER = [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0;
    if (self.statusBarBackgroundColor){
        Class backgroundClass = NSClassFromString(iOS10_OR_LATER ? @"_UIBarBackground" : @"_UINavigationBarBackground");
        Class statusBarBackgroundClass = NSClassFromString(iOS10_OR_LATER ? @"UIView" : @"_UIBarBackgroundTopCurtainView");
        for (UIView * aSubview in self.subviews){
            if ([aSubview isKindOfClass:backgroundClass]) {
                aSubview.backgroundColor = [UIColor clearColor];
                for (UIView * aaSubview in aSubview.subviews){
                    if ([aaSubview isKindOfClass:statusBarBackgroundClass]) {
                        aaSubview.backgroundColor = [self.statusBarBackgroundColor colorWithAlphaComponent:1];
                    }
                }
            }
        }
    }
}

- (void)setStatusBarBackgroundColor:(UIColor *)statusBarBackgroundColor
{
    objc_setAssociatedObject(self, @selector(statusBarBackgroundColor), statusBarBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

- (UIColor *)statusBarBackgroundColor
{
    return objc_getAssociatedObject(self, @selector(statusBarBackgroundColor));
}

@end
