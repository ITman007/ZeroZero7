//
//  HMLoadIMGOperation.m
//  图片下载框架
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "HMLoadIMGOperation.h"

@implementation HMLoadIMGOperation


//封装数据

+(instancetype)operationWithURLString:(NSString *)urlString withCompletionBlock:(void (^)(UIImage *))complitionBlock{
    
    
    //1.创建对象
    HMLoadIMGOperation *op = [[self alloc]init];
    
  
    
    //2.获取图片地址
    op.urlString = urlString;
    
    //3.在该代码块中设置图片
    op.completedBlock = complitionBlock;
    
    
    return op;
}

-(void)main{
    
   
    
    

    //延时下载时间
    
    [NSThread sleepForTimeInterval:5];
    
//    NSLog(@"自定义线程%@ ",[NSThread currentThread]);
    
    NSAssert(self.completedBlock != nil, @"其断定block不为空");
    
    //转化二进制数据
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if ([self isCancelled]) {
        
        return;
    }
    
    
    NSLog(@"取消状态 %d",[self isCancelled]);
    
  
    
    
    UIImage *image = [UIImage imageWithData:data];
    
    
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        
       //发出消息
        
        //判断block不为空
        
        self.completedBlock(image);
        
        
    }];
    
}




@end
