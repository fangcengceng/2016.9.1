//
//  hmnewCell.m
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "hmnewCell.h"
#import "UIImageView+WebCache.h"
#import "HMNewsModel.h"
@interface hmnewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extralimageViews;


@end
@implementation hmnewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setNewsmodel:(HMNewsModel *)newsmodel{
    _newsmodel = newsmodel;
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:newsmodel.imgsrc ]placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.titleLabel.text = newsmodel.title;
    self.sourceLabel.text = newsmodel.source;
    self.replyCountLabel.text = newsmodel.replyCount.description;
    if(newsmodel.imgextra.count == 2){
        for(NSInteger i = 0; i< self.extralimageViews.count;i++){
            //获取imagview对象
            UIImageView *imgView = self.extralimageViews[i];
            //取出imgview对应的图片地址
            NSArray *imagsrcArr = newsmodel.imgextra;
            NSDictionary *imagsrcDict = imagsrcArr[i];
            NSString *imagsrc = imagsrcDict[@"imgsrc"];
            //给取出的imagview赋值
            [imgView sd_setImageWithURL:[NSURL URLWithString:imagsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        }
    }
}

@end
