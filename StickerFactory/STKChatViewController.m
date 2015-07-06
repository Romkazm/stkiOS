//
//  STKChatViewController.m
//  StickerFactory
//
//  Created by Vadim Degterev on 03.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKChatViewController.h"
#import "STKChatCell.h"

@interface STKChatViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@property (strong, nonatomic) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;

@end

@implementation STKChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_china]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bike]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_bigsmile]]",@"[[pinkgorilla_dontknow]]"];
    
    [UIView setAnimationsEnabled:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willHideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.inputTextView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
}



- (void)willHideKeyboard:(NSNotification *)notification {
    [UIView setAnimationsEnabled:NO];
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

#pragma mark - UI

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    greenView.backgroundColor = [UIColor greenColor];
    
    self.inputTextView.inputView = greenView;
    
    [self.inputTextView reloadInputViews];
}

@end
