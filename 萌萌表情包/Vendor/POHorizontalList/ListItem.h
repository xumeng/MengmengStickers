//
//  ListItem.h
//  POHorizontalList
//
//  Created by Polat Olu on 15/02/2013.
//  Copyright (c) 2013 Polat Olu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppMacro.h"

@interface ListItem : UIView {
    CGRect textRect;
    CGRect imageRect;
}

@property (nonatomic, retain) NSObject *objectTag;

//@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UIImageView *imageView;

//@property (nonatomic, retain) NSString *imageTitle;
@property (nonatomic, retain) UIImage *image;

@property (nonatomic, retain) NSString *imageUrl;

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)imageTitle imageUrl:(NSString *)imageUrl;

@end
