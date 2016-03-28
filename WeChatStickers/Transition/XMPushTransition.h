//
//  XMPushTransition.h
//  WeChatStickers
//
//  Created by Amon on 16/3/28.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XMTransitionType) {
    XMTransitionTypePush = 0,
    XMTransitionTypePop
};

@interface XMPushTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) XMTransitionType type;

+ (instancetype)transitionWithTransitionType:(XMTransitionType)type;
- (instancetype)initWithTransitionType:(XMTransitionType)type;

@end
