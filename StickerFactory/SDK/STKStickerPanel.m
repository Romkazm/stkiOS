//
//  STKStickerPanel.m
//  StickerFactory
//
//  Created by Vadim Degterev on 06.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKStickerPanel.h"
#import "STKStickerPanelLayout.h"
#import "STKStickerPanelCell.h"
#import "STKStickerPanelHeader.h"

@interface STKStickerPanel() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) STKStickerPanelLayout *layout;

@end

@implementation STKStickerPanel

- (void)awakeFromNib {
    
    self.layout = [[STKStickerPanelLayout alloc] init];
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[STKStickerPanelCell class] forCellWithReuseIdentifier:@"STKStickerPanelCell"];
    [self.collectionView registerClass:[STKStickerPanelHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"STKStickerPanelHeader"];
    
    
    
}

#pragma mark - UICollectionViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            NSLog(@"Sticker Panle");
        }
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
