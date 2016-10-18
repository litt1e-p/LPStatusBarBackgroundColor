// The MIT License (MIT)
//
// Copyright (c) 2015-2016 litt1e-p ( https://github.com/litt1e-p )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
