//
//  XMPushTransition.m
//  WeChatStickers
//
//  Created by Amon on 16/3/28.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "XMPushTransition.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "ListItem.h"


@implementation XMPushTransition

+ (instancetype)transitionWithTransitionType:(XMTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(XMTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case XMTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
        case XMTransitionTypePop:
            [self popAnimation:transitionContext];
            break;
        default:
            break;
    }
}


- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DetailViewController *toVC = (DetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    ListItem *item = (ListItem *)fromVC.currentItem;
    UIView *containerView = [transitionContext containerView];
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [item.imageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [item.imageView convertRect:item.imageView.bounds toView: containerView];
    //设置动画前的各个控件的状态
    item.imageView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    //tempView 添加到containerView中，要保证在最前方，所以后添加
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    //开始做动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55     initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        //tempView先隐藏不销毁，pop的时候还会用
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
    }];
}


- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    DetailViewController *fromVC = (DetailViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ListItem *item = (ListItem *)toVC.currentItem;
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *tempView = containerView.subviews.lastObject;
    //设置初始状态
    item.imageView.hidden = YES;
    fromVC.imageView.hidden = YES;
    tempView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [item.imageView convertRect:item.imageView.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            tempView.hidden = YES;
            fromVC.imageView.hidden = NO;
        }else{//手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            item.imageView.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}


@end
