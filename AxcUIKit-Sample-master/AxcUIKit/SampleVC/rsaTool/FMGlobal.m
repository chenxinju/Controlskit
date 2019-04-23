//
//  FMGlobal.m
//  JobProject
//
//  Created by CoDancer on 16/12/14.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "FMGlobal.h"
#import <sys/utsname.h>


#import "FMRSA.h"

@implementation FMGlobal

+ (NSDictionary *)getRealDicOf:(NSString *)str {

    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
    
    NSInteger allIdx = str.length/172;
    NSInteger i = 0;
    NSMutableString *mutStr = [NSMutableString string];
    for (i = 0; i<allIdx; ++i) {
        NSRange range = NSMakeRange(i*172, 172);
        NSString *subStr = [str substringWithRange:range];
        
        
    

     NSLog(@"解密前:%@", subStr);
       NSString *decryptedStr = [FMRSA decryptString:subStr privateKeyWithContentsOfFile:private_key_path password:@"123456"];
      NSLog(@"解密后:%@", decryptedStr);
        [mutStr appendString:decryptedStr];
        
    }
    NSData *JSONData = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}






/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 */
+ (NSString *)encryptString:(NSString *)str {
    
    //公钥路径
     NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    
//    NSLog(@"加密前:%@", str);
    NSString *encryptString = [FMRSA encryptString:str publicKeyWithContentsOfFile:public_key_path];
//    NSLog(@"加密后:%@", encryptString);
    
    return encryptString;
    
}


/**
 *  解密方法
 *
 *  @param str       需要解密的字符串
 */
+ (NSString *)decryptString:(NSString *)str {
    
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];

//    NSLog(@"解密前:%@", str);
    NSString *decryptedStr = [FMRSA decryptString:str privateKeyWithContentsOfFile:private_key_path password:@"123456"];
//    NSLog(@"解密后-%@",decryptedStr);
    return decryptedStr;
}

@end
