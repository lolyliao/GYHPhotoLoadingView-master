//
//  ViewController.m
//  GYHPhotoLoadingView
//
//  Created by 范英强 on 16/7/13.
//  Copyright © 2016年 gyh. All rights reserved.
//

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "CircleProgressViewController.h"
#import "CircleLoadingViewController.h"
#import "SectorProgressViewController.h"

#import "UIImage+GIF.h"

@interface ViewController ()
@property (nonatomic , strong) NSArray *titleArr;
@property (nonatomic , strong) NSArray *imgArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"photoLoadingView";
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.titleArr = @[@"环形加载",@"进度",@"扇形"];
    self.imgArr = @[[UIImage imageNamed:@"one"],[UIImage imageNamed:@"two"],[UIImage imageNamed:@"three"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"loadingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.imageView.image = self.imgArr[indexPath.row];
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CircleProgressViewController *circleVC = [[CircleProgressViewController alloc]init];
        [self.navigationController pushViewController:circleVC animated:YES];
    }else if (indexPath.row == 1){
        CircleLoadingViewController *circleVC = [[CircleLoadingViewController alloc]init];
        [self.navigationController pushViewController:circleVC animated:YES];
    }else if (indexPath.row == 2){
        SectorProgressViewController *circleVC = [[SectorProgressViewController alloc]init];
        [self.navigationController pushViewController:circleVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
