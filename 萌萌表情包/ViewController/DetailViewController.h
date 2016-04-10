//
//  DetailViewController.h
//  WeChatStickers
//
//  Created by Amon on 16/3/28.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController <UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImage *paramImage;

@property (nonatomic, strong) UIView *shareView;

@end
