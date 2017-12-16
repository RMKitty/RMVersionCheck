# RMVersionCheck
ios local version and serve Version  check 

# How to use RMVersionUtil
```
[[RMVersionUtil standardRM] checkAndCompareVersionWithAppId:@"1149250780" andResult:^(BOOL haveUpate) {
if (haveUpate) {
NSLog(@"\n>>> 需要更新版本");
}
}];
```
