//
//  DetailViewController.m
//  WeChatStickers
//
//  Created by Amon on 16/3/28.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "DetailViewController.h"
#import "YYImage.h"
#import "XMPushTransition.h"

@implementation DetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        //为什么要设置为Custom，在最后说明.
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}


- (void)initUI {
    self.title = @"分类详情";

    _imageView = [[UIImageView alloc] init];
    CGFloat imageSize = WIDTH(self.view)-20;
    _imageView.frame = CGRectMake(10, 5+HEIGHT_OF_TOP_BAR, imageSize, imageSize);
    _imageView.image = [YYImage imageNamed:@"doge1.gif"];
    [self.view addSubview:_imageView];
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    NSLog(@"%@", NSStringFromCGRect(self.imageView.frame));
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [XMPushTransition transitionWithTransitionType:operation == UINavigationControllerOperationPush ? XMTransitionTypePush : XMTransitionTypePop];
}

@end
