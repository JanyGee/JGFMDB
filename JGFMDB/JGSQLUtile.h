//
//  JGSQLUtile.h
//  JGFMDB
//
//  Created by JanyGee on 2020/12/10.
//

#import <Foundation/Foundation.h>
#import "JGDBDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface JGSQLUtile : NSObject
+ (NSString *)columnTypeWithClass:(Class)clazz
                            dict:(NSMutableDictionary *)dict
                            name:(NSString *)name;

+ (NSMutableDictionary *)checkTypeForValues:(NSMutableDictionary *)valuesDict
                                     class:(Class)clazz;

+ (NSDictionary *)propertiesForClass:(Class)cls;

#pragma mark - SQL 语句生成
+ (NSString*)sqlCreateTable:(Class)clazz
                  tableName:(NSString *)tablename;

+ (NSString *)sqlInsertOrReplaceClazz:(Class)clz
                            tableName:(NSString *)tablename
                                param:(NSDictionary *)param
                                  obj:(id)obj;

+ (NSString *)sqlInsertClazz:(Class)clz
                   tableName:(NSString *)tablename
                       param:(NSDictionary *)param
                         obj:(id)obj;

+ (NSString *)sqlConditionClazz:(Class)clz
                          param:(NSDictionary *)param;

+ (NSString *)sqlDeleteClazz:(Class)clazz
                   tableName:(NSString *)tablename
                       where:(NSString *)condition;

+ (NSString *)sqlUpdateClazz:(Class)clazz
                   tableName:(NSString *)tablename
                       param:(NSDictionary *)param
                       where:(NSString *)condition;

+ (NSString *)sqlQueryClazz:(Class)clazz
                  tableName:(NSString *)tablename
                      where:(NSString *)condition;

+ (NSString *)sqlQueryCountClazz:(Class)clazz
                       tableName:(NSString *)tablename
                           where:(NSString *)condition;

@end

NS_ASSUME_NONNULL_END
