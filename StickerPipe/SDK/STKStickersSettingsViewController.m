//
//  STKStickersSettingsViewController.m
//  StickerPipe
//
//  Created by Vadim Degterev on 05.08.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKStickersSettingsViewController.h"
#import "STKStickersEntityService.h"
#import "STKTableViewDataSource.h"
#import "STKStickerPackObject.h"
#import "STKUtility.h"
#import "STKStickerSettingsCell.h"
#import <DFImageManagerKit.h>

@interface STKStickersSettingsViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) STKStickersEntityService *service;
@property (strong, nonatomic) STKTableViewDataSource *dataSource;

@end

@implementation STKStickersSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"STKStickerSettingsCell" bundle:nil] forCellReuseIdentifier:@"STKStickerSettingsCell"];
    
    
    self.dataSource = [[STKTableViewDataSource alloc] initWithItems:nil cellIdentifier:@"STKStickerSettingsCell" configureBlock:^(STKStickerSettingsCell *cell, STKStickerPackObject *item) {
        [cell configureWithStickerPack:item];
    }];
    
    self.service = [STKStickersEntityService new];
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    [self updateStickerPacks];
    
    __weak typeof(self) wself = self;
    
    self.dataSource.deleteBlock = ^(NSIndexPath *indexPath,STKStickerPackObject* item) {
        [wself.service togglePackDisabling:item];
        [wself updateStickerPacks];
    };
    
    self.dataSource.moveBlock = ^(NSIndexPath *fromIndexPath, NSIndexPath *toIndexPath) {
      
        [wself reorderPacks];
        
    };

}

- (void) reorderPacks {
    NSMutableArray *dataSoruce = [self.dataSource dataSource];
    [dataSoruce enumerateObjectsUsingBlock:^(STKStickerPackObject* obj, NSUInteger idx, BOOL *stop) {
        obj.order = @(idx);
    }];
    
    [self.service saveStickerPacks:[NSArray arrayWithArray:dataSoruce]];
}

- (void) updateStickerPacks {
    __weak typeof(self) wself = self;
    
    [self.service getStickerPacksIgnoringRecentWithType:nil completion:^(NSArray *stickerPacks) {
        [wself.dataSource setDataSourceArray:stickerPacks];
        [wself.tableView reloadData];
    } failure:nil];
}


#pragma mark - Actions

- (IBAction)editAction:(id)sender {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
