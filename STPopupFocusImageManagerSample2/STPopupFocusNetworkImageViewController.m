//
//  STPopupFocusNetworkImageViewController.m
//  STPopupFocusImageManagerSample2
//
//  Created by EIMEI on 2013/04/28.
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

#import "STPopupFocusNetworkImageViewController.h"
#import "STPopupFocusImageUtils.h"
#import "AFNetworking.h"

@implementation STPopupFocusNetworkImageViewController {
    __weak NIPhotoScrollView *_photoScrollView;
    __strong UIImage *_originalImage;
    NSOperationQueue *_operationQueue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect bounds = self.view.bounds;
    NIPhotoScrollView *photoScrollView = [[NIPhotoScrollView alloc] initWithFrame:bounds];
    _photoScrollView = photoScrollView;
    _photoScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_photoScrollView];
    
    _operationQueue = [[NSOperationQueue alloc] init];
    //
    // Double tap gesture recognizer.
    //
    UITapGestureRecognizer *doubleTapGestureRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];
    //
    // Single tap gesture recognizer.
    //
    UITapGestureRecognizer *singleTapGestureRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Set thumbnail image here.
    // DO NOT set thumbnail image on viewDidLoad.
    [_photoScrollView setImage:self.fromImage photoSize:NIPhotoScrollViewPhotoSizeThumbnail];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_originalImage == nil) {
        //
        // Start Loading original image.
        //
        NSURLRequest *request = [NSURLRequest requestWithURL:self.originalImageURL];
        NSOperation *operation =
            [AFImageRequestOperation imageRequestOperationWithRequest:request
                                                              success:^(UIImage *image) {
                                                                  _originalImage = image;
                                                                  [_photoScrollView setImage:_originalImage photoSize:NIPhotoScrollViewPhotoSizeOriginal];
                                                              }];
        [_operationQueue addOperation:operation];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //
    // Set the image again to place at correct position.
    //
    if (_originalImage) {
        [_photoScrollView setImage:_originalImage photoSize:NIPhotoScrollViewPhotoSizeThumbnail];
    } else {
        [_photoScrollView setImage:self.fromImage photoSize:NIPhotoScrollViewPhotoSizeOriginal];
    }
}

#pragma mark - UITapGestureRecognizer

- (void)handleDoubleTap:(UITapGestureRecognizer *)sender
{
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self dismissPopupFocusImage];
}

@end
