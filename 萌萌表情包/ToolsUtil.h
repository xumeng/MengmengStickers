//
//  ToolsUtil.h
//  萌萌表情包
//
//  Created by Amon on 16/4/11.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolsUtil : NSObject

/**
 *  保存用户配置
 *
 *  @param dic 用户配置
 */
+(void)saveUserConfigToNSUserDefaults:(NSDictionary *)dic;

/**
 *  保存应用配置
 *
 *  @param dic 应用配置
 */
+(void)saveAppConfigToNSUserDefaults:(NSDictionary *)dic;

/**
 *  保存配置
 *
 *  @param dic      配置内容
 *  @param dictName 配置所属字典名
 */
+(void)saveToUserDefaults:(NSDictionary *)dic dictName:(NSString *)dictName;

/**
 *  获取配置
 *
 *  @param dictName 配置所属字典名
 *
 *  @return 配置内容
 */
+ (NSDictionary *)getUserDefaults:(NSString *)dictName;

/**
 *  获取用户配置
 *
 *  @return 用户配置
 */
+ (NSDictionary *)getUserConfig;

/**
 *  获取应用配置
 *
 *  @return 应用配置
 */
+ (NSDictionary *)getAppConfig;

+ (NSString *)getAppFullVerion;

+ (NSDateComponents *)getNSDateComponents;

+ (NSDateComponents *)getNSDateComponentsByDate:(NSDate *)date;

+ (NSInteger)getCurrentYear;

+ (NSInteger)getCurrentMonth;

+ (NSInteger)getCurrentDay;

+ (NSInteger)getCurrentYearByDate:(NSDate *)date;

+ (NSInteger)getCurrentMonth:(NSDate *)date;

+ (NSInteger)getCurrentDay:(NSDate *)date;

+(NSString *) compareCurrentTime:(double)inServerTime;

+ (NSString *)getCountdownDay:(NSString *)targetDate;


@end
