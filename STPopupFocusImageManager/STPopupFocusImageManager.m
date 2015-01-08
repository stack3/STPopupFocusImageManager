//
//  STPopupFocusImageManager.m
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

#import "STPopupFocusImageManager.h"
#import "STPopupFocusImageAnimationView.h"
#import "STPopupFocusImageViewController.h"
#import "STPopupFocusImageDefines.h"

typedef enum {
    _STPhaseIdle,
    _STPhasePopupAnimation,
    _STPhaseImageViewShown,
    _STPhasePopupBackAnimation
} _STPhase;

@interface STPopupFocusImageManager ()

@property (nonatomic) _STPhase phase;
@property (weak, nonatomic) UIViewController *rootViewController;
@property (weak, nonatomic) UIViewController *imageViewController;
@property (strong, nonatomic) STPopupFocusImageAnimationView *popupAnimationView;

@end

@implementation STPopupFocusImageManager

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super init];
    if (self) {
        _rootViewController = rootViewController;
    }
    return self;
}

- (void)popupAnimated:(BOOL)animated
             fromView:(UIView *)fromView
            fromImage:(UIImage *)fromImage
     originalImageURL:(NSURL *)originalImageURL
    originalImageSize:(CGSize)originalImageSize
           completion:(STPopupFocusImageManagerPopupCompleteBlock)complete {
    if (_phase != _STPhaseIdle) return;
    
    _phase = _STPhasePopupAnimation;
    _fromImage = fromImage;
    
    _popupAnimationView = [[STPopupFocusImageAnimationView alloc] init];
    [_popupAnimationView setFromView:fromView
                           fromImage:fromImage
                    originalImageURL:originalImageURL
                   originalImageSize:originalImageSize];

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    _popupAnimationView.frame = window.bounds;
    [_popupAnimationView addOnWindow:window];

    [_popupAnimationView startPopupAnimated:animated completion:^{
        _phase = _STPhaseImageViewShown;
        
        CGRect destinationImageFrame = [_popupAnimationView getDestinationImageFrame];
        if (complete) {
            UIViewController *con = complete(destinationImageFrame);
            [_rootViewController presentViewController:con animated:NO completion:^{
                [_popupAnimationView removeFromSuperview];
            }];
            _imageViewController = con;
        }
    }];
}

- (void)popupBackAnimated:(BOOL)animated complete:(STPopupFocusImageManagerPopupBackCompleteBlock)complete {
    _phase = _STPhasePopupBackAnimation;

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    _popupAnimationView.frame = window.bounds;
    [_popupAnimationView addOnWindow:window];

    [_imageViewController dismissViewControllerAnimated:NO completion:^{
        _imageViewController = nil;

        [_popupAnimationView startPopupBackAnimated:animated completion:^{
            _phase = _STPhaseIdle;
            [_popupAnimationView removeFromSuperview];
            _popupAnimationView = nil;
            if (complete) {
                complete();
            }
        }];
    }];
}

- (BOOL)isPresented {
    return _phase != _STPhaseIdle;
}

@end
