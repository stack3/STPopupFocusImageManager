//
//  STPopupFocusImageDefaultViewController.m
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

#import "STPopupFocusImageDefaultViewController.h"
#import "STPopupFocusImageAnimationView.h"
#import "STPopupFocusImageUtils.h"

@implementation STPopupFocusImageDefaultViewController {
    __weak STPopupFocusImageDefaultView *_zoomImageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect bounds = self.view.bounds;
    
    STPopupFocusImageDefaultView *zoomImageView = [[STPopupFocusImageDefaultView alloc] initWithFrame:bounds fromImage:self.fromImage originalImageSize:self.originalImageSize];
    _zoomImageView = zoomImageView;
    _zoomImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _zoomImageView.delegate = self;
    [self.view addSubview:_zoomImageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_zoomImageView setOriginalImage:[UIImage imageWithContentsOfFile:self.originalImageURL.path]];
}

#pragma mark - STPopupFocusImageDefaultViewDelegate

- (void)popupFocusZoomImageViewHandleSingleTap:(STPopupFocusImageDefaultView *)sender
{
    [self dismissPopupFocusImage];
}

@end
