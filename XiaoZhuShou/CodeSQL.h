//
//  CodeSQL.h
//  XiaoZhuShou
//
//  Created by yrq on 15-1-22.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface CodeSQL : NSObject{
    sqlite3 *sql;
}
//建库
- (BOOL)createDB;
//建表
- (BOOL)createTable :(NSString *)createsql;
//插入语言ID
- (BOOL)insertPLTitle:(NSString *)Title andPLID:(int)ID;
- (NSMutableArray *)selectPLData;
- (BOOL)updatePLTitle:(NSString *)title atID:(int)ID;
- (BOOL)updatePLID:(int)ID atTitle:(NSString *)title;
- (BOOL)deleteFromPLTable:(int)ID;

//插入条目数据
- (BOOL)insertCatalogueTitle:(NSString *)title catalogueClass:(NSString *)catalogueClass  catalogueUsage:(NSString *)catalogueUsage catalogueExplain:(NSString *)catalogueExplain catalogueExample:(NSString *)catalogueExample  catalogueID:(int)catalogueID cataloguePLID:(int)cataloguePLID;
- (NSMutableArray *)selectCatalogueData;
//更新条目数据
- (BOOL)updateCatalogueTitle:(NSString *)title catalogueClass:(NSString *)catalogueClass  catalogueUsage:(NSString *)catalogueUsage catalogueExplain:(NSString *)catalogueExplain catalogueExample:(NSString *)catalogueExample  atCatalogueID:(int)catalogueID atCataloguePLID:(int)cataloguePLID;
//刷新条目的语言ID
-(BOOL)updateCataloguePLID:(int)PLID atCatalogueTitle:(NSString *)catalogueTitle;

//选择语言名称数据
- (NSMutableArray *)selectPLTitle:(int)PLID;
//选择条目数据
- (NSMutableArray *)selectCatalogueTitle:(int)PLID;
- (NSMutableArray *)selectCatalogueID:(NSString*)catalogueTitle;
- (NSMutableArray *)selectCatalogueTitleAndExplain:(NSString*)catalogueClass;
- (NSMutableArray *)selectCatalogueClassAndExplain:(NSString*)catalogueTitle;
- (NSMutableArray *)selectCatalogueTitleAndClass:(NSString*)catalogueExplain;
//选择条目详细数据
- (NSMutableArray *)selectCatalogue:(int)PLID :(int)CatalogueID;
- (BOOL)deleteFromCatalogueTable:(int)PLID :(int)CatalogueID;
- (BOOL)deleteAllFromCatalogueTable:(int)ID;

//笔记相关的操作
- (NSMutableArray *)selectNoteData;
-(BOOL)insertNote:(NSString*)note :(int)PLID :(int)CatalogueID;
-(BOOL)updateNote:(NSString*)note atPLID:(int)PLID atCatalogueID:(int)CatalogueID;
- (NSMutableArray *)selectNoteAtPLID:(int)PLID :(int)CatalogueID;
- (BOOL)deleteFromNoteTable:(int)PLID :(int)CatalogueID;

//收藏相关的操作
- (NSMutableArray *)selectCollectData;
-(BOOL)insertCollect:(int)PLID :(int)CatalogueID;
- (NSMutableArray *)selectCollect:(int)PLID :(int)CatalogueID;
- (BOOL)deleteFromCollectTable:(int)PLID :(int)CatalogueID;
@end
