//
//  HomeViewController.m
//  easyNetNews
//
//  Created by codygao on 16/9/1.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HomeViewController.h"
#import "ChanelModel.h"
#import "customLabel.h"
#import "HomeCollectionViewCell.h"
#import "HMNewController.h"
#define kLABLELW 80
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *homecollectionlayout;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UICollectionView *HomeCollection;
@end

@implementation HomeViewController{
    NSArray *_channelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatChannelLabel];
    //设置scrollview 的相关属性，跟nav相关；
    self.automaticallyAdjustsScrollViewInsets =NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.scrollview.contentSize =CGSizeMake(kLABLELW *_channelList.count,self.scrollview.bounds.size.height);
    self.homecollectionlayout.itemSize = self.HomeCollection.bounds.size;
}
#pragma  --uicollectiondatasouce
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _channelList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homecollectioncell" forIndexPath:indexPath];
    ChanelModel *model = _channelList[indexPath.item];
    //拼接出来新闻的URL
    NSString *URLstr = [NSString stringWithFormat:@"article/headline/%@/0-20.html",model.tid];
    cell.urlstr = URLstr;
    return cell;
}
#pragma 创建频道标签的主方法
-(void)creatChannelLabel{
    //定义label的宽和高
    CGFloat labelW =kLABLELW;
    CGFloat labelH = self.scrollview.bounds.size.height;
   _channelList = [ChanelModel channels];
    for(NSInteger i = 0; i<_channelList.count; i++){
        customLabel *label = [[customLabel alloc] init];
        CGFloat labelX = kLABLELW*i;
      
        label.frame = CGRectMake(labelX, 0,labelW,labelH);
        [self.scrollview addSubview:label];
        ChanelModel *model = _channelList[i];
        label.text = model.tname;
        //给按钮添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickgesture:)];
        label.userInteractionEnabled = YES;
        label.tag = i;
        [label addGestureRecognizer:tap];
    }
    self.scrollview.contentSize =CGSizeMake(kLABLELW *_channelList.count,0) ;
}
-(void)clickgesture:(UITapGestureRecognizer *)recgnizer{
    float screencenteX = self.view.center.x;
    float recgnizerX = recgnizer.view.center.x;
    float offsetX = recgnizerX - screencenteX;
   
    float MinoffsetX = 0;
    float maxOffsetX = self.scrollview.contentSize.width - self.view.bounds.size.width;
    if (offsetX < 0){
        offsetX = MinoffsetX;
    }else if(offsetX >maxOffsetX){
        offsetX = maxOffsetX;
    }
    //设置scrollview的偏移范围
    self.scrollview.contentOffset = CGPointMake(offsetX, 0);
    //让新闻频道滚动到指定的位置
    customLabel *selectedLabel = (customLabel*)recgnizer.view;
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:selectedLabel.tag inSection:0];
    //collection 的方法
    [self.HomeCollection scrollToItemAtIndexPath:indexpath atScrollPosition:  UICollectionViewScrollPositionNone animated:NO];
}

@end
