//
//  HKCoreDataManager.m
//  HKCoreData
//
//  Created by houke on 2018/1/10.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "HKCoreDataManager.h"

@interface HKCoreDataManager ()

@property (readwrite, nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (readwrite, nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (readwrite, nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation HKCoreDataManager

+(HKCoreDataManager *)shareManager
{
    static HKCoreDataManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[HKCoreDataManager alloc] init];
        
    });
    
    return shareManager;
}

-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    //根据文件名称和文件后缀获取程序包内容文件的路径
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"HKCoreData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
    return _managedObjectModel;
    
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    NSURL *documentDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeUrl = [documentDirectory URLByAppendingPathComponent:[NSString stringWithFormat:@"HKCoreData.sqlite"]];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSError *error = NSError.new;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:@{NSMigratePersistentStoresAutomaticallyOption : @YES} error:&error]) {
        abort();
    }
    return _persistentStoreCoordinator;
    
    
}
-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    if (self.persistentStoreCoordinator) {
        
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:_persistentStoreCoordinator];
        
    }
    return _managedObjectContext;
}

-(void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
@end
