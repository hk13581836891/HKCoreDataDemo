//
//  HKCoreDataViewController.m
//  HKCoreData
//
//  Created by houke on 2018/1/10.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "HKCoreDataViewController.h"
#import "HKCoreDataManager.h"
#import "Clothes+CoreDataClass.h"
/**
 数据库升级、模型版本升级步骤(模型版本迁徙)
 1、选中可视化建模文件（HKCoreData.xcdatamodeld） -> Editor -> Add Model Version
 2、选中可视化建模文件集合（HKCoreData.xcdatamodeld）->选中实体 ->在右侧属性检查器里第一个标签（文件标签）->Model Version ->Current ->选中新的可视化建模文件
 3、在新的可视化建模文件（模型版本）中修改实体属性
 4、新建建映射文件（New file -> Core Data - Mapping Model）生成V1.0_To_V1.1.xcmappingmodel
 5、_persistentStoreCoordinator getter方法修改options选项的值为：@{NSMigratePersistentStoresAutomaticallyOption : @YES}
 6、删除原来的模型扩展文件，再次生成新的模型扩展文件
 
 
 备注:在实体类生成模型文件后（Editor ->Create NSManagedObject Subclass），如果编译报错
 "2 duplicate symbols for architecture x86_64",可执行 选中可视化建模文件（HKCoreData.xcdatamodeld），选择实体，在右侧属性检查器里第三个标签，修改Class->Codegen 的值为 Manual/none
 */
@interface HKCoreDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HKCoreDataViewController

/**
 插入数据

 @param sender +UIBarButtonItem
 */
- (IBAction)addModel:(UIBarButtonItem *)sender {

    //先创建一个模型对象
    Clothes *cloch = [NSEntityDescription insertNewObjectForEntityForName:@"Clothes" inManagedObjectContext:[HKCoreDataManager shareManager].managedObjectContext];
    cloch.name = @"品牌";
    int price = arc4random()%1000+1;//随机数的范围是1-1000
    cloch.price = price;
    cloch.type = @"服饰";

    //插入数据源数组
    [self.dataSource addObject:cloch];

    //对数据管理器中数据进行永久存储
    [[HKCoreDataManager shareManager] saveContext];

    [_tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray array];

    //查询数据
    //1、NSFetchRequest对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Clothes"];
    //2、给查询对象设置排序
    //2.1创建排序描述对象
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];//是否升序
    request.sortDescriptors = @[sortDescriptor];
    
    //执行查询请求
    NSError *error = nil;
   
    NSAsynchronousFetchResult *result = [[HKCoreDataManager shareManager].managedObjectContext executeRequest:request error:&error];
    NSArray *resultArray = result.finalResult;
    [self.dataSource addObjectsFromArray:resultArray];
    
    
}


#pragma mark tableViewDelegate dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    Clothes *cloth =self.dataSource[indexPath.row];
    if (cloth.type) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@--价格：%lli--类型:%@",cloth.name,cloth.price,cloth.type];
    }else{
         cell.textLabel.text = [NSString stringWithFormat:@"%@--价格：%lli--类型:",cloth.name,cloth.price];
    }
    
    return cell;
}

//允许tableView可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//删除数据
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据源
        Clothes *cloth = self.dataSource[indexPath.row];
        [self.dataSource removeObject:cloth];
        
        //删除数据管理器中的数据
        [[HKCoreDataManager shareManager].managedObjectContext deleteObject:cloth];
        [[HKCoreDataManager shareManager] saveContext];//
        
        //删除单元格
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
//修改数据
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //先找到模型对象
    Clothes *cloth = self.dataSource[indexPath.row];
    cloth.name = @"Nike";
    //通过 context方法对数据进行永久保存
    [[HKCoreDataManager shareManager] saveContext];
    
    //刷新 ui
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
