//
//  ViewController.m
//  StickerFactory
//
//  Created by Vadim Degterev on 25.06.15.
//  Copyright (c) 2015 908. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+Stickers.h"
#import "STKStickersManager.h"
#import "NSManagedObjectContext+STKAdditions.h"
#import "STKCoreDataService.h"
#import "NSPersistentStoreCoordinator+STKAdditions.h"
#import "STKAnalyticService.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *categoryStickerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *methodImageView;
@property (strong, nonatomic) STKStickersManager *stickerManager;

@property (assign, nonatomic) NSInteger testCounter;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.stickerManager = [STKStickersManager new];
    
    [STKCoreDataService setupCoreData];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    
    NSString *testString = @"[[pinkgorilla_bigSmile]]";
    
    self.categoryStickerImageView.stickerDefaultPlaceholderColor = [UIColor redColor];
    
    //Есть возможность отображать стикер с помощью категрии, но необходимо сначала проверить стикер ли это
    if ([STKStickersManager isStickerMessage:testString]) {
        [self.categoryStickerImageView stk_setStickerWithMessage:testString completion:^(NSError *error, UIImage *stickerImage) {
            
        }];
        
        //Можно загрузить методом напрямую(Если это не стикер, вызовется failure блок)
        __weak typeof(self) weakSelf = self;
        [self.stickerManager getStickerForMessage:testString progress:nil success:^(UIImage *sticker) {
            
            weakSelf.methodImageView.image = sticker;
            
        } failure:^(NSError *error, NSString *errorMessage) {
            NSLog(@"Error : %@", error.localizedDescription);
        }];
    } else {
        NSLog(@"Sticker not found");
    }
    
}


@end
