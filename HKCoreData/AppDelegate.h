//
//  AppDelegate.h
//  HKCoreData
//
//  Created by houke on 2018/1/10.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

//把临时数据库中的改变进行永久保存(相当于 git commit 操作)
- (void)saveContext;

@end

