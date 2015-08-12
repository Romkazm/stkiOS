//
//  STKStickerPanelHeaderCell.m
//  StickerFactory
//
//  Created by Vadim Degterev on 08.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKStickerHeaderCell.h"
#import <DFImageManagerKit.h>
#import "STKUtility.h"
#import "UIImage+Tint.h"
#import "STKStickerPackObject.h"

@interface STKStickerHeaderCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) DFImageTask *imageTask;

@end

@implementation STKStickerHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24.0, 24.0)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.center = CGPointMake(self.contentView.bounds.size.width/2,self.contentView.bounds.size.height/2);
        [self.contentView addSubview:self.imageView];
        
        self.dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12.0, 12.0)];

        self.dotView.center = CGPointMake(CGRectGetMaxX(self.imageView.frame), CGRectGetMinY(self.imageView.frame));
        self.dotView.layer.cornerRadius = 6.0;
        self.dotView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.dotView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.backgroundColor = self.selectionColor ? self.selectionColor : [UIColor whiteColor];
    }
    else {
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)prepareForReuse {
    [self.imageTask cancel];
    self.imageTask = nil;
    self.imageView.image = nil;
    self.dotView.hidden = NO;
    self.backgroundColor = [UIColor clearColor];
}

- (void)configWithStickerPack:(STKStickerPackObject *)stickerPack placeholder:(UIImage *)placeholder placeholderTintColor:(UIColor *)placeholderTintColor{
    
    if ([stickerPack.packName isEqualToString:@"Recent"]) {
        self.imageView.image = [UIImage imageNamed:@"STKRecentIcon"];
        self.dotView.hidden = YES;
    } else {

        if (stickerPack.isNew.boolValue) {
            self.dotView.hidden = NO;
        } else {
            self.dotView.hidden = YES;
        }

        NSURL *iconUrl = [STKUtility tabImageUrlForPackName:stickerPack.packName];
        
        UIImage *resultPlaceholder = placeholder ? placeholder : [UIImage imageNamed:@"STKStikerTabPlaceholder"];
        
        UIColor *colorForPlaceholder = placeholderTintColor && !placeholder ? placeholderTintColor : [STKUtility defaultPlaceholderGrayColor];
        
        UIImage *coloredPlaceholder = [resultPlaceholder imageWithImageTintColor:colorForPlaceholder];
        
        
        DFImageRequestOptions *options = [DFImageRequestOptions new];
        
        options.priority = DFImageRequestPriorityHigh;
        
        self.imageView.image = coloredPlaceholder;
        [self setNeedsLayout];
        
        DFImageRequest *request = [DFImageRequest requestWithResource:iconUrl targetSize:CGSizeZero contentMode:DFImageContentModeAspectFit options:options];
        
        __weak typeof(self) weakSelf = self;
        
        //TODO:Refactoring
        self.imageTask =[[DFImageManager sharedManager] imageTaskForRequest:request completion:^(UIImage *image, NSDictionary *info) {
            
            if (image) {
                weakSelf.imageView.image = image;
                [weakSelf setNeedsLayout];
            } else {
                NSError *error = info[DFImageInfoErrorKey];
                if (error.code != -1) {
                    STKLog(@"Failed loading from header cell: %@", error.localizedDescription);
                }
            }
        }];
        
        [self.imageTask resume];
        
    }
    
}


@end
