//
//  STPopupFocusImageAnimationView.m
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

#import "STPopupFocusImageAnimationView.h"
#import <QuartzCore/QuartzCore.h>
#import "STPopupFocusImageDefines.h"
#import "STPopupFocusImageUtils.h"

@implementation STPopupFocusImageAnimationView {
    __strong UIImageView *_popupImageView;

    __strong UIView *_fromView;
    __strong UIImage *_fromImage;
    __strong NSURL *_originalImageURL;
    CGSize _originalImageSize;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.layer.zPosition = STPopupFocusImageAnimationViewDefaultZPosition;
        
        _popupImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_popupImageView];
    }
    return self;
}

- (void)setFromView:(UIView *)fromView
          fromImage:(UIImage *)fromImage
   originalImageURL:(NSURL *)originalImageURL
  originalImageSize:(CGSize)originalImageSize
{
    _fromView = fromView;
    _fromImage = fromImage;
    _originalImageURL = originalImageURL;
    _originalImageSize = originalImageSize;
}

- (void)startPopupAnimatingWithCompletion:(void (^)())compleBlock
{
    self.backgroundColor = [UIColor clearColor];
    
    CGRect sourceImageFrame = [self getSourceImageFrame];
    CGRect destinationImageFrame = [self getDestinationImageFrame];
    _popupImageView.image = _fromImage;
    _popupImageView.frame = sourceImageFrame;
    //
    // Start popup animation.
    //
    [UIView animateWithDuration:STPopupFocusImageAnimationDuration animations:^{
        self.backgroundColor = [UIColor blackColor];
        _popupImageView.frame = destinationImageFrame;
    } completion:^(BOOL finished) {
        if (compleBlock) {
            compleBlock();
        }
    }];
}

- (void)startPopupBackAnimatingWithCompletion:(void (^)())compleBlock
{
    self.backgroundColor = [UIColor blackColor];
    
    _popupImageView.frame = [self getDestinationImageFrame];
    CGRect fromImageFrame =  [self getSourceImageFrame];
    
    //
    // Start popup animation.
    //
    [UIView animateWithDuration:STPopupFocusImageAnimationDuration animations:^{
        self.backgroundColor = [UIColor clearColor];
        _popupImageView.frame = fromImageFrame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (compleBlock) {
            compleBlock();
        }
    }];
}

- (CGRect)getSourceImageFrame
{
    CGRect frame;
    frame.origin = [_fromView convertPoint:CGPointZero toView:self];
    frame.size = _fromView.frame.size;
    return frame;
}

- (CGRect)getDestinationImageFrame
{
    CGRect bounds = self.bounds;
    return [[STPopupFocusImageUtils class] imageFrameToFit:bounds.size originalImageSize:_originalImageSize];
}

@end
