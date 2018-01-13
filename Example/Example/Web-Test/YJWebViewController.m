//
//  YJWebViewController.m
//  Example
//
//  Created by 杨俊 on 2018/1/5.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "YJWebViewController.h"
#import <PureLayout/PureLayout.h>
#import <WebKit/WebKit.h>

@interface YJWebViewController ()<WKNavigationDelegate,UIWebViewDelegate,WKUIDelegate>
@property (nonatomic,strong) WKWebView *webView;
@property (strong,nonatomic) UIProgressView *progressView;
@end

@implementation YJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self.webView autoPinEdgesToSuperviewEdges];
    
    [self.view addSubview:self.progressView];
    [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.progressView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.progressView autoSetDimension:ALDimensionHeight toSize:2];
    
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:filePath];
    [self.webView loadRequest:request];
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object != self.webView) return;
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progressView setProgress:1.0 animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            });
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }else if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    }else if ([keyPath isEqualToString:@"contentSize"]){
        //self.scrollView.contentSize = self.webView.scrollView.contentSize;
    }
}

#pragma mark - WebView Delegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.progressView setProgress:0.1 animated:YES];
    NSLog(@"webView start");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webView success");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"webView fail error = %@", error);
}

-(WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = [WKUserContentController new];
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = 10;
        configuration.preferences = preferences;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.scrollView.backgroundColor = [UIColor whiteColor];
        _webView.allowsBackForwardNavigationGestures = YES;
        
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return _webView;
}

-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [UIProgressView newAutoLayoutView];
        _progressView.tintColor = [UIColor orangeColor];
        _progressView.trackTintColor = [UIColor lightGrayColor];
    }
    return _progressView;
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [_webView removeObserver:self forKeyPath:@"title"];
}

@end
