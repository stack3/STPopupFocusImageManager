//
//  STPopupFocusImageViewController.m
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

#import "STPopupFocusImageViewController.h"
#import "STPopupFocusImageManager.h"
#import "STPopupFocusImageDefaultView.h"

@interface STPopupFocusImageViewController () <STPopupFocusImageDefaultViewDelegate>

@property (weak, nonatomic) STPopupFocusImageManager *popupFocusImageManager;
@property (strong, nonatomic) UIImage *fromImage;
@property (nonatomic) CGRect imageViewFrame;
@property (strong, nonatomic) NSURL *originalImageURL;
@property (nonatomic) CGSize originalImageSize;
@property (weak, nonatomic) STPopupFocusImageDefaultView *zoomImageView;

@end

@implementation STPopupFocusImageViewController

- (instancetype)initWithPopupFocusImageManager:(STPopupFocusImageManager *)popupFocusImageManager
                                imageViewFrame:(CGRect)imageViewFrame
                              originalImageURL:(NSURL *)originalImageURL
                             originalImageSize:(CGSize)originalImageSize {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _popupFocusImageManager = popupFocusImageManager;
        _fromImage = popupFocusImageManager.fromImage;
        _originalImageURL = originalImageURL;
        _originalImageSize = originalImageSize;
        _imageViewFrame = imageViewFrame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect bounds = self.view.bounds;

    STPopupFocusImageDefaultView *zoomImageView = [[STPopupFocusImageDefaultView alloc] initWithFrame:bounds fromImage:self.fromImage originalImageSize:self.originalImageSize];
    _zoomImageView = zoomImageView;
    _zoomImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _zoomImageView.delegate = self;
    [self.view addSubview:_zoomImageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [_zoomImageView setOriginalImage:[UIImage imageWithContentsOfFile:self.originalImageURL.path]];
}

- (void)dismissPopupFocusImage {
    [_popupFocusImageManager popupBackAnimated:YES complete:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - STPopupFocusImageDefaultViewDelegate

- (void)popupFocusZoomImageViewHandleSingleTap:(STPopupFocusImageDefaultView *)sender {
    [self dismissPopupFocusImage];
}

@end
