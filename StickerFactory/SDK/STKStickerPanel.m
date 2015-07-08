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
#import <CoreData/CoreData.h>
#import "STKStickerPackObject.h"
#import "STKStickerObject.h"
#import "NSManagedObject+STKAdditions.h"
#import "NSManagedObjectContext+STKAdditions.h"
#import "STKStickersApiClient.h"
#import "STKStickersDataModel.h"


@interface STKStickerPanel() <UICollectionViewDataSource, UICollectionViewDelegate>

//UI
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) STKStickerPanelLayout *flowLayout;
@property (strong, nonatomic) STKStickerPanelHeader *headerView;

//Common
@property (strong, nonatomic) STKStickersDataModel *dataModel;
//CoreData
@property (strong, nonatomic) NSManagedObjectContext *context;
//Api
@property (strong, nonatomic) STKStickersApiClient *apiClient;

@end

@implementation STKStickerPanel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.flowLayout = [[STKStickerPanelLayout alloc] init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.flowLayout.itemSize = CGSizeMake(80.0, 80.0);
        
        self.headerView = [[STKStickerPanelHeader alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44.0)];
        self.headerView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        
        [self addSubview:self.headerView];
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.headerView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(self.headerView.frame)) collectionViewLayout:self.flowLayout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.delaysContentTouches = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.allowsSelection = YES;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[STKStickerPanelCell class] forCellWithReuseIdentifier:@"STKStickerPanelCell"];
        [self.collectionView registerClass:[STKStickerPanelHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"STKStickerPanelHeader"];
        [self addSubview:self.collectionView];
        
        self.apiClient = [[STKStickersApiClient alloc] init];
        
        __weak typeof(self) weakSelf = self;
        
        self.dataModel = [STKStickersDataModel new];
        
        [self.apiClient getStickersPackWithType:nil success:^(id response) {
            
            [weakSelf reloadStickers];
            
        } failure:^(NSError *error) {
            
            
        }];
    }
    return self;
}

- (void) willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        [self reloadStickers];
    }
}


#pragma mark - UI methods

- (void) addConstraints {
    

    
}



#pragma mark - Work with base


- (void) reloadStickers {
    
//    self.stickerPacks = [NSMutableArray arrayWithArray:[STKStickerPack stk_findAllInContext:self.context]];
//    STKStickerPack *recentPack = [STKStickerPack getRecentsPack];
//    if (recentPack) {
//        [self.stickerPacks insertObject:recentPack atIndex:0];
//    }
    [self.dataModel updateStickers];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataModel.stickerPacks.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{

    STKStickerPackObject *stickerPack = self.dataModel.stickerPacks[section];
    return stickerPack.stickers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    STKStickerPanelCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"STKStickerPanelCell" forIndexPath:indexPath];

    STKStickerPackObject *stickerPack = self.self.dataModel.stickerPacks[indexPath.section];
        
    STKStickerObject *sticker = stickerPack.stickers[indexPath.item];

    [cell configureWithStickerMessage:sticker.stickerMessage placeholder:nil placeholderColor:[UIColor redColor]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    STKStickerPackObject *stickerPack = self.dataModel.stickerPacks[indexPath.section];
    STKStickerObject *sticker = stickerPack.stickers[indexPath.item];
    
    [self.dataModel incrementStickerUsedCount:sticker];
        
    if ([self.delegate respondsToSelector:@selector(stickerPanel:didSelectStickerWithMessage:)]) {
        [self.delegate stickerPanel:self didSelectStickerWithMessage:sticker.stickerMessage];
    }
    
}

#pragma mark - Properties


#pragma mark - Context

- (NSManagedObjectContext *)context {
    if (!_context) {
        _context = [NSManagedObjectContext stk_defaultContext];
    }
    return _context;
}

@end
