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

@interface STPopupFocusImageAnimationView ()

@property (weak, nonatomic) UIWindow *parentWindow;
@property (strong, nonatomic) UIImageView *popupImageView;
@property (strong, nonatomic) UIView *fromView;
@property (strong, nonatomic) UIImage *fromImage;
@property (strong, nonatomic) NSURL *originalImageURL;
@property (nonatomic) CGSize originalImageSize;

@end

@implementation STPopupFocusImageAnimationView

- (id)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self st_popupFocusImageAnimationViewCommonInit];
    }
    return self;
}

- (void)st_popupFocusImageAnimationViewCommonInit {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.userInteractionEnabled = YES;

    _popupImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_popupImageView];

    NSNotificationCenter *ntfCenter = [NSNotificationCenter defaultCenter];
    [ntfCenter addObserver:self selector:@selector(handleStatusBarFrameOrOrientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [ntfCenter addObserver:self selector:@selector(handleStatusBarFrameOrOrientationChanged:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setFromView:(UIView *)fromView
          fromImage:(UIImage *)fromImage
   originalImageURL:(NSURL *)originalImageURL
  originalImageSize:(CGSize)originalImageSize {
    _fromView = fromView;
    _fromImage = fromImage;
    _originalImageURL = originalImageURL;
    _originalImageSize = originalImageSize;
}

- (void)addOnWindow:(UIWindow *)window {
    _parentWindow = window;
    [_parentWindow addSubview:self];
}

- (void)startPopupAnimatingWithCompletion:(void (^)())compleBlock {
    self.backgroundColor = [UIColor clearColor];

    _popupImageView.image = _fromImage;
    _popupImageView.frame = [self getSourceImageFrame];
    CGRect destinationImageFrame = [self getDestinationImageFrame];
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

- (void)startPopupBackAnimatingWithCompletion:(void (^)())compleBlock {
    self.backgroundColor = [UIColor blackColor];

    CGRect sourceImageFrame =  [self getSourceImageFrame];
    _popupImageView.frame = [self getDestinationImageFrame];
    //
    // Start popup animation.
    //
    [UIView animateWithDuration:STPopupFocusImageAnimationDuration animations:^{
        self.backgroundColor = [UIColor clearColor];
        _popupImageView.frame = sourceImageFrame;
    } completion:^(BOOL finished) {
        if (compleBlock) {
            compleBlock();
        }
    }];
}

- (CGRect)getSourceImageFrame {
    CGRect frame;
    frame.origin = [_fromView convertPoint:CGPointZero toView:self];
    frame.size = _fromView.frame.size;
    return frame;
}

- (CGRect)getDestinationImageFrame {
    CGRect bounds = self.bounds;
    return [[STPopupFocusImageUtils class] imageFrameToFit:bounds.size originalImageSize:_originalImageSize];
}

#pragma mark - Status Bar

- (void)handleStatusBarFrameOrOrientationChanged:(NSNotification *)notification {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat angle = [self angleForOrientation:orientation];
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);

    if (!CGAffineTransformEqualToTransform(self.transform, transform)) {
        self.transform = transform;
    }

    if (!CGRectEqualToRect(self.frame, _parentWindow.bounds)) {
        self.frame = _parentWindow.bounds;
    }
}

#pragma mark - Utils

- (CGFloat)angleForOrientation:(UIInterfaceOrientation)orientation {
    CGFloat angle;

    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = -M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = M_PI_2;
            break;
        default:
            angle = 0.0;
            break;
    }

    return angle;
}

@end
