//
//  ViewController.m
//  StickerFactory
//
//  Created by Vadim Degterev on 25.06.15.
//  Copyright (c) 2015 908. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Stickers.h"
#import "UIImageView+Stickers.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    NSString *testString = @"[[pinkGorilla_anger]]";
    if ([testString isSticker]) {
        [self.imageView stk_setStickerWithMessage:testString completion:^(NSError *error, UIImage *stickerImage) {
            
        }];
    } else {
        NSLog(@"Sticker not found");
    }
}


@end
