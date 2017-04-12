//
//  ArticleWebViewController.m
//  ArticlesProject
//
//  Created by Dan Toderici on 25/08/15.
//  Copyright (c) 2015 Dan Toderici. All rights reserved.
//

#import "ArticleWebViewController.h"
#import "Store.h"
#import "Article.h"

@interface ArticleWebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ArticleWebViewController

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor blackColor] ;
    Article *article = [[Store defaultStore] selectedArticle];
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:article.webpageURL]];
                                    
    [self.webView loadRequest:request];
}
#pragma mark-WebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

@end
