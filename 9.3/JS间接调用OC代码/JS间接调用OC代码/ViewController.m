//
//  ViewController.m
//  JS间接调用OC代码
//
//  Created by codygao on 16/9/4.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.dianping.com/tuan/deal/5501525"]];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
}
//注入js
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSMutableString *str = [NSMutableString string];
   [ str appendString:@"var headerTag = document.getElementsByTagName('header')[0]; headerTag.parentNode.removeChild(headerTag);"];
    [str appendString:@"var footerTag = document.getElementsByClassName('footer')[0]; footerTag.parentNode.removeChild(footerTag);"];
    [str appendString:@"var footerBtnTag = document.getElementsByClassName('footer-btn-fix')[0]; footerBtnTag.parentNode.removeChild(footerBtnTag);"];
    [str appendString:@"var imgTag = document.getElementsByTagName('figure')[0].children[0]; imgTag.onclick=function() {window.location.href='http:www.baidu.com'};"];
    [self.webView stringByEvaluatingJavaScriptFromString:str];
    
}
//监听图片标签的点击事件
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //获取URL,调用absoluteString属性，将URl转化为字符串，方便以后开发使用
    NSString *urlstr = request.URL.absoluteString;
    NSURL *url1 = request.URL;
    NSLog(@"%@",urlstr);
    NSLog(@"%@",url1);
    if([urlstr isEqualToString:@"http:www.baidu.com"]){
        
        TestViewController *testvc = [[TestViewController alloc] init];
        [self.navigationController pushViewController:testvc animated:YES];
        return NO;
        
    }
    return YES;
}

@end
