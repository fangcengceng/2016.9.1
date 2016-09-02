//
//  BookCell.h
//  音乐下载
//
//  Created by codygao on 16/8/30.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookModel,BookCell;
@protocol bookCellDelegate <NSObject>
-(void)clickCellToDownLoadTask:(BookCell*) selectedCell;
@end
@interface BookCell : UITableViewCell
@property(nonatomic,weak)id <bookCellDelegate> delegate;
@property(nonatomic,strong)BookModel *book;

@end
