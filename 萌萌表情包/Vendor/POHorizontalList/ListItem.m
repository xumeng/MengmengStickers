//
//  ListItem.m
//  POHorizontalList
//
//  Created by Polat Olu on 15/02/2013.
//  Copyright (c) 2013 Polat Olu. All rights reserved.
//

#import "ListItem.h"
#import "YYImage.h"

@implementation ListItem

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)imageTitle imageUrl:(NSString *)imageUrl
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUserInteractionEnabled:YES];
        
//        self.imageTitle = imageTitle;
        self.image = image;
        self.imageUrl = imageUrl;
        
        if (!image) {
            image = [YYImage imageNamed:@"doge1.gif"];
        }
        
        _imageView = [[YYAnimatedImageView alloc] initWithImage:image];

        CALayer *roundCorner = [_imageView layer];
        [roundCorner setMasksToBounds:YES];
        [roundCorner setCornerRadius:8.0];
//        [roundCorner setBorderColor:[UIColor blackColor].CGColor];
//        [roundCorner setBorderWidth:1.0];
        
//        _title = [[UILabel alloc] init];
//        [_title setBackgroundColor:[UIColor clearColor]];
//        [_title setFont:FONT_CUSTOM(1, 12)];
//        [_title setOpaque:NO];
//        [_title setText:imageTitle];
        
        imageRect = CGRectMake(0.0, 0.0, 72.0, 72.0);
        textRect = CGRectMake(0.0, imageRect.origin.y + imageRect.size.height + 10.0, 80.0, 20.0);
        
//        [_title setFrame:textRect];
        [_imageView setFrame:imageRect];
        
//        [self addSubview:_title];
        [self addSubview:_imageView];
    }
    
    return self;
}

@end
