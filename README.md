# RMVersionCheck
```
iOS 7.0+
```
ios local version and serve Version  check 

# How to use RMVersionUtil
* installation with CocoaPods: ` pod 'RMVersionCheck'`
* Manual import:
    * Drag All files in the `RMVersionCheck` folder to project
    * Impodt the main file : `#import "RMVersionUtil.h"`
```objc
[[RMVersionUtil standardRM] checkAndCompareVersionWithAppId:@"Your App Id"  andResult:^(BOOL haveUpate) {
    if (haveUpate) {
        NSLog(@"\n>>> have a new version");
        }
}];
```
