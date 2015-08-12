//
// Created by Vadim Degterev on 12.08.15.
// Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKShowStickerButton.h"
#import "STKStickersCache.h"
#import "STKStickersNotificationConstants.h"

@interface STKShowStickerButton()

@property (nonatomic, strong) UIView *dotView;

@end

@implementation STKShowStickerButton

- (void)awakeFromNib {
    
    [self initDotView];
    [self subscribe];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        [self initDotView];
        [self subscribe];
    }

    return self;
}

- (void)subscribe {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storageUpdated:) name:STKStickersCacheDidUpdateStickersNotification object:nil];
}

- (void)storageUpdated:(NSNotification*)notification {
    if ([STKStickersCache hasNewStickerPacks]) {
        self.dotView.hidden = NO;
    } else {
        self.dotView.hidden = YES;
    }
}

- (void)initDotView {
    
    self.dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12.0, 12.0)];
    self.dotView.center = CGPointMake(CGRectGetMaxX(self.imageView.frame), CGRectGetMinY(self.imageView.frame));
    self.dotView.layer.cornerRadius = 6.0;
    self.dotView.backgroundColor = [UIColor redColor];
    [self addSubview:self.dotView];
    if ([STKStickersCache hasNewStickerPacks]) {
        self.dotView.hidden = NO;
    } else {
        self.dotView.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.dotView.center = CGPointMake(CGRectGetMaxX(self.imageView.frame), CGRectGetMinY(self.imageView.frame));
}


@end