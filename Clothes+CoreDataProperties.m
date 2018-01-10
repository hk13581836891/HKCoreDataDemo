//
//  Clothes+CoreDataProperties.m
//  HKCoreData
//
//  Created by houke on 2018/1/10.
//  Copyright © 2018年 houke. All rights reserved.
//
//

#import "Clothes+CoreDataProperties.h"

@implementation Clothes (CoreDataProperties)

+ (NSFetchRequest<Clothes *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Clothes"];
}

@dynamic name;
@dynamic price;
@dynamic type;

@end
