//
//  BaseViewController.h
//  WeChatStickers
//
//  Created by Amon on 16/3/27.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+YYAdd.h"
#import "Constants.h"
#import "AppMacro.h"
#import "SVProgressHUD.h"

@interface BaseViewController : UIViewController

/**
 *  加载数据
 */
- (void)configureData;

/**
 *  加载默认UI
 */
- (void)initBaseUI;

/**
 *  加载视图
 */
- (void)initUI;

/**
 *  点击返回上层界面
 */
- (void)gotoBack;


@end
