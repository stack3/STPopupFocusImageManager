//
//  STPopupFocusImageUtils.m
//  STPopupFocusImageManager
//
//  Created by EIMEI on 2013/04/11.
//  Copyright (c) 2013 stack3.net. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "STPopupFocusImageUtils.h"

@implementation STPopupFocusImageUtils

+ (CGRect)imageFrameToFit:(CGSize)size originalImageSize:(CGSize)originalImageSize
{
    CGRect imageFrame;
    imageFrame.size = [[self class] imageSizeToFit:size originalImageSize:originalImageSize];
    imageFrame.origin.x = (size.width - imageFrame.size.width) / 2;
    imageFrame.origin.y = (size.height - imageFrame.size.height) / 2;
    return imageFrame;
}

+ (CGSize)imageSizeToFit:(CGSize)size originalImageSize:(CGSize)originalImageSize
{
    if (originalImageSize.width < size.width && originalImageSize.height < size.height) {
        return originalImageSize;
    }
    
    CGFloat scale = size.width / originalImageSize.width;
    if (originalImageSize.height * scale <= size.height) {
        return CGSizeMake(size.width, originalImageSize.height * scale);
    }
    
    scale = size.height / originalImageSize.height;
    return CGSizeMake(originalImageSize.width * scale, size.height);
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
