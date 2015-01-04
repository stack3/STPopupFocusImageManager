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
#import "STPopupFocusImageDefaultViewController.h"
#import "STPopupFocusImageDefines.h"

typedef enum {
    _STPhaseIdle,
    _STPhasePopupAnimation,
    _STPhaseImageViewShown,
    _STPhasePopupBackAnimation
} _STPhase;

@implementation STPopupFocusImageManager {
    _STPhase _phase;
    __weak UIViewController *_rootViewController;
    Class _imageViewControllerClass;
    __strong STPopupFocusImageAnimationView *_popupAnimationView;
    __weak STPopupFocusImageViewController *_imageViewController;
    BOOL _isViewControllerBasedStatusBarAppearance;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    return [self initWithRootViewController:rootViewController imageViewControllerClass:[STPopupFocusImageDefaultViewController class]];
}

- (id)initWithRootViewController:(UIViewController *)rootViewController imageViewControllerClass:(Class)imageViewControllerClass
{
    self = [super init];
    if (self) {
        _rootViewController = rootViewController;
        _imageViewControllerClass = imageViewControllerClass;
        _isViewControllerBasedStatusBarAppearance = YES;
        
        if (!_rootViewController.view.autoresizesSubviews) {
            //
            // _popupAnimationView depends on _rootViewController#autoresizesSubviews.
            //
            NSLog(@"sourceViewController.view.autoresizesSubviews should be YES.");
            assert(NO);
        }
    }
    return self;
}

- (void)popupFromView:(UIView *)fromView
            fromImage:(UIImage *)fromImage
     originalImageURL:(NSURL *)originalImageURL
    originalImageSize:(CGSize)originalImageSize
{
    if (_phase != _STPhaseIdle) return;
    
    _phase = _STPhasePopupAnimation;
    
    CGRect frame = [self getImageAnimationViewFrame];
    _popupAnimationView = [[STPopupFocusImageAnimationView alloc] initWithFrame:frame];
    _popupAnimationView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_rootViewController.view addSubview:_popupAnimationView];
    
    [_popupAnimationView setFromView:fromView
                           fromImage:fromImage
                    originalImageURL:originalImageURL
                   originalImageSize:originalImageSize];
    
    if (!_isViewControllerBasedStatusBarAppearance) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
    
    [_popupAnimationView startPopupAnimatingWithCompletion:^{
        _phase = _STPhaseImageViewShown;
        
        CGRect destinationImageFrame = [_popupAnimationView getDestinationImageFrame];
        STPopupFocusImageViewController *imageViewCon =
        [[_imageViewControllerClass alloc] initWithPopupFocusImageManager:self
                                                                fromImage:fromImage
                                                           imageViewFrame:destinationImageFrame
                                                         originalImageURL:originalImageURL
                                                        originalImageSize:originalImageSize];
        BOOL wasNavbarHidden;
        if (_rootViewController.navigationController) {
            wasNavbarHidden = _rootViewController.navigationController.navigationBarHidden;
            if (! wasNavbarHidden) {
                _rootViewController.navigationController.navigationBarHidden = YES;
            }
        } else {
            wasNavbarHidden = YES;
        }
        [_rootViewController presentViewController:imageViewCon animated:NO completion:^{
            if (! wasNavbarHidden) {
                _rootViewController.navigationController.navigationBarHidden = NO;
            }
        }];

        _imageViewController = imageViewCon;
    }];
    [UIView animateWithDuration:STPopupFocusImageAnimationDuration animations:^{
        if (_rootViewController.navigationController.navigationBar) {
            _rootViewController.navigationController.navigationBar.alpha = 0;
        }
    }];
}

- (void)popupBack
{
    //
    // Need to do these codes before dismissViewController.
    //
    
    if (!_isViewControllerBasedStatusBarAppearance) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
    
    [UIView animateWithDuration:STPopupFocusImageAnimationDuration animations:^{
        _rootViewController.navigationController.navigationBar.alpha = 1.0;
    }];
    
    [_imageViewController dismissViewControllerAnimated:NO completion:^{
        _imageViewController = nil;
        
        // Need if PopupFocusImageViewController was rotated.
        [_rootViewController.view layoutIfNeeded];
        
        if (_phase != _STPhaseImageViewShown) return;
        
        _phase = _STPhasePopupBackAnimation;
        
        [_popupAnimationView startPopupBackAnimatingWithCompletion:^{
            _phase = _STPhaseIdle;
        }];
    }];
}

#pragma mark - Dimensions

- (CGRect)getImageAnimationViewFrame
{
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGRect frame = CGRectZero;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        frame.size = mainScreen.bounds.size;
    } else {
        frame.size.width = mainScreen.bounds.size.height;
        frame.size.height = mainScreen.bounds.size.width;
    }
    frame.origin.y -= _rootViewController.view.frame.origin.y;
    
    return frame;
}

@end
