//
//  STKChatCell.h
//  StickerFactory
//
//  Created by Vadim Degterev on 03.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STKChatCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *stickerImageView;

- (void) fillWithStickerMessage:(NSString*) message;

@end
