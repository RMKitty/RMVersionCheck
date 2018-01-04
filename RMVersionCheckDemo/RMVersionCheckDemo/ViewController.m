//
//  ViewController.m
//  RMVersionCheckDemo
//
//  Created by Kitty on 2018/1/4.
//  Copyright © 2018年 R丶M. All rights reserved.
//

#import "ViewController.h"
#import "RMVersionUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[RMVersionUtil standardRM] checkAndCompareVersionWithAppId:@"1149250780" andResult:^(BOOL haveUpate) {
        if (haveUpate) {
            NSLog(@"\n>>> 需要更新版本");
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
