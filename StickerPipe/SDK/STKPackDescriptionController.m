//
//  STKPacksDescriptionController.m
//  StickerPipe
//
//  Created by Vadim Degterev on 29.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKPackDescriptionController.h"
#import "STKStickersEntityService.h"
#import "STKStickerViewCell.h"
#import "STKPackDescriptionHeader.h"
#import "STKStickerPackObject.h"
#import "STKStickerObject.h"
#import <DFImageManagerKit.h>
#import "STKUtility.h"
#import "UIImage+Tint.h"

@interface STKPackDescriptionController()<UICollectionViewDataSource, UICollectionViewDelegate, STKPackDescriptionHeaderDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) STKStickersEntityService *service;
@property (strong, nonatomic) STKStickerPackObject *stickerPack;

@property (assign, nonatomic, getter=isStickerPackDownloaded) BOOL stickerPackDownloaded;

@end

@implementation STKPackDescriptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[STKStickerViewCell class] forCellWithReuseIdentifier:@"STKStickerViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"STKPackDescriptionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"STKPackDescriptionHeader"];
    self.service = [STKStickersEntityService new];
    
    self.collectionView.hidden = YES;
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidesWhenStopped = YES;
    [self reloadStickerPack];
}

- (void) reloadStickerPack {
    
    __weak typeof(self) weakSelf = self;

    [self.service getPackWithMessage:self.stickerMessage completion:^(STKStickerPackObject *stickerPack, BOOL isDownloaded) {
        if (stickerPack) {
            weakSelf.stickerPack = stickerPack;
            self.stickerPackDownloaded = isDownloaded;
            weakSelf.collectionView.hidden = NO;
            [weakSelf.activityIndicator stopAnimating];
            [weakSelf.collectionView reloadData];
        }

    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stickerPack.stickers.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    STKStickerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"STKStickerViewCell" forIndexPath:indexPath];
    STKStickerObject *sticker = self.stickerPack.stickers[indexPath.item];
    [cell configureWithStickerMessage:sticker.stickerMessage placeholder:nil placeholderColor:nil];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        STKPackDescriptionHeader *stickerHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"STKPackDescriptionHeader" forIndexPath:indexPath];
        
        stickerHeader.artistLabel.text = self.stickerPack.artist;
        stickerHeader.packNameLabel.text = self.stickerPack.packTitle;
        
        if (self.stickerPack.price.integerValue > 0) {
            stickerHeader.priceLabel.text = [NSString stringWithFormat:@"%@ $", self.stickerPack.price];
        } else {
            stickerHeader.priceLabel.text = nil;
        }
        [stickerHeader.statusButton setTitleColor:[UIColor colorWithRed:1 green:0.34 blue:0.13 alpha:1] forState:UIControlStateNormal];
        [stickerHeader.statusButton setTitleColor:[UIColor colorWithRed:1 green:0.34 blue:0.13 alpha:1] forState:UIControlStateHighlighted];
        if (self.stickerPack.disabled.boolValue) {
            [stickerHeader.statusButton setTitle:@"Download" forState:UIControlStateNormal];
            [stickerHeader.statusButton setTitle:@"Download" forState:UIControlStateHighlighted];

        } else {
            [stickerHeader.statusButton setTitle:@"Remove" forState:UIControlStateNormal];
            [stickerHeader.statusButton setTitle:@"Remove" forState:UIControlStateHighlighted];


        }
        
        [stickerHeader.statusButton invalidateIntrinsicContentSize];
        
        stickerHeader.delegate = self;
        
        stickerHeader.descriptionLabel.text = self.stickerPack.packDescription;
        [stickerHeader.descriptionLabel setPreferredMaxLayoutWidth:collectionView.frame.size.width];
        
        UIImage *defaultPlaceholder = [UIImage imageNamed:@"StickerPlaceholder"];
        defaultPlaceholder = [defaultPlaceholder imageWithImageTintColor:[STKUtility defaultGrayColor]];
        stickerHeader.packImageView.image = defaultPlaceholder;
        [stickerHeader.packImageView df_setImageWithResource:[STKUtility mainImageUrlForPackName:self.stickerPack.packName]];
        
        return stickerHeader;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    STKPackDescriptionHeader *stickerHeader = [[NSBundle mainBundle] loadNibNamed:@"STKPackDescriptionHeader" owner:self options:nil].firstObject;
    stickerHeader.artistLabel.text = self.stickerPack.artist;
    stickerHeader.packNameLabel.text = self.stickerPack.packTitle;
    stickerHeader.descriptionLabel.text = self.stickerPack.packDescription;
    [stickerHeader.descriptionLabel setPreferredMaxLayoutWidth:collectionView.frame.size.width];
    [stickerHeader.packImageView df_setImageWithResource:[STKUtility mainImageUrlForPackName:self.stickerPack.packName]];

    
    stickerHeader.bounds = CGRectMake(0, 0, collectionView.frame.size.width, 0);
    
    [stickerHeader setNeedsLayout];
    [stickerHeader layoutIfNeeded];
    
    CGSize size = [stickerHeader systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return CGSizeMake(collectionView.frame.size.width, size.height);
    
}

#pragma mark - Actions

- (IBAction)closeAction:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - STKPackDescriptionHeaderDelegate

- (void)packDescriptionHeader:(STKPackDescriptionHeader *)header didTapDownloadButton:(UIButton*)button {
    [self.service togglePackDisabling:self.stickerPack];
    [self reloadStickerPack];
    if ([self.delegate respondsToSelector:@selector(packDescriptionControllerDidChangePakcStatus:)]) {
        [self.delegate packDescriptionControllerDidChangePakcStatus:self];
    }
}

@end
