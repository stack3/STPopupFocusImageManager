STPopupFocusImageManager
========================

## Features

- Support iPad/iPhone. (Universal)
- Popup thumbnail image and display original image on full screen.
- Customize full screen image viewer.
- Customize original image downloader.
- Simple code and short code. Easy to customize.

## Requirements

- iOS 5.0 and later.
- Automatic reference counting. (ARC)

## License

MIT License

## Screenshots

[![ScreenShot](http://i1.ytimg.com/vi/pGKK1orlBCk/0.jpg?time=1367132348895)](http://youtu.be/pGKK1orlBCk)

Please click the image if you want to play the sample video.

## Usage

### Create PopupFocusImageManager and popup image.

```objectivec
_imageManager = [[STPopupFocusImageManager alloc] initWithRootViewController:self imageViewControllerClass:[STPopupFocusNetworkImageViewController class]];

NSURL *url = [NSURL URLWithString:_STOriginalImageURLString];
[_imageManager popupFromView:_imageButton // The view displays thumbnail.
                   fromImage:_image       // The thumbnail image object.
            originalImageURL:url          // The original image URL.
           originalImageSize:CGSizeMake(800, 600)];  // The original image size.
```

By default the originaiImageURL parameter just support file URL.

```objectivec
NSURL *url = [[NSBundle mainBundle] URLForResource:@"ramen800x600" withExtension:@"jpg"];
```

If you want to load original image from network, you may customize full screen image viewer(STPopupFocusImageViewController).

### Customize full screen image viewer.

Subclassing STPopupFocusImageViewController.

```objectivec
@interface STPopupFocusNetworkImageViewController : STPopupFocusImageViewController

@end
```

Please read STPopupFocusImageManagerSample2/STPopupFocusNetworkImageViewController.m to know how to implement.
This sample uses AFNetworking and nimubs/NIPhotoScrollView.
