# GYHPhotoLoadingView
整合了市面上主流app的图片加载指示器，环形加载，扇形加载，仿qq，微信，微博图片加载指示器
![image](https://raw.githubusercontent.com/gaoyuhang/GYHPhotoLoadingView/master/photo/haha.png)
## GIF
![GIF](https://raw.githubusercontent.com/gaoyuhang/GYHPhotoLoadingView/master/photo/testgif.gif)

##Usage
![image](https://raw.githubusercontent.com/gaoyuhang/GYHPhotoLoadingView/master/photo/jiegou.png) <br>
使用的时候直接把对应的类拖入自己的项目中即可，具体使用方法见Demo

### 第一种，根据加载的进度，环形加载
```
    progressV = [[GYHCircleProgressView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 50)/2,(SCREEN_HEIGHT - 50)/2, 50, 50)];
#warning 在这里可以修改一些属性
//    progressV.progressColor = [UIColor redColor];
//    progressV.progressStrokeWidth = 3.0f;
//    progressV.progressTrackColor = [UIColor whiteColor];
    [self.view addSubview:progressV];
    
    
    
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/gaoyuhang/DayDayNews/master/photo/newsfresh.png"] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = fabs(receivedSize/((CGFloat)expectedSize));
        progressV.progressValue = progress;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"此处应该弹框提示,并且隐藏progressV");
        }
        progressV.hidden = YES;
    }];
    
}
```
### 第二种，模仿qq，微信的图片加载，一个环形的进度一直动画，内部有数字显示进度
```
- (GYHCircleLoadingView *)circleLoadingV
{
    if (!_circleLoadingV) {
        _circleLoadingV = [[GYHCircleLoadingView alloc]initWithViewFrame:CGRectMake((SCREEN_WIDTH - 40)/2,(SCREEN_HEIGHT - 40)/2, 40, 40)];
        [self.view addSubview:_circleLoadingV];
    }
    return _circleLoadingV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //此处清除内存中的图片，便于测试
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    [self.circleLoadingV startAnimating];
    
    __weak __typeof__(self) block_self = self;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/gaoyuhang/DayDayNews/master/photo/newsfresh.png"] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = fabs(receivedSize/((CGFloat)expectedSize));
        block_self.circleLoadingV.progress = progress;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"此处应该弹框提示,并且隐藏progressV");
        }
        [block_self.circleLoadingV stopAnimating];
    }];
}
```

### 第三种，仿微博的加载效果，里边是扇形加载
```
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

```
