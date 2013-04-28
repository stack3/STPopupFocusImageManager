//
//  STPopupFocusImageViewController.h
//  STPopupFocusImageManager
//
//  Created by EIMEI on 2013/04/11.
//  Copyright (c) 2013 stack3.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STPopupFocusImageManager;

@protocol STPopupFocusImageViewControllerProtocol <NSObject>

@property (weak, nonatomic, readonly) STPopupFocusImageManager *popupFocusImageManager;

- (id)initWithPopupFocusImageManager:(STPopupFocusImageManager *)popupFocusImageManager
                           fromImage:(UIImage *)fromImage
                      imageViewFrame:(CGRect)imageViewFrame
                    originalImageURL:(NSURL *)originalImageURL
                   originalImageSize:(CGSize)originalImageSize;

@end
