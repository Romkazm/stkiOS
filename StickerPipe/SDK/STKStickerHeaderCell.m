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

@interface STKStickerHeaderCell()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) DFImageTask *imageTask;

@end

@implementation STKStickerHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24.0, 24.0)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.center = CGPointMake(self.contentView.bounds.size.width/2,self.contentView.bounds.size.height/2);
        [self addSubview:self.imageView];
        
        
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
    self.backgroundColor = [UIColor clearColor];
}

- (void)configWithStickerPackName:(NSString *)name placeholder:(UIImage *)placeholder placeholderTintColor:(UIColor *)placeholderTintColor{
    
    if ([name isEqualToString:@"Recent"]) {
        self.imageView.image = [UIImage imageNamed:@"STKRecentIcon"];
    } else {
        
        NSURL *iconUrl = [STKUtility tabImageUrlForPackName:name];
        
        UIImage *resultPlaceholder = placeholder ? placeholder : [UIImage imageNamed:@"STKStikerTabPlaceholder"];
        
        UIColor *colorForPlaceholder = placeholderTintColor && !placeholder ? placeholderTintColor : [STKUtility defaultPlaceholderGrayColor];
        
        UIImage *coloredPlaceholder = [resultPlaceholder imageWithImageTintColor:colorForPlaceholder];
        
        
        DFImageRequestOptions *options = [DFImageRequestOptions new];
        
        options.priority = DFImageRequestPriorityHigh;
        
        self.imageView.image = coloredPlaceholder;
        [self setNeedsLayout];
        
        DFImageRequest *request = [DFImageRequest requestWithResource:iconUrl targetSize:CGSizeZero contentMode:DFImageContentModeAspectFit options:options];
        
        __weak typeof(self) weakSelf = self;
        
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
