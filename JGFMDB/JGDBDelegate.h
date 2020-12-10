//
//  JGDBDelegate.h
//  JGFMDB
//
//  Created by JanyGee on 2020/12/10.
//

#import <Foundation/Foundation.h>

@protocol JGDBDelegate

//用来确定特殊字段  如（PRIMARY KEY,UNIQUE,NO NULL,AUTOINCREMENT)
@required
+ (NSArray *)requestedColumns;

+ (NSDictionary *)columnExtras;//额外的字段

+ (BOOL)isBlobColumn:(NSString *)name;//二进制数据

+ (BOOL)isIgnoreColumn:(NSString *)name;//需要忽略的字段

@optional
+ (NSArray *)columnPrimaryKey;//可选字段，主键子段

//    1.NULL：空值。
//    2.INTEGER：带符号的整型，具体取决有存入数字的范围大小。
//    3.REAL：浮点数字，存储为8-byte IEEE浮点数。
//    4.TEXT：字符串文本。
//    5.BLOB：二进制对象

/*
         各种符号对应类型，部分类型在新版SDK中有所变化，如long 和long long
         c char         C unsigned char
         i int          I unsigned int
         l long         L unsigned long
         s short        S unsigned short
         d double       D unsigned double
         f float        F unsigned float
         q long long    Q unsigned long long
         B BOOL
         @ 对象类型 //指针 对象类型 如NSString 是@“NSString”
         
         
         64位下long 和long long 都是Tq
         SQLite 默认支持五种数据类型TEXT、INTEGER、REAL、BLOB、NULL
         因为在项目中用的类型不多，故只考虑了少数类型
 
 if ([propertyType hasPrefix:@"T@\"NSString\""]) {
 
             [proTypes addObject:SQLTEXT];
 
         } else if ([propertyType hasPrefix:@"T@\"NSData\""]) {
 
             [proTypes addObject:SQLBLOB];
 
         } else if ([propertyType hasPrefix:@"Ti"]||[propertyType hasPrefix:@"TI"]||[propertyType hasPrefix:@"Ts"]||[propertyType hasPrefix:@"TS"]||[propertyType hasPrefix:@"TB"]||[propertyType hasPrefix:@"Tq"]||[propertyType hasPrefix:@"TQ"]) {
 
             [proTypes addObject:SQLINTEGER];
 
         } else {
 
             [proTypes addObject:SQLREAL];
         }
 
         */
@end
