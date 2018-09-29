//
//  UIImage+YNBase64.h
//  YNConvertToImageDemo
//
//  Created by liyangly on 2018/9/29.
//  Copyright © 2018 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YNBase64)

+ (NSString *)base64StringWithImage:(UIImage *)image;

+ (UIImage *)imageFromBase64String:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
