//
//  STKChatViewController.m
//  StickerFactory
//
//  Created by Vadim Degterev on 03.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKChatViewController.h"
#import "STKChatStickerCell.h"
//#import "STKStickerPanel.h"
#import "STKStickerController.h"

@interface STKChatViewController() <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, STKStickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UIView *textInputPanel;

@property (weak, nonatomic) IBOutlet UIButton *changeInputViewButton;

@property (assign, nonatomic) BOOL isKeyboardShowed;


@property (strong, nonatomic) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;

@property (strong, nonatomic) STKStickerController *stickerController;

@end

@implementation STKChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [@[@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_china]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bike]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_dontknow]]"] mutableCopy];
    
    self.inputTextView.layer.cornerRadius = 7.0;
    self.inputTextView.layer.borderWidth = 1.0;
    self.inputTextView.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.85 alpha:1].CGColor;
    
    self.textInputPanel.layer.borderWidth = 1.0;
    self.textInputPanel.layer.borderColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1].CGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willHideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didShowKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    
    //tap gesture
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewDidTap:)];
    [self.inputTextView addGestureRecognizer:tapGesture];

    [self scrollTableViewToBottom];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UI Methods

- (void) scrollTableViewToBottom {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - Notifications


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
        
    if (self.stickerController.isStickerViewShowed) {
        [self hideStickersView];
        
    } else {
        [self showStickersView];
    }

}

#pragma mark - Show/hide stickers

- (void) showStickersView {
    UIImage *buttonImage = [UIImage imageNamed:@"ShowKeyboadIcon"];
    
    [self.changeInputViewButton setImage:buttonImage forState:UIControlStateNormal];
    [self.changeInputViewButton setImage:buttonImage forState:UIControlStateHighlighted];
    
    self.inputTextView.inputView = self.stickerController.stickersView;
    [self reloadStickersInputViews];
}

- (void) hideStickersView {
    
    UIImage *buttonImage = [UIImage imageNamed:@"ShowStickersIcon"];
    
    [self.changeInputViewButton setImage:buttonImage forState:UIControlStateNormal];
    [self.changeInputViewButton setImage:buttonImage forState:UIControlStateHighlighted];
    
    self.inputTextView.inputView = nil;
    
    [self reloadStickersInputViews];
}


- (void) reloadStickersInputViews {
    [self.inputTextView reloadInputViews];
    if (!self.isKeyboardShowed) {
        [self.inputTextView becomeFirstResponder];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STKChatStickerCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell fillWithStickerMessage:self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - STKStickerControllerDelegate

- (void)stickerController:(STKStickerController *)stickerController didSelectStickerWithMessage:(NSString *)message {
    STKChatStickerCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell fillWithStickerMessage:message];
    [self.tableView beginUpdates];
    [self.dataSource addObject:message];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
    [self scrollTableViewToBottom];
    
}


#pragma mark - UITextViewDelegate


- (void)textViewDidChange:(UITextView *)textView  {
    self.textViewHeightConstraint.constant = textView.contentSize.height;
}

#pragma mark - Gesture

- (void) textViewDidTap:(UITapGestureRecognizer*) gestureRecognizer {
    [self.inputTextView becomeFirstResponder];
    if (self.stickerController.isStickerViewShowed) {
        [self hideStickersView];
    }
}

#pragma mark - Property

- (STKStickerController *)stickerController {
    if (!_stickerController) {
        _stickerController = [STKStickerController new];
        _stickerController.delegate = self;
    }
    return _stickerController;
}


@end
