//
//  UIImage+YNSize.m
//  YNConvertToImageDemo
//
//  Created by liyangly on 2018/9/29.
//  Copyright © 2018 liyang. All rights reserved.
//

#import "UIImage+YNSize.h"

@implementation UIImage (YNSize)

- (UIImage *)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
