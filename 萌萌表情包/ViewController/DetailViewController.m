//
//  DetailViewController.m
//  WeChatStickers
//
//  Created by Amon on 16/3/28.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "DetailViewController.h"
#import "ToolsUtil.h"
#import "UIView+YYAdd.h"
#import "YYImage.h"
#import "XMPushTransition.h"
#import "XMShareView.h"
#import "CommonMarco.h"
#import "XMShareWechatUtil.h"
#import "XMShareQQUtil.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation DetailViewController

@synthesize paramImage;
@synthesize paramImageName;
@synthesize shareView;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:5 options:nil animations:^{
        shareView.top = _imageView.bottom + 10;
        shareView.left = 10;
//        shareView.width = WIDTH(self.view)-20;
//        shareView.height = HEIGHT(self.view) - HEIGHT_OF_TAB_BAR - BOTTEMOF(_imageView) - 10;
        [shareView sizeToFit];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)configureData {
    if ([paramImageName hasPrefix:CATE_NAME_DOGE]) {
        
        [self addUmengEvent:LOOK_DETAIL_DOGE];
        
    } else if ([paramImageName hasPrefix:CATE_NAME_GUANZHANG]) {
        
        [self addUmengEvent:LOOK_DETAIL_GUANZHANG];
        
    } else if ([paramImageName hasPrefix:CATE_NAME_WEISUOCAT]) {
        
        [self addUmengEvent:LOOK_DETAIL_WEISUOCAT];
        
    } else if ([paramImageName hasPrefix:CATE_NAME_LIUBA]) {
        
        [self addUmengEvent:LOOK_DETAIL_LIUBA];
        
    } else if ([paramImageName hasPrefix:CATE_NAME_EGAOTU]) {
        
        [self addUmengEvent:LOOK_DETAIL_EGAOTU];
        
    } else if ([paramImageName hasPrefix:CATE_NAME_EGAOGUANZHANG]) {
        
        [self addUmengEvent:LOOK_DETAIL_EGAOGUANZHANG];
        
    } else if ([paramImageName hasPrefix:CATE_NAME_LIANGCHEN]) {
        
        [self addUmengEvent:LOOK_DETAIL_LIANGCHEN];
        
    } else if ([paramImageName hasPrefix:CATE_NAME_GOUDAI]) {
        
        [self addUmengEvent:LOOK_DETAIL_GOUDAI];
        
    }
}


- (void)initUI {
    self.title = NSLocalizedString(@"detail_title", nil);

    _imageView = [[YYAnimatedImageView alloc] initWithImage:paramImage];
//    CGFloat imageSize = WIDTH(self.view)-20;
    CGSize imageSize = paramImage.size;
    if (imageSize.width > WIDTH(self.view)) {
        imageSize.width = WIDTH(self.view);
        imageSize.height = WIDTH(self.view)/paramImage.size.width *paramImage.size.height;
    }
    _imageView.frame = CGRectMake(WIDTH(self.view)/2-imageSize.width/2, 0, imageSize.width, imageSize.height);
//    _imageView.image = paramImage;
//    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    ViewRadius(_imageView, imageSize.width/10);
    [self.view addSubview:_imageView];
    
    _imageView.centerY = self.view.centerY*0.6;
    
    CGRect originFrame = CGRectMake(0, HEIGHT(self.view), WIDTH(self.view)-20, HEIGHT(self.view) - HEIGHT_OF_TAB_BAR - BOTTEMOF(_imageView) - 10);
    shareView = [[UIView alloc] initWithFrame:originFrame];
//    shareView.backgroundColor = UIColorRandom;
    [self.view addSubview:shareView];
    
    
    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    
    UIButton *wechatButton = [[UIButton alloc] init];
    [wechatButton setImage:[UIImage imageNamed:@"icon_wechat"] forState:UIControlStateNormal];
    [wechatButton addTarget:self action:@selector(shareToWeixinSession) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:wechatButton];
    
    [wechatButton sizeToFit];
    wechatButton.centerX = WIDTH(shareView) / 3 * 1;
    wechatButton.centerY = shareView.height/2;
    
    
    UIButton *timelineButton = [[UIButton alloc] init];
    [timelineButton setImage:[UIImage imageNamed:@"icon_timeline"] forState:UIControlStateNormal];
    [timelineButton addTarget:self action:@selector(shareToWeixinTimeline) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:timelineButton];
    
    [timelineButton sizeToFit];
    timelineButton.centerX = WIDTH(shareView) / 3 * 2;
    timelineButton.centerY = shareView.height/2;
    
    if (!hadInstalledWeixin) {
        wechatButton.hidden = YES;
        timelineButton.hidden = YES;
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"alert_no_wechat", nil)];
    }
    
    
