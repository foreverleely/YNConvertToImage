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
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
        {
            [view.layer renderInContext:UIGraphicsGetCurrentContext()];
            image = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext();
        
        if(image != nil) {
            return image;
        }
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
    @autoreleasepool {
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
    }
    return nil;
}

// cut image
+ (UIImage *)cutImage:(UIImage *)image scale:(CGFloat)scale inRect:(CGRect)rect {
    
    CGImageRef imageRef = nil;
    CGRect newRect = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
    
    imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(newRect.origin.x, newRect.origin.y, newRect.size.width, newRect.size.height));
    
    UIGraphicsBeginImageContext(newRect.size);
    
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(con, 0.0, newRect.size.height);
    
    CGContextScaleCTM(con, 1.0, -1.0);
    
    CGContextAddEllipseInRect(con, CGRectMake(0, 0, newRect.size.width, newRect.size.height));
    
    CGContextDrawImage(con, CGRectMake(0, 0, newRect.size.width, newRect.size.height), imageRef);
    
    UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRelease(imageRef);
    
    return standardImage;
}

- (UIImage *)circleImage {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    
    [self drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)pathClipWithAddLineBlock:(void(^)(CGContextRef ctxRef, CGFloat imgWidth, CGFloat imgHeight))addlineBlock {
    
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    // begin
    UIGraphicsBeginImageContext(self.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    // add line
    //    CGContextMoveToPoint(gc, 0, 0);
    //    CGContextAddLineToPoint(gc, width, 0);
    //    CGContextAddLineToPoint(gc, width, height*2/3);
    //    CGContextAddLineToPoint(gc, 0, height*5/6);
    //    CGContextClosePath(gc);
    addlineBlock(gc, width, height);
    // clip, even-odd fill
    CGContextAddRect(gc, CGContextGetClipBoundingBox(gc));
    CGContextEOClip(gc);
    
    // translate coordinate system
    CGContextTranslateCTM(gc, 0, height);
    CGContextScaleCTM(gc, 1, -1);
    CGContextDrawImage(gc, CGRectMake(0, 0, width, height), [self CGImage]);
    
    // get image
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    
    // end
    UIGraphicsEndImageContext();
    
    return destImg;
}

@end
