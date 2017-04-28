//
//  SectorProgressViewController.m
//  GYHPhotoLoadingView
//
//  Created by 范英强 on 16/7/13.
//  Copyright © 2016年 gyh. All rights reserved.
//
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#import "SectorProgressViewController.h"
#import "GYHSectorProgressView.h"
#import "UIImageView+WebCache.h"

@interface SectorProgressViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation SectorProgressViewController
{
    GYHSectorProgressView *progressV;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];

    
    progressV = [[GYHSectorProgressView alloc]initWithCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    [self.view addSubview:progressV];
    //设置扇形的颜色
//    progressV.progressColor = [UIColor redColor];
    
    __weak __typeof__(self) block_self = self;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/gaoyuhang/DayDayNews/master/photo/newsfresh.png"] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = fabs(receivedSize/((CGFloat)expectedSize));
        [block_self animate:progress];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"此处应该弹框提示,并且隐藏progressV");
        }
        progressV.hidden = YES;
    }];
}

- (void)animate:(CGFloat)progress {
    progressV.progressValue = progress;
}



@end
