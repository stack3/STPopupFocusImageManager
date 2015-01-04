//
//  STViewController.m
//  STPopupFocusImageManagerSample
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

#import "STViewController.h"
#import "STPopupFocusImageManager.h"
#import "STPopupFocusImageViewController.h"

@implementation STViewController {
    IBOutlet __weak UIButton *_imageButton;
    __strong UIImage *_image;
    __strong STPopupFocusImageManager *_imageManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    
    _image = [UIImage imageNamed:@"ramen200x150.jpg"];
    [_imageButton setImage:_image forState:UIControlStateNormal];
    [_imageButton addTarget:self action:@selector(didTapImageButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTapImageButton:(id)sender
{
    if (_imageManager == nil) {
        _imageManager = [[STPopupFocusImageManager alloc] initWithRootViewController:self];
    }
    
    NSURL *originalImageURL = [[NSBundle mainBundle] URLForResource:@"ramen800x600" withExtension:@"jpg"];
    CGSize originalImageSize = CGSizeMake(800, 600);
    [_imageManager popupFromView:_imageButton fromImage:_image originalImageURL:originalImageURL originalImageSize:originalImageSize completion:^(CGRect destinationImageFrame) {
        STPopupFocusImageViewController *con =
        [[STPopupFocusImageViewController alloc] initWithPopupFocusImageManager:_imageManager
                                                                 imageViewFrame:destinationImageFrame
                                                               originalImageURL:originalImageURL
                                                              originalImageSize:originalImageSize];
        return con;
     }];
}

@end