//    UIButton *qqButton = [[UIButton alloc] init];
//    [qqButton setImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateNormal];
//    [qqButton addTarget:self action:@selector(shareToQQ) forControlEvents:UIControlEventTouchUpInside];
//    [shareView addSubview:qqButton];
//    
//    [qqButton sizeToFit];
//    qqButton.centerX = WIDTH(shareView) / 4 * 3;
//    qqButton.centerY = shareView.height/2;
    
    
    UIButton *favButton = [[UIButton alloc] init];
    [favButton setImage:[UIImage imageNamed:@"icon_fav"] forState:UIControlStateNormal];
    [favButton addTarget:self action:@selector(gotoFav) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:favButton];
    
    [favButton sizeToFit];
//    favButton.centerX = shareView.centerX/2;
    favButton.centerX = wechatButton.centerX;
    favButton.top = wechatButton.bottom + 20;
    
    
    UIButton *downloadButton = [[UIButton alloc] init];
    [downloadButton setImage:[UIImage imageNamed:@"icon_download"] forState:UIControlStateNormal];
    [downloadButton addTarget:self action:@selector(gotoSave) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:downloadButton];
    
    [downloadButton sizeToFit];
//    downloadButton.centerX = shareView.centerX/2*3;
    downloadButton.centerX = timelineButton.centerX;
    downloadButton.top = wechatButton.bottom + 20;
    
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    NSLog(@"%@", NSStringFromCGRect(self.imageView.frame));
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [XMPushTransition transitionWithTransitionType:operation == UINavigationControllerOperationPush ? XMTransitionTypePush : XMTransitionTypePop];
}

- (void)shareToWeixinSession
{
    [self addUmengEvent:DETAIL_SHARE_WECHAT];
    XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
//    util.shareTitle = @"Hello";
//    util.shareText = @"hehe";
//    util.shareUrl = @"http://amonxu.com";
    util.shareImageData = UIImageJPEGRepresentation(paramImage, .75);
    
    [util shareToWeixinSession];
}

- (void)shareToWeixinTimeline
{
    [self addUmengEvent:DETAIL_SHARE_TIMELINE];
    XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
    util.shareTitle = NSLocalizedString(@"share_title", nil);
    util.shareUrl = APP_URL;
    
    util.shareImageData = UIImageJPEGRepresentation(paramImage, .75);
    
    [util shareToWeixinTimeline];
    
}

- (void)shareToQQ
{
    [self addUmengEvent:DETAIL_SHARE_QQ];
    XMShareQQUtil *util = [XMShareQQUtil sharedInstance];
//    util.shareTitle = self.shareTitle;
//    util.shareText = self.shareText;
//    util.shareUrl = self.shareUrl;
    
    [util shareToQQ];
}

- (void)gotoFav {
    [self addUmengEvent:DETAIL_FAV];
    NSDictionary *userDict = [ToolsUtil getUserConfig];
    NSMutableArray *favList = userDict[@"favList"];
    if (!favList) {
        favList = [[NSMutableArray alloc] init];
    } else {
        if (![favList isMemberOfClass:[NSMutableArray class]]) {
            favList = [favList mutableCopy];
        }
    }
    
    if (![favList containsObject:paramImageName]) {
        [favList addObject:paramImageName];
        [userDict setValue:favList forKey:@"favList"];
        [ToolsUtil saveUserConfigToNSUserDefaults:userDict];
    }
    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"alert_fav_succ", nil)];
}

- (void)gotoSave {
    [self addUmengEvent:DETAIL_DOWNLOAD];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
    [library writeImageToSavedPhotosAlbum:paramImage.CGImage orientation:(ALAssetOrientation)paramImage.imageOrientation completionBlock:^(NSURL *asSetUrl,NSError *error){
        if (error) {
            //失败
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"alert_save_fail", nil)];
        }else{
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"alert_save_succ", nil)];
        }
    }];
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
