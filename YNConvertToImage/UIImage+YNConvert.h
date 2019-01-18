//
//  UIImage+YNConvert.h
//
//
//  Created by liyangly on 2018/9/29.
//  Copyright © 2018 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YNConvert)

/**
 cut image in rect

 @param image the origin image
 @param scale scale
 @param rect cut rect
 @return the cutted image
 */
+ (UIImage *)cutImage:(UIImage *)image scale:(CGFloat)scale inRect:(CGRect)rect;

/**
 convert the view's content into a image

 @param view the converted view
 @return image
 */
+ (UIImage *)convertToImageWithView:(UIView*)view;

/**
 convert the scrollView's content into a image

 @param scrollView the converted scrollView
 @return image
 */
+ (UIImage *)convertToImageWithScrollView:(UIScrollView *)scrollView;

/**
 convert the scrollView's content into a image

 @param scrollView the converted scrollView
 @param scale the image bitmap's scale
 @return image
 */
+ (UIImage *)convertToImageWithScrollView:(UIScrollView *)scrollView WithScale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
