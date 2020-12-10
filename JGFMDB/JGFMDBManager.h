//
//  JGFMDBManager.h
//  JGFMDB
//
//  Created by JanyGee on 2020/12/10.
//
//利用此类进行数据库初始化，传入沙盒路径
#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "JGDBInterface.h"
NS_ASSUME_NONNULL_BEGIN

@interface JGFMDBManager : NSObject<JGDBInterface>
@property(nonatomic, strong) FMDatabaseQueue *db;
- (instancetype)initWithPath: (NSString *)path;
@end

NS_ASSUME_NONNULL_END
