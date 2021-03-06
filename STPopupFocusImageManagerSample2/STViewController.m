//
//  STViewController.m
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

#import "STViewController.h"
#import "STPopupFocusImageManager.h"
#import "STPopupFocusNetworkImageViewController.h"

static NSString *const _STOriginalImageURLString = @"http://cdn-ak.f.st-hatena.com/images/fotolife/e/eimei23/20120413/20120413232454.jpg";

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
        _imageManager = [[STPopupFocusImageManager alloc] initWithRootViewController:self imageViewControllerClass:[STPopupFocusNetworkImageViewController class]];
    }
    
    NSURL *url = [NSURL URLWithString:_STOriginalImageURLString];
    [_imageManager popupFromView:_imageButton
                       fromImage:_image
                originalImageURL:url
               originalImageSize:CGSizeMake(800, 600)];
}


@end
