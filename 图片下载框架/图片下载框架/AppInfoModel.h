//
//  AppInfoModel.h
//  AsycLoadImage
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface AppInfoModel : NSObject

/** 标题 */
@property(nonatomic,copy)NSString *name;

/** 下载数量 */
@property(nonatomic,copy)NSString *download;

/** 图像 */
@property(nonatomic,copy)NSString *icon;

/** 记录之前下载得出图片 */

@property(nonatomic,strong)UIImage *downlodaImage;



@end
