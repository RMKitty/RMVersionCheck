//
//  RMVersionUtil.m
//

//
//  Created by Kitty on 2017/12/16.
//  Copyright © 2017年 R丶M. All rights reserved.
//

#import "RMVersionUtil.h"

NSString * const rmAppStoreUrl = @"http://itunes.apple.com/lookup?id=";
@interface RMVersionUtil()

@property (nonatomic,copy) NSString *rmAppId;
@property (nonatomic,copy) RMVersionCompareResult compareResult;


@end
@implementation RMVersionUtil

+ (RMVersionUtil *)standardRM {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (void)checkAndCompareVersionWithAppId:(NSString*)appStoreId andResult:(RMVersionCompareResult)result {
    
    self.compareResult = result;
    self.rmAppId = appStoreId;
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",rmAppStoreUrl,appStoreId];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:0];
    [request setHTTPMethod:@"POST"];
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
        if (data) {
            NSDictionary * receiveData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            if ([[receiveData valueForKey:@"resultCount"] intValue]>0) {
                
                [receiveStatusDic setValue:@"1" forKey:@"status"];
                [receiveStatusDic setValue:[[[receiveData valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
                
                [self performSelectorOnMainThread:@selector(receiveData:) withObject:receiveStatusDic waitUntilDone:NO];
            }else{
                
                [receiveStatusDic setValue:@"-1" forKey:@"status"];
            }

        } else  {
            [receiveStatusDic setValue:@"-1" forKey:@"status"];
        }
        
    }];
    [task resume];
    
}
-(void)receiveData:(id)sender
{
    //获取APP自身版本号
    NSString *localVersionStr = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    
    NSArray *localVersion = [localVersionStr componentsSeparatedByString:@"."];
    NSArray *serverVersion = [sender[@"version"] componentsSeparatedByString:@"."];
    
    BOOL hasUpdated = NO;
    for (int i = 0; i < serverVersion.count; i++) {
        
        if (i > localVersion.count) {
            hasUpdated = YES;
            break;
        }
        if ([serverVersion[i] integerValue] > [localVersion[i] integerValue]) {
            
            hasUpdated = YES;
            break;
        }
    }
    if (self.compareResult) {
        self.compareResult(hasUpdated);
    }
}
@end
