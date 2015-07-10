//
//  UITableView+Extension.h
//  UITableViewReloadAnimation
//
//  Created by 融通汇信 on 15/7/10.
//  Copyright © 2015年 融通汇信. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZPReloadAnimationDirectionType) {
    ZPReloadAnimationDirectionTop,
    ZPReloadAnimationDirectionBottom,
    ZPReloadAnimationDirectionLeft,
    ZPReloadAnimationDirectionRight,
};

@interface UITableView (Extension)
- (void)reloadDataWithDirectionType:(ZPReloadAnimationDirectionType)direction AnimationTimeNum:(NSTimeInterval)animationTime interval:(NSTimeInterval)interval;
@end
