//
//  XMShareWechatUtil.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "XMShareWechatUtil.h"
#import "WXApi.h"
#import "YYKit.h"

@implementation XMShareWechatUtil


- (void)shareToWeixinSession
{
    
//    [self shareToWeixinBase:WXSceneSession];
    [self shareStickersToWeixinBase:WXSceneSession];
    
}

- (void)shareToWeixinTimeline
{
    if (self.shareUrl) {
        [self shareToWeixinBase:WXSceneTimeline];
    } else {
        [self shareStickersToWeixinBase:WXSceneTimeline];
    }
    
}

- (void)shareToWeixinBase:(enum WXScene)scene
{
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.shareTitle;
    message.description = self.shareText;
    UIImage *thumbImage;
    if (self.shareImageData) {
        thumbImage = [UIImage imageWithData:self.shareImageData];
    } else {
        thumbImage = SHARE_IMG;
    }
    [message setThumbImage:thumbImage];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = self.shareUrl;
    
    message.mediaObject = ext;
    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
    
}

- (void)shareStickersToWeixinBase:(enum WXScene)scene
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.shareTitle;
    message.description = self.shareText;
    [message setThumbImage:[UIImage imageWithData:self.shareImageData]];
    
//    WXImageObject *imgObject = [WXImageObject object];
//    imgObject.imageData = self.shareImageData;
    
    WXEmoticonObject *imgo = [WXEmoticonObject object];
//    YYImage *image = [YYImage imageNamed:@"doge1.gif"];
    imgo.emoticonData = self.shareImageData;
    
//    WXWebpageObject *ext = [WXWebpageObject object];
//    ext.webpageUrl = self.shareUrl;
    
    message.mediaObject = imgo;
    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];

}


+ (instancetype)sharedInstance
{
    
    static XMShareWechatUtil* util;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        util = [[XMShareWechatUtil alloc] init];
        
    });
    return util;
    
}

- (instancetype)init
{
    
    static id obj=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        obj = [super init];
        if (obj) {
            
        }
        
    });
    self=obj;
    return self;
    
}


@end
