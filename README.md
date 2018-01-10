# HKBaiduMapDemo
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
