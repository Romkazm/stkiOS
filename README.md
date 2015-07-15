## About

**StickerPipe** is a stickers SDK for iOS

![Screencapture GIF](http://stickerpipe.com/static/examples/ios.gif)

## Installation

Get the API key on the [StickerPipe](http://stickerpipe.com/)

CocoaPods:
```ruby
pod "StickerPipe", "~> 0.1.2"
```
## Usage

Add API key in your AppDelegate.m 

```objc
[STKStickersManager initWitApiKey:@"API_KEY"];
```

Use category for UIImageView for display sticker

```objc
    if ([STKStickersManager isStickerMessage:message]) {
        [self.stickerImageView stk_setStickerWithMessage:message completion:nil];
        
    }
```

Add STKStickerPanel like inputView for your UITextView/UITextField

```objc
@property (strong, nonatomic) STKStickerPanel *stickerPanel;


self.inputTextView.inputView = self.stickerPanel;
[self.inputTextView reloadInputViews];
```
Use delegate method for reciving sticker messages from sticker panel

```objc
- (void)stickerPanel:(STKStickerPanel *)stickerPanel didSelectStickerWithMessage:(NSString *)stickerMessage {
    
    //Send sticker message
    
}
```

## Credits

908 Inc.

## Contact

mail@908.vc

## License

StickerPipe is available under the Apache 2 license. See the [LICENSE](LICENSE) file for more information.
