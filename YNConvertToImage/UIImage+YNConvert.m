//
//  UIImage+YNConvert.m
//  
//
//  Created by liyangly on 2018/9/29.
//  Copyright © 2018 liyang. All rights reserved.
//

#import "UIImage+YNConvert.h"

@implementation UIImage (YNConvert)

// convert the view's content into a image
+ (UIImage *)convertToImageWithView:(UIView *)view
{
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    {
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    if(image != nil) {
        return image;
    }
    return nil;
}

// convert the scrollview's content into a image
+ (UIImage *)convertToImageWithScrollView:(UIScrollView *)scrollView
{
    return [self convertToImageWithScrollView:scrollView WithScale:0.0];
}

// convert the scrollview's content into a image
+ (UIImage *)convertToImageWithScrollView:(UIScrollView *)scrollView WithScale:(CGFloat)scale
{
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, NO, scale);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}

@end
