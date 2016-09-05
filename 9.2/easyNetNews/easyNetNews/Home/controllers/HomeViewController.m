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
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *homecollectionlayout;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UICollectionView *HomeCollection;
@end

@implementation HomeViewController{
    NSArray *_channelList;
    NSMutableArray *_labelM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _labelM = [NSMutableArray array];
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
      //  设置第一个label的颜色为红色
        if(i == 0){
            label.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1.0];
        }
        [_labelM addObject:label];
    }
    
    self.scrollview.contentSize =CGSizeMake(kLABLELW *_channelList.count,0) ;
}

#pragma 上下联动，点击label，下面的collectionView滚动到对应的视图
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
#pragma 上下联动，滚动collectionviews，上面的label切换到对应的试图
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取下面的偏移量
    CGFloat offsetX = self.HomeCollection.contentOffset.x;
  //   NSLog(@"%f",offsetX);
    //根据偏移量，获取collectionViewd的下标
    NSInteger index = offsetX/self.view.bounds.size.width;
   // NSLog(@"%ld",index);
    //从标签容器中取出对应的角标的label
    customLabel *currentLabel = _labelM[index];
    //计算label需要滚动的偏移量
    float labelOffSetX = currentLabel.center.x - self.view.center.x;
    //设置滚动偏移量的最大最小值
    float MinlabelOffSetX = 0;
    float MaxLabelOffsetX = self.scrollview.contentSize.width - self.view.bounds.size.width;
    if(labelOffSetX < MinlabelOffSetX){
        labelOffSetX = 0;
    }else if(labelOffSetX >MaxLabelOffsetX){
        labelOffSetX = MaxLabelOffsetX;
    }
    //设置频道试图需要滚动到的地方
    [self.scrollview setContentOffset:CGPointMake(labelOffSetX,0) animated:YES];
}
#pragma mark 上下联动，滚动下面的，改变label字体的颜色
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    //MARK: 根据偏移量，计算字体的颜色
    //获取浮点数
    CGFloat index_float = offsetX/self.view.bounds.size.width;
     // NSLog(@"index_float == %f",index_float);//
    //获取整形数
    NSInteger index = offsetX/self.view.bounds.size.width;
    //    NSLog(@"index == %ld",index);//
    //左边的索引，就是当前的索引
    NSInteger left_index = index;
    //右边的索引，就是当前的索引加一
    NSInteger right_index = index +1;
    //获取缩放百分比
    CGFloat percent = index_float- index;
    //左边的缩放比
    CGFloat left_scale = 1-percent;
    //右边的缩放比
    CGFloat right_scale = percent;
    NSLog(@"左边的缩放比%f，左边的索引%zd，右边的缩放比%f， 右边的索引%zd",left_scale,left_index,right_scale,right_index);
    //左边的缩放比
    customLabel *left_label = _labelM[left_index];
    left_label.scale = left_scale;
//   //右边的缩放比
    if(right_index<_labelM.count){
    customLabel *right_label =_labelM[right_index];
    right_label.scale = right_scale;
    }
}
@end
