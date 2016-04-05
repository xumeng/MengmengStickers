//
//  DetailViewController.m
//  WeChatStickers
//
//  Created by Amon on 16/3/28.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "DetailViewController.h"
#import "UIView+YYAdd.h"
#import "YYImage.h"
#import "XMPushTransition.h"
#import "XMShareView.h"
#import "CommonMarco.h"
#import "XMShareWechatUtil.h"
#import "XMShareQQUtil.h"

@implementation DetailViewController

@synthesize paramImage;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)initUI {
    self.title = @"分类详情";

    _imageView = [[UIImageView alloc] init];
    CGFloat imageSize = WIDTH(self.view)-20;
    _imageView.frame = CGRectMake(10, 5+HEIGHT_OF_TOP_BAR, imageSize, imageSize);
    _imageView.image = paramImage;
    ViewRadius(_imageView, 30);
    [self.view addSubview:_imageView];
    
    UIView *shareView = [[UIView alloc] init];
//    shareView.backgroundColor = UIColorRandom;
    [self.view addSubview:shareView];
    [shareView sizeToFit];
    shareView.top = _imageView.bottom + 10;
    shareView.left = 10;
    shareView.width = WIDTH(self.view)-20;
    shareView.height = HEIGHT(self.view) - HEIGHT_OF_TAB_BAR - BOTTEMOF(_imageView) - 10;
    
    UIButton *wechatButton = [[UIButton alloc] init];
    [wechatButton setImage:[UIImage imageNamed:@"icon_wechat"] forState:UIControlStateNormal];
    [wechatButton addTarget:self action:@selector(shareToWeixinSession) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:wechatButton];
    
    [wechatButton sizeToFit];
    wechatButton.centerX = WIDTH(shareView) / 4 * 1;
    wechatButton.centerY = shareView.height/2;
    
    
    UIButton *timelineButton = [[UIButton alloc] init];
    [timelineButton setImage:[UIImage imageNamed:@"icon_timeline"] forState:UIControlStateNormal];
    [timelineButton addTarget:self action:@selector(shareToWeixinTimeline) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:timelineButton];
    
    [timelineButton sizeToFit];
    timelineButton.centerX = WIDTH(shareView) / 4 * 2;
    timelineButton.centerY = shareView.height/2;
    
    
    UIButton *qqButton = [[UIButton alloc] init];
    [qqButton setImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateNormal];
    [qqButton addTarget:self action:@selector(shareToQQ) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:qqButton];
    
    [qqButton sizeToFit];
    qqButton.centerX = WIDTH(shareView) / 4 * 3;
    qqButton.centerY = shareView.height/2;
    
    
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    NSLog(@"%@", NSStringFromCGRect(self.imageView.frame));
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [XMPushTransition transitionWithTransitionType:operation == UINavigationControllerOperationPush ? XMTransitionTypePush : XMTransitionTypePop];
}

- (void)shareToWeixinSession
{
    XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
//    util.shareTitle = @"Hello";
//    util.shareText = @"hehe";
//    util.shareUrl = @"http://amonxu.com";
    util.shareImageData = UIImageJPEGRepresentation(paramImage, .75);
    
    [util shareToWeixinSession];
}

- (void)shareToWeixinTimeline
{
    
    XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
//    util.shareTitle = self.shareTitle;
//    util.shareText = self.shareText;
//    util.shareUrl = self.shareUrl;
    
    [util shareToWeixinTimeline];
    
}

- (void)shareToQQ
{
    XMShareQQUtil *util = [XMShareQQUtil sharedInstance];
//    util.shareTitle = self.shareTitle;
//    util.shareText = self.shareText;
//    util.shareUrl = self.shareUrl;
    
    [util shareToQQ];
}



#pragma mark - 代理回调
/**
 *  处理来自微信的请求
 *
 *  @param resp 响应体。根据 errCode 作出对应处理。
 */
- (void)onResp:(BaseResp *)resp
{
    NSString *message;
    if(resp.errCode == 0) {
        message = @"分享成功";
    }else{
        message = @"分享失败";
    }
    showAlert(message);
}




@end
