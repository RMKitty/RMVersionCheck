# RMVersionCheck
```
ios 7.0+
```
ios local version and serve Version  check 

# How to use RMVersionUtil
```
[[RMVersionUtil standardRM] checkAndCompareVersionWithAppId:@"Your App Id"  andResult:^(BOOL haveUpate) {
    if (haveUpate) {
        NSLog(@"\n>>> 需要更新版本");
        }
}];
```
