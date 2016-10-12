//
//  ViewController.m
//  图片下载框架
//
//  Created by Apple on 16/10/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"

#import "AppInfoModel.h"


#import "HMLoadIMGOperation.h"


#import "AFNetworking.h"

@interface ViewController ()

@property(nonatomic,strong)NSArray<AppInfoModel *> *appData; ;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


//操作缓存:记录当前的操作

@property(nonatomic,strong)NSMutableDictionary *operationCahe;



//队列

@property(nonatomic,strong)NSOperationQueue *queue;


//记录之前的图片

@property(nonatomic,copy)NSString *currentString;

@end

@implementation ViewController


#pragma
#pragma mark - 懒加载

-(NSOperationQueue *)queue{
    
    if (!_queue) {
        
        _queue = [[NSOperationQueue alloc]init];
    }
    
    return  _queue;
}


-(NSMutableDictionary *)operationCahe{
    if (_operationCahe == nil) {
        
        _operationCahe = [NSMutableDictionary dictionary];
        
    }
    
    return _operationCahe;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    
    [self loadData];
    
    
}

-(void)loadData{
    
    NSString *urlString = @"https://raw.githubusercontent.com/liufan1000/SimpleDemo/master/apps.json";
    
    //创建框架
    
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    
    mager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        NSLog(@"正在下载文件");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
        
        NSMutableArray *mArray = [NSMutableArray array];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            AppInfoModel *model = [[AppInfoModel alloc]init];
            
            [model setValuesForKeysWithDictionary:obj];
            
            [mArray addObject:model];
            
        }];
        
        
        _appData = mArray.copy;
        
        NSLog(@"成功下载文件");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        NSLog(@"下载失败");
        
    }];
    

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    //显示图片
    
    if (_appData) {
        
         [self dispalayIMG];
    }
        
    
}

-(void)dispalayIMG{
    
    //获取随机的下标
    
   uint32_t index = arc4random_uniform((int)self.appData.count);
    
    
    //一下代码下载图片
    
     //1.自定义操作
    
    //获取图片地址
    
    
    NSString *urlString = self.appData[index].icon;
    
  
    //取消之前的操作
    
    
    if (![self.currentString isEqualToString:urlString]) {
        
        
//        NSLog(@"1 .currentString : %@",self.currentString);
//        
//         NSLog(@"2. urlString : %@",urlString);
        
        HMLoadIMGOperation *preOp = [self.operationCahe objectForKey:self.currentString];
        
        if (preOp) {
            
            [preOp cancel];
            
            [self.operationCahe removeObjectForKey:self.currentString];
        }

    }
    
    
    //新产生的图片路径赋值现的字符串
    self.currentString = urlString;

    HMLoadIMGOperation *op = [HMLoadIMGOperation operationWithURLString:urlString  withCompletionBlock:^(UIImage *image) {
        
        
        self.imageView.image = image;
        

//        NSLog(@"更新UI界面  %@",[NSThread currentThread]);
        
        
        [self.operationCahe removeObjectForKey:urlString];

        
    }];
    
    

    
    [self.queue addOperation:op];
    
    [self.operationCahe setValue:op forKey:urlString];
    
 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
