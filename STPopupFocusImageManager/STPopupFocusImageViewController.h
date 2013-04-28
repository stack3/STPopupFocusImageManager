//
//  STPopupFocusImageViewController.h
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

#import <UIKit/UIKit.h>

@class STPopupFocusImageManager;

@interface STPopupFocusImageViewController : UIViewController

@property (weak, nonatomic, readonly) STPopupFocusImageManager *popupFocusImageManager;
@property (strong, nonatomic, readonly) UIImage *fromImage;
@property (nonatomic, readonly) CGRect imageViewFrame;
@property (strong, nonatomic, readonly) NSURL *originalImageURL;
@property (nonatomic, readonly) CGSize originalImageSize;

- (id)initWithPopupFocusImageManager:(STPopupFocusImageManager *)popupFocusImageManager
                           fromImage:(UIImage *)fromImage
                      imageViewFrame:(CGRect)imageViewFrame
                    originalImageURL:(NSURL *)originalImageURL
                   originalImageSize:(CGSize)originalImageSize;
/**
 * Dismiss the popup focus image.
 *
 * DO NOT use UIViewController#dismissViewController:animated:completion to dismiss this ViewController.
 */
- (void)dismissPopupFocusImage;

@end