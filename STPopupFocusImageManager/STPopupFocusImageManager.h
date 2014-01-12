//
//  STPopupFocusImageManager.h
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

#import <Foundation/Foundation.h>
#import "STPopupFocusImageViewController.h"

@interface STPopupFocusImageManager : NSObject

/**
 * Need to set NO if ViewController-based statusbar appearance is NOS on plist.
 * Default is YES.
 */
@property (nonatomic) BOOL isViewControllerBasedStatusBarAppearance;

- (id)initWithRootViewController:(UIViewController *)rootViewController;
- (id)initWithRootViewController:(UIViewController *)rootViewController imageViewControllerClass:(Class)imageViewControllerClass;

- (void)popupFromView:(UIView *)fromView
            fromImage:(UIImage *)fromImage
     originalImageURL:(NSURL *)originalImageURL
    originalImageSize:(CGSize)originalImageSize;
- (void)popupBack;

@end
