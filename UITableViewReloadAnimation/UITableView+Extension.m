//
//  UITableView+Extension.m
//  UITableViewReloadAnimation
//
//  Created by 融通汇信 on 15/7/10.
//  Copyright © 2015年 融通汇信. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)
/**
 *  UITableView重新加载动画
 *
 *  @param   direction     cell运动方向
 *  @param   animationTime 动画持续时间，设置成1.0
 *  @param   interval      每个cell间隔，设置成0.1
 *  @eg      [self.tableView reloadDataWithDirectionType:direction AnimationTimeNum:0.5 interval:0.05];
 *
 */

- (void)reloadDataWithDirectionType:(ZPReloadAnimationDirectionType)direction AnimationTimeNum:(NSTimeInterval)animationTime interval:(NSTimeInterval)interval{
    [self reloadData];
    [self setContentOffset:self.contentOffset animated:NO];
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden = YES;
        [self reloadData];
    } completion:^(BOOL finished) {
        self.hidden = NO;
        [self visibleRowsBeginDirectionType:direction animation:animationTime interval:interval];
    }];
}

- (void)visibleRowsBeginDirectionType:(ZPReloadAnimationDirectionType)direction animation:(NSTimeInterval)animationTime interval:(NSTimeInterval)interval{
    NSArray *visibleArray = [self indexPathsForVisibleRows];
    NSInteger count = visibleArray.count;
    switch (direction) {
        case ZPReloadAnimationDirectionTop:
        {

            for (int i = 0; i < count; i++) {
                NSIndexPath *path = visibleArray[count - 1 - i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(originPoint.x, originPoint.y - 1000);
                [UIView animateWithDuration:(animationTime + (double)i *interval) delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    cell.center = CGPointMake(originPoint.x ,  originPoint.y + 2.0);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x ,  originPoint.y - 2.0);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
        case ZPReloadAnimationDirectionBottom:
        {
            for (int i = 0; i < count; i++) {
                NSIndexPath *path = visibleArray[i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(originPoint.x, originPoint.y + 1000);
                [UIView animateWithDuration:(animationTime + (double)i *interval) delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.center = CGPointMake(originPoint.x ,  originPoint.y - 2.0);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x ,  originPoint.y + 2.0);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
        case ZPReloadAnimationDirectionLeft:
        {
            for (int i = 0; i < count; i++) {
                NSIndexPath *path = visibleArray[i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(-cell.frame.size.width,  originPoint.y);
                [UIView animateWithDuration:(animationTime + (double)i *interval) delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.center = CGPointMake(originPoint.x - 2.0 ,  originPoint.y);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x + 2.0,  originPoint.y);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
        case ZPReloadAnimationDirectionRight:
        {
            for (int i = 0; i < count; i++) {
                NSIndexPath *path = visibleArray[i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(cell.frame.size.width * 3.0,  originPoint.y);
                [UIView animateWithDuration:(animationTime + (double)i *interval) delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.center = CGPointMake(originPoint.x + 2.0,  originPoint.y);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x - 2.0,  originPoint.y);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
            
        default:
            break;
    }

}
@end
