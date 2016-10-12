//
//  HMLoadIMGOperation.h
//  图片下载框架
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import<UIKit/UIKit.h>

@interface HMLoadIMGOperation : NSOperation

/** 保存网址 */

@property(nonatomic,copy)NSString *urlString;

/** 接受传递的图片  */

@property(nonatomic,copy) void(^completedBlock)(UIImage *image);

+(instancetype)operationWithURLString:(NSString *)urlString withCompletionBlock:(void(^)(UIImage *image))complitionBlock;


@end
