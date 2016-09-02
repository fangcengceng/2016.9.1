//
//  BookCell.m
//  音乐下载
//
//  Created by codygao on 16/8/30.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "BookCell.h"
#import "BookModel.h"
@interface BookCell()
@property(nonatomic,weak)UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end;
@implementation BookCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"下载" forState:UIControlStateNormal];
    [button setTitle:@"暂停" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button sizeToFit];
    self.accessoryView = button;
   [button addTarget:self action:@selector(downloadnovel:) forControlEvents:UIControlEventTouchDown];
}
#pragma 解决按钮的选中状态，点击按钮开始下载任务
-(void)downloadnovel:(UIButton*)sender{
   //除了在cell中按钮的状态改变可以直接用下面的代码
    //sender.selected = !sender.selected;
    self.book.isSelectedBtn = !self.book.isSelectedBtn;
    NSString *str = (self.book.isSelectedBtn == YES)?@"暂停" :@"下载";
    [sender setTitle:str forState:UIControlStateNormal];
    if([self.delegate respondsToSelector:@selector(clickCellToDownLoadTask:)]){
        [self.delegate clickCellToDownLoadTask:self];
    }
}
-(void)setBook:(BookModel *)book{
    _book = book;
    self.nameLabel.text = book.name;
    self.progressView.progress = book.progress;
    UIButton *button = (UIButton*)self.accessoryView;
    NSString *str =( book.isSelectedBtn == YES)?@"暂停":@"下载";
    [button setTitle:str forState:UIControlStateNormal];
}
@end
