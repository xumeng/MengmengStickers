//
//  ToolsUtil.m
//  萌萌表情包
//
//  Created by Amon on 16/4/11.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "ToolsUtil.h"

@implementation ToolsUtil

+(void)saveToUserDefaults:(NSDictionary *)dic dictName:(NSString *)dictName
{
    NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
    
    [persistentDefaults setObject:dic forKey:dictName];
    
    if (persistentDefaults)
    {
        [persistentDefaults synchronize];
    }
}

+(void)saveUserConfigToNSUserDefaults:(NSDictionary *)dic
{
    [self saveToUserDefaults:dic dictName:@"userConfig"];
}
+(void)saveAppConfigToNSUserDefaults:(NSDictionary *)dic
{
    [self saveToUserDefaults:dic dictName:@"AppConfig"];
}

+ (NSDictionary *)getUserDefaults:(NSString *)dictName
{
    NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict = (NSMutableDictionary *)[persistentDefaults objectForKey:dictName];
    NSDictionary *newUserDict;
    if (!userDict) {
        newUserDict = [[NSMutableDictionary alloc] init];
    } else {
        newUserDict = [userDict mutableCopy];
    }
    return newUserDict;
}


+ (NSDictionary *)getUserConfig
{
    return [self getUserDefaults:@"userConfig"];
}

+ (NSDictionary *)getAppConfig
{
    return [self getUserDefaults:@"AppConfig"];
}

+ (NSString *)getAppFullVerion
{
    NSDictionary *appInfoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *shortVersion = [appInfoDict objectForKey:@"CFBundleShortVersionString"];
    NSString *buildVersion = [appInfoDict objectForKey:@"CFBundleVersion"];
    
    return [NSString stringWithFormat:@"%@.%@", shortVersion, buildVersion];
}

#pragma mark - 日期时间处理

+ (NSDateComponents *)getNSDateComponents
{
    return [self getNSDateComponentsByDate:[NSDate date]];
}

+ (NSDateComponents *)getNSDateComponentsByDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    return components;
}

+ (NSInteger)getCurrentYear
{
    return [[self getNSDateComponents] year];
}

+ (NSInteger)getCurrentMonth
{
    return [[self getNSDateComponents] month];
}

+ (NSInteger)getCurrentDay
{
    return [[self getNSDateComponents] day];
}

+ (NSInteger)getCurrentYearByDate:(NSDate *)date
{
    return [[self getNSDateComponentsByDate:date] year];
}

+ (NSInteger)getCurrentMonth:(NSDate *)date
{
    return [[self getNSDateComponentsByDate:date] month];
}

+ (NSInteger)getCurrentDay:(NSDate *)date
{
    return [[self getNSDateComponentsByDate:date] day];
}


+(NSString *) compareCurrentTime:(double)inServerTime
{
    NSDate *compareDate = [NSDate dateWithTimeIntervalSince1970:inServerTime];
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"%@",NSLocalizedString(@"time_just", nil)];
    }
    else if ((temp = timeInterval/60) <60) {
        result = [NSString stringWithFormat:@"%ld%@",temp,(temp>1?NSLocalizedString(@"time_minutes_ago", nil):NSLocalizedString(@"time_minute_ago", nil))];
    }
    
    else if ((temp = temp/60) <24) {
        result = [NSString stringWithFormat:@"%ld%@",temp,(temp>1?NSLocalizedString(@"time_hours_ago", nil):NSLocalizedString(@"time_hour_ago", nil))];
    }
    
    else if ((temp = temp/24) <30) {
        result = [NSString stringWithFormat:@"%ld%@",temp,(temp>1?NSLocalizedString(@"time_days_ago", nil):NSLocalizedString(@"time_day_ago", nil))];
    }
    
    else if ((temp = temp/30) <12) {
        result = [NSString stringWithFormat:@"%ld%@",temp,(temp>1?NSLocalizedString(@"time_months_ago", nil):NSLocalizedString(@"time_month_ago", nil))];
    }
    else {
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld%@",temp,(temp>1?NSLocalizedString(@"time_years_ago", nil):NSLocalizedString(@"time_year_ago", nil))];
    }
    
    return  result;
}

+ (NSString *)getCountdownDay:(NSString *)targetDate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    [dm setDateFormat:@"YYYY-MM-dd"];
    NSDate * newdate = [dm dateFromString:targetDate];
    long dd = [newdate timeIntervalSince1970] - (long)[datenow timeIntervalSince1970];
    
    NSString *timeString=@"0";
    if (dd/86400>1) {
        timeString = [NSString stringWithFormat:@"%ld", dd/86400];
    }
    return timeString;
    
}






@end
