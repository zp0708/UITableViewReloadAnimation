//
//  ZPReloadAnimationTVC.m
//  UITableViewReloadAnimation
//
//  Created by ZP on 15/7/10.
//  Copyright (c) 2015年 zhaopeng. All rights reserved.
//

#import "ZPReloadAnimationTVC.h"
#import "MJRefresh/MJRefresh.h"
#import "UITableView+Extension.h"
#import "MJChiBaoZiHeader.h"
static const CGFloat AnimationDuration = 2.0;

@interface ZPReloadAnimationTVC ()
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) ZPReloadAnimationDirectionType upType;
@property (nonatomic, assign) ZPReloadAnimationDirectionType downType;
@property (strong, nonatomic) UIButton *btnLeft;
@property (strong, nonatomic) UIButton *btnRight;


@end

@implementation ZPReloadAnimationTVC

- (void)viewDidLoad
{
    [self setLeftAndRightBarButtonItem];
    [self setRefresh];
}
- (void)pullUpAnimation:(UIButton *)sender {
    [self setButtonTitleWithButton:sender originTitle:@"上拉刷新"];
}

- (void)pullDownAnimation:(UIButton *)sender {
    [self setButtonTitleWithButton:sender originTitle:@"下拉刷新"];
}
- (void)setButtonTitleWithButton:(UIButton *)btn originTitle:(NSString *)origin{
    btn.tag++;
    switch (btn.tag) {
        case 1:
            [btn setTitle:@"从上至下" forState:UIControlStateNormal];
            break;
        case 2:
            [btn setTitle:@"从下至上" forState:UIControlStateNormal];
            break;
        case 3:
            [btn setTitle:@"从左至右" forState:UIControlStateNormal];
            break;
        case 4:
            [btn setTitle:@"从右至左" forState:UIControlStateNormal];
            break;
        case 5:
            [btn setTitle:origin forState:UIControlStateNormal];
            btn.tag = 0;
            break;
        default:
            break;
    }
}
- (void)setRefresh
{
    for (int i = 0; i<20; i++) {
        [self.data insertObject:[NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)] atIndex:0];
    }
    self.tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOnceData)];
    [self.tableView.header beginRefreshing];
}

- (void)loadNewData
{
    for (int i = 0; i<5; i++) {
        [self.data insertObject:[NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)] atIndex:0];
    }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshing];
            NSLog(@"%ld",_upType);
            [self.tableView reloadDataWithDirectionType:[self ZPReloadAnimationDirectionTypeWithNumber:_btnRight] AnimationTimeNum:0.5 interval:0.05];
    });
}

- (void)loadOnceData
{
    for (int i = 0; i<5; i++) {
        [self.data addObject:[NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.footer endRefreshing];
        [self.tableView reloadDataWithDirectionType:[self ZPReloadAnimationDirectionTypeWithNumber:_btnLeft] AnimationTimeNum:0.5 interval:0.05];
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据%@",self.data[indexPath.row]];
    
    return cell;
}

- (ZPReloadAnimationDirectionType)ZPReloadAnimationDirectionTypeWithNumber:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
            return ZPReloadAnimationDirectionTop;
            break;
        case 2:
            return ZPReloadAnimationDirectionBottom;
            break;
        case 3:
            return ZPReloadAnimationDirectionLeft;
            break;
        case 4:
            return ZPReloadAnimationDirectionRight;
        case 5:
            btn.tag = 0;
            return ZPReloadAnimationDirectionTop;
            break;
        default:
            break;
    }
    return ZPReloadAnimationDirectionTop;
}
- (void)setLeftAndRightBarButtonItem
{
    UIButton *btnLeft = [[UIButton alloc]init];
    btnLeft.frame = CGRectMake(0, 0, 80, 44);
    self.btnLeft = btnLeft;
    btnLeft.tag = 0;
    [btnLeft setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(pullUpAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [btnLeft setTitle:@"上拉刷新" forState:UIControlStateNormal];
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc]initWithCustomView:btnLeft];
    self.navigationItem.leftBarButtonItem = itemLeft;
    
    UIButton *btnRight = [[UIButton alloc]init];
    self.btnRight = btnRight;
    btnRight.tag = 0;
    btnRight.frame = CGRectMake(0, 0, 80, 44);
    [btnRight setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(pullDownAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [btnRight setTitle:@"下拉刷新" forState:UIControlStateNormal];
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc]initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = itemRight;
    [super viewDidLoad];
}
- (NSMutableArray *)data
{
    if (nil == _data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

@end
