//
//  AboutViewController.m
//  萌萌表情包
//
//  Created by Amon on 16/4/11.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    self.navigationItem.title = NSLocalizedString(@"about_title", nil);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"？" style:UIBarButtonItemStylePlain target:self action:@selector(gotoMyWebsite)];
    
    _mainView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _mainView.delegate = self;
    _mainView.alwaysBounceVertical = YES;
    [self.view addSubview:_mainView];
    
    UIImage *showImg = [UIImage imageNamed:@"doge110.jpg"];
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = showImg;
    [logoView sizeToFit];
    ViewRadius(logoView, showImg.size.width*SCALE_OF_IPHONE6_SCREEN/2);
    [_mainView addSubview:logoView];
    logoView.centerX = self.view.centerX;
    logoView.top = 20*SCALE_OF_IPHONE6_SCREEN;
    logoView.size = CGSizeMake(showImg.size.width * SCALE_OF_IPHONE6_SCREEN, showImg.size.height * SCALE_OF_IPHONE6_SCREEN);
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *appName = NSLocalizedString(@"app_name", nil);
    
    NSString *nameText = [NSString stringWithFormat:@"%@ v%@", appName, appCurVersionNum];
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = nameText;
    nameLabel.font = FONT_CUSTOM(1, 14*SCALE_OF_IPHONE6_SCREEN);
    nameLabel.textColor = UIColorFromRGB(0x666676);
    [nameLabel sizeToFit];
    [_mainView addSubview:nameLabel];
    nameLabel.centerX = self.view.centerX;
    nameLabel.top = logoView.bottom + 5;
    
    NSString *singText = @"这是一个 Cool App，\n亦是 Weird Shit；\n\n它是现象，\n亦是情怀；\n\n它承载了过去，\n却占有了现在，\n能想象着未来；\n\n它构思于脑海一瞬，\n它创造于 480 Minutes，\n它存在多久？\n于你，\n于我，\n于这里，App Store。\n\n你好，世界！\n\n		--  by 说“你好，世界”的都是孤独的人";
    UILabel *singLabel = [[UILabel alloc] init];
    singLabel.text = singText;
    singLabel.font = FONT_CUSTOM(1, 13);
    singLabel.textColor = UIColorFromRGB(0x39394a);
    singLabel.numberOfLines = 0;
    [singLabel sizeToFit];
    [_mainView addSubview:singLabel];
    singLabel.left = 20;
    singLabel.top = nameLabel.bottom + 20 * SCALE_OF_IPHONE6_SCREEN;
    
    
    
}

- (void)gotoMyWebsite {
    NSString *urlString = @"http://amonxu.com";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}


@end
