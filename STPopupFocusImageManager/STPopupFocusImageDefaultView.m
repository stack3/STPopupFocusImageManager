//
//  STPopupFocusImageDefaultView.m
//  STPopupFocusImageManager
//
//  Created by EIMEI on 2013/04/27.
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

#import "STPopupFocusImageDefaultView.h"
#import "STPopupFocusImageUtils.h"

@implementation STPopupFocusImageDefaultView {
    CGSize _originalImageSize;
}

- (id)initWithFrame:(CGRect)frame fromImage:(UIImage *)fromImage originalImageSize:(CGSize)originalImageSize
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect bounds = self.bounds;
        _originalImageSize = originalImageSize;
        CGRect imageViewFrame = [[STPopupFocusImageUtils class] imageFrameToFit:bounds.size originalImageSize:_originalImageSize];
        _imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
        _imageView.image = fromImage;
        [self addSubview:_imageView];
        
        //
        // Single tap gesture recognizer
        //
        UITapGestureRecognizer *singleTapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        singleTapGestureRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTapGestureRecognizer];
    }
    return self;
}

- (void)setOriginalImage:(UIImage *)image
{
    _imageView.image = image;
}

- (void)layoutSubviews
{
    CGRect bounds = self.bounds;
    CGRect imageViewFrame = [[STPopupFocusImageUtils class] imageFrameToFit:bounds.size originalImageSize:_originalImageSize];
    _imageView.frame = imageViewFrame;
}

#pragma mark - UITapGestureRecognizer

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(popupFocusZoomImageViewHandleSingleTap:)]) {
        [_delegate popupFocusZoomImageViewHandleSingleTap:self];
    }
}

@end
