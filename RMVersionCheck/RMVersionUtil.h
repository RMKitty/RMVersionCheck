//
//  RMVersionUtil.h
//  
//
//  Created by Kitty on 2017/12/16.
//  Copyright © 2017年 R丶M. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RMVersionCompareResult)(BOOL haveUpate);

@interface RMVersionUtil : NSObject

+(RMVersionUtil*)standardRM;
/**
 * @method    checkAndCompareVersionWithAppId: andResult:
 * @param     appStoreId  the app id  in app store
 * @param     result  the block to be executed when the check is done.
 * @note      the completion block will be always executed on the main queue
 */
- (void)checkAndCompareVersionWithAppId:(NSString*)appStoreId andResult:(RMVersionCompareResult)result;
@end
