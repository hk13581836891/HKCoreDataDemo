//
//  HKCoreDataManager.h
//  HKCoreData
//
//  Created by houke on 2018/1/10.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface HKCoreDataManager : NSObject

+(HKCoreDataManager *)shareManager;


//把临时数据库中的改变进行永久保存(相当于 git commit 操作)
- (void)saveContext;

//托管对象上下文（数据管理器）相当于一个临时数据库
@property (readonly, nonatomic, strong) NSManagedObjectContext *managedObjectContext;

//托管对象类型（数据模型器）创建实体之后就成为模型
@property (readonly, nonatomic, strong) NSManagedObjectModel *managedObjectModel;

//持久化存储助理(数据连接器) 整个 coredata框架的核心
@property (readonly, nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
