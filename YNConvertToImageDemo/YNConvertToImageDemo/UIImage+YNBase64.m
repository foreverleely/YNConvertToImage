//
//  UIImage+YNBase64.m
//  YNConvertToImageDemo
//
//  Created by liyangly on 2018/9/29.
//  Copyright © 2018 liyang. All rights reserved.
//

#import "UIImage+YNBase64.h"

@implementation UIImage (YNBase64)

+ (NSString *)base64StringWithImage:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return encodedImageStr;
}

+ (UIImage *)imageFromBase64String:(NSString *)string
{
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

@end
