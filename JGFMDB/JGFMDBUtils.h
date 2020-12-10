//
//  JGFMDBUtils.h
//  JGFMDB
//
//  Created by JanyGee on 2020/12/10.
//

#import <Foundation/Foundation.h>
#import "JGSQLUtile.h"
#import "FMDatabase.h"

@interface JGFMDBUtils : JGSQLUtile

//将对象转换成 parames (NSDictionary)
+ (NSDictionary*)dictionaryForObject:(id)obj;
+ (NSDictionary*)dictionaryForObject:(id)obj include:(NSArray*)includeArray;
+ (NSMutableDictionary*)mutableDictionaryForObject:(id)obj;
+ (NSMutableDictionary*)mutableDictionaryForObject:(id)obj include:(NSArray*)includeArray;

//将DB set对象转换成 对应 obj
+ (id)populateObject:(id)obj fromResultSet:(FMResultSet*)set;
+ (id)populateObject:(id)obj fromResultSet:(FMResultSet*)set exclude:(NSArray*)excludeArray;
+ (id)objectWithClass:(Class)cls fromResultSet:(FMResultSet*)set;

@end

