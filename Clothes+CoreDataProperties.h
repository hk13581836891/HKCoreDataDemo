//
//  Clothes+CoreDataProperties.h
//  HKCoreData
//
//  Created by houke on 2018/1/10.
//  Copyright © 2018年 houke. All rights reserved.
//
//

#import "Clothes+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Clothes (CoreDataProperties)

+ (NSFetchRequest<Clothes *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t price;
@property (nullable, nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
