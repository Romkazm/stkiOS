//
//  STKStickerPanelHeaderCell.m
//  StickerFactory
//
//  Created by Vadim Degterev on 08.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKStickerPanelHeaderCell.h"
#import <UIImageView+WebCache.h>
#import "STKUtility.h"

@interface STKStickerPanelHeaderCell()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation STKStickerPanelHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32.0, 32.0)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.center = CGPointMake(self.contentView.bounds.size.width/2,self.contentView.bounds.size.height/2);
        [self addSubview:self.imageView];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.backgroundColor = [UIColor whiteColor];
    }
    else {
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)prepareForReuse {
    [self.imageView sd_cancelCurrentImageLoad];
    self.imageView.image = nil;
    self.backgroundColor = [UIColor clearColor];
}

- (void)configWithStickerPackName:(NSString *)name {
    
    if ([name isEqualToString:@"Recent"]) {
        self.imageView.image = [UIImage imageNamed:@"RecentIcon"];
    } else {
        
        NSURL *iconUrl = [STKUtility tabImageUrlForPackName:name];
        
        [self.imageView sd_setImageWithURL:iconUrl];
    }
    
}

@end
