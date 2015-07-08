//
//  STKChatViewController.m
//  StickerFactory
//
//  Created by Vadim Degterev on 03.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKChatViewController.h"
#import "STKChatCell.h"
#import "STKStickerPanel.h"

@interface STKChatViewController() <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, STKStickerPanelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@property (assign, nonatomic) BOOL isKeyboardShowed;


@property (strong, nonatomic) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;

@property (strong, nonatomic) STKStickerPanel *stickerPanel;

@end

@implementation STKChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [@[@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_china]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bike]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_dontknow]]"] mutableCopy];
    
    self.inputTextView.layer.cornerRadius = 7.0;
    self.inputTextView.layer.borderWidth = 1.0;
    self.inputTextView.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.85 alpha:1].CGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willHideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didShowKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [self scrollTableViewToBottom];
}

#pragma mark - UI Methods

- (void) scrollTableViewToBottom {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - Notifications

- (void) keyboardWillChangeFrame:(NSNotification*)notification {
    //TODO: Change stickers panel size
}

- (void) didShowKeyboard:(NSNotification*)notification {
    
    CGRect keyboardBounds = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat keyboardHeight = keyboardBounds.size.height;
    
    CGFloat animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    self.bottomViewConstraint.constant = keyboardHeight;

    
    [UIView animateWithDuration:animationDuration animations:^{
        [UIView setAnimationCurve:curve];
        [self.view layoutIfNeeded];
    }];
    
    self.isKeyboardShowed = YES;
    [self scrollTableViewToBottom];
    
}


- (void)willHideKeyboard:(NSNotification*)notification {
    
    self.isKeyboardShowed = NO;
    
    CGFloat animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    self.bottomViewConstraint.constant = 0;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)changeKeyboadViewAction:(UIButton*)button {
    
    UIImage *buttonImage = nil;
    
    if (self.inputTextView.inputView) {
        buttonImage = [UIImage imageNamed:@"ShowKeyboadIcon"];
        self.inputTextView.inputView = nil;
        
    } else {
        buttonImage = [UIImage imageNamed:@"ShowStickersIcon"];
        self.inputTextView.inputView = self.stickerPanel;
    }
    if (!self.isKeyboardShowed) {
        [self.inputTextView becomeFirstResponder];
    }
    [self.inputTextView reloadInputViews];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:buttonImage forState:UIControlStateHighlighted];
    

    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STKChatCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell fillWithStickerMessage:self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - STKStickerPanelDelegate

- (void)stickerPanel:(STKStickerPanel *)stickerPanel didSelectStickerWithMessage:(NSString *)stickerMessage {
    
    STKChatCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell fillWithStickerMessage:stickerMessage];
    [self.tableView beginUpdates];
    [self.dataSource addObject:stickerMessage];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
    [self scrollTableViewToBottom];
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView  {
    self.textViewHeightConstraint.constant = textView.contentSize.height;
}

#pragma mark - Property

- (STKStickerPanel *)stickerPanel {
    if (!_stickerPanel) {
        _stickerPanel = [[STKStickerPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 225.0)];
        _stickerPanel.delegate = self;
    }
    return _stickerPanel;
}

@end
