//
//  CodeSQL.m
//  XiaoZhuShou
//
//  Created by yrq on 15-1-22.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "CodeSQL.h"

@implementation CodeSQL

- (BOOL)createDB
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [pathArray objectAtIndex:0];
    
    NSString *pathForSQL = [path  stringByAppendingPathComponent:@"myCodeSQL.sql"];
    
    if (sqlite3_open([pathForSQL UTF8String], &sql) !=SQLITE_OK){
        sqlite3_close(sql);
        return NO;
    }
    return YES;
}


- (BOOL)createTable :(NSString *)createsql
{
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, [createsql UTF8String], -1, &stmt, nil) != SQLITE_OK)
        return NO;
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}


- (BOOL)insertPLTitle:(NSString *)Title andPLID:(int)ID
{
    char *insertSQL = "insert into PLTable (PLTitle,PLID) values (?,?)";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, insertSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [Title UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 2, ID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}


- (NSMutableArray *)selectPLData
{
    char *selectSQL = "select * from PLTable";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        char *dbTitle = (char *)sqlite3_column_text(stmt, 0);
        NSString *title = [NSString stringWithCString:dbTitle encoding:NSUTF8StringEncoding];
        int ID = (int)sqlite3_column_int(stmt, 1);
        NSArray *arr = [NSArray arrayWithObjects:title,[NSString stringWithFormat:@"%i",ID], nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;
}


- (BOOL)updatePLTitle:(NSString *)title atID:(int)ID
{
    char *updateSQL = "update PLTable set PLTitle = ? where PLID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, updateSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [title UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 2, ID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}

- (BOOL)updatePLID:(int)ID atTitle:(NSString *)title
{
    char *updateSQL = "update PLTable set PLID = ? where PLTitle = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, updateSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 2, [title UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 1, ID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}



- (BOOL)deleteFromPLTable:(int)ID
{
    char *deleteSQL = "delete from PLTable where PLID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, deleteSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, ID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}


- (BOOL)insertCatalogueTitle:(NSString *)title catalogueClass:(NSString *)catalogueClass catalogueUsage:(NSString *)catalogueUsage catalogueExplain:(NSString *)catalogueExplain catalogueExample:(NSString *)catalogueExample  catalogueID:(int)catalogueID cataloguePLID:(int)cataloguePLID
{
    char *insertSQL = "insert into CatalogueTable (PLID,CatalogueID,CatalogueTitle,CatalogueExplain,CatalogueExample,CatalogueClass,CatalogueUsage) values (?,?,?,?,?,?,?)";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, insertSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, cataloguePLID);
    sqlite3_bind_int(stmt, 2, catalogueID);
    sqlite3_bind_text(stmt, 3, [title UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 4, [catalogueExplain UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 5, [catalogueExample UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 6, [catalogueClass UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 7, [catalogueUsage UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}

- (NSMutableArray *)selectCatalogueData
{
    char *selectSQL = "select * from CatalogueTable";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        char *dbTitle = (char *)sqlite3_column_text(stmt, 2);
        NSString *title = [NSString stringWithCString:dbTitle encoding:NSUTF8StringEncoding];
        char *dbClass = (char *)sqlite3_column_text(stmt, 5);
        NSString *class = [NSString stringWithCString:dbClass encoding:NSUTF8StringEncoding];
        char *dbUsage = (char *)sqlite3_column_text(stmt, 6);
        NSString *usage = [NSString stringWithCString:dbUsage encoding:NSUTF8StringEncoding];
        char *dbExplain = (char *)sqlite3_column_text(stmt, 3);
        NSString *explain = [NSString stringWithCString:dbExplain encoding:NSUTF8StringEncoding];
        char *dbExample = (char *)sqlite3_column_text(stmt, 4);
        NSString *example = [NSString stringWithCString:dbExample encoding:NSUTF8StringEncoding];
        int PLID = (int)sqlite3_column_int(stmt, 0);
        int CatalogueID = (int)sqlite3_column_int(stmt, 1);
        NSArray *arr = [NSArray arrayWithObjects:title,class,usage,explain,example,[NSString stringWithFormat:@"%i",PLID], [NSString stringWithFormat:@"%i",CatalogueID],nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;

}



- (BOOL)updateCatalogueTitle:(NSString *)title catalogueClass:(NSString *)catalogueClass catalogueUsage:(NSString *)catalogueUsage catalogueExplain:(NSString *)catalogueExplain catalogueExample:(NSString *)catalogueExample  atCatalogueID:(int)catalogueID atCataloguePLID:(int)cataloguePLID
{
    char *updateSQL = "update CatalogueTable set CatalogueTitle = ?,CatalogueExplain = ?,CatalogueExample = ?,CatalogueClass = ?,CatalogueUsage = ? where PLID = ? and CatalogueID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, updateSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [title UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 2, [catalogueExplain UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 3, [catalogueExample UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 4, [catalogueClass UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 5, [catalogueUsage UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 6, cataloguePLID);
    sqlite3_bind_int(stmt, 7, catalogueID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}

- (BOOL)updateCataloguePLID:(int)PLID atCatalogueTitle:(NSString *)catalogueTitle
{
    char *updateSQL = "update CatalogueTable set PLID = ? where CatalogueTitle = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, updateSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 2, [catalogueTitle UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 1, PLID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}


- (NSMutableArray *)selectPLTitle:(int)PLID
{
    char *selectSQL = "select PLTitle from PLTable where PLID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, PLID);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        char *dbTitle = (char *)sqlite3_column_text(stmt, 0);
        NSString *title = [NSString stringWithCString:dbTitle encoding:NSUTF8StringEncoding];
        NSArray *arr = [NSArray arrayWithObjects:title, nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;
}


- (NSMutableArray *)selectCatalogueTitle:(int)PLID
{
    char *selectSQL = "select CatalogueTitle,CatalogueClass,CatalogueID from CatalogueTable where PLID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, PLID);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        char *clTitle = (char *)sqlite3_column_text(stmt, 0);
        NSString *title = [NSString stringWithCString:clTitle encoding:NSUTF8StringEncoding];
        char *clClass = (char *)sqlite3_column_text(stmt, 1);
        NSString *class = [NSString stringWithCString:clClass encoding:NSUTF8StringEncoding];
        int ID = (int)sqlite3_column_int(stmt, 2);
        NSArray *arr = [NSArray arrayWithObjects:title,class,[NSString stringWithFormat:@"%i",ID], nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;
}

- (NSMutableArray *)selectCatalogueID:(NSString *)catalogueTitle
{
    char *selectSQL = "select CatalogueID from CatalogueTable where CatalogueTitle = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [catalogueTitle UTF8String], -1, SQLITE_TRANSIENT);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        int ID = (int)sqlite3_column_int(stmt, 0);
        NSArray *arr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%i",ID], nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;
}


- (NSMutableArray *)selectCatalogueTitleAndExplain:(NSString*)catalogueClass
{
    char *selectSQL = "select CatalogueTitle,CatalogueExplain,PLID from CatalogueTable where CatalogueClass = ? ";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [catalogueClass UTF8String], -1, SQLITE_TRANSIENT);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        char *dbTitle = (char *)sqlite3_column_text(stmt, 0);
        NSString *title = [NSString stringWithCString:dbTitle encoding:NSUTF8StringEncoding];
        char *dbExplain = (char *)sqlite3_column_text(stmt, 1);
        NSString *explain = [NSString stringWithCString:dbExplain encoding:NSUTF8StringEncoding];
        int ID = (int)sqlite3_column_int(stmt, 2);
        NSArray *arr = [NSArray arrayWithObjects:title,explain,[NSString stringWithFormat:@"%i",ID],nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;
}

- (NSMutableArray *)selectCatalogueClassAndExplain:(NSString*)catalogueTitle
{
    char *selectSQL = "select CatalogueClass,CatalogueExplain,PLID,CatalogueTitle from CatalogueTable where CatalogueTitle = ? ";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [catalogueTitle UTF8String], -1, SQLITE_TRANSIENT);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        char *dbClass = (char *)sqlite3_column_text(stmt, 0);
        NSString *class = [NSString stringWithCString:dbClass encoding:NSUTF8StringEncoding];
        char *dbExplain = (char *)sqlite3_column_text(stmt, 1);
        NSString *explain = [NSString stringWithCString:dbExplain encoding:NSUTF8StringEncoding];
        int ID = (int)sqlite3_column_int(stmt, 2);
        char *dbTitle = (char *)sqlite3_column_text(stmt, 3);
        NSString *title = [NSString stringWithCString:dbTitle encoding:NSUTF8StringEncoding];
        NSArray *arr = [NSArray arrayWithObjects:class,explain,[NSString stringWithFormat:@"%i",ID],title,nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;
}

- (NSMutableArray *)selectCatalogueTitleAndClass:(NSString*)catalogueExplain
{
    char *selectSQL = "select CatalogueTitle,CatalogueClass,PLID,CatalogueExplain from CatalogueTable where CatalogueExplain = ? ";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [catalogueExplain UTF8String], -1, SQLITE_TRANSIENT);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        char *dbTitle = (char *)sqlite3_column_text(stmt, 0);
        NSString *title = [NSString stringWithCString:dbTitle encoding:NSUTF8StringEncoding];
        char *dbClass = (char *)sqlite3_column_text(stmt, 1);
        NSString *class = [NSString stringWithCString:dbClass encoding:NSUTF8StringEncoding];
        int ID = (int)sqlite3_column_int(stmt, 2);
        char *dbExplain = (char *)sqlite3_column_text(stmt, 3);
        NSString *explain = [NSString stringWithCString:dbExplain encoding:NSUTF8StringEncoding];
        NSArray *arr = [NSArray arrayWithObjects:title,class,[NSString stringWithFormat:@"%i",ID],explain,nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;
}

- (NSMutableArray *)selectCatalogue:(int)PLID :(int)CatalogueID
{
    char *selectSQL = "select CatalogueTitle,CatalogueClass,CatalogueExplain,CatalogueExample,CatalogueUsage from CatalogueTable where PLID = ? and CatalogueID = ? ";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, PLID);
    sqlite3_bind_int(stmt, 2, CatalogueID);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        char *dbTitle = (char *)sqlite3_column_text(stmt, 0);
        NSString *title = [NSString stringWithCString:dbTitle encoding:NSUTF8StringEncoding];
        char *dbClass = (char *)sqlite3_column_text(stmt, 1);
        NSString *class = [NSString stringWithCString:dbClass encoding:NSUTF8StringEncoding];
        char *dbExplain = (char *)sqlite3_column_text(stmt, 2);
        NSString *explain = [NSString stringWithCString:dbExplain encoding:NSUTF8StringEncoding];
        char *dbExample = (char *)sqlite3_column_text(stmt, 3);
        NSString *example = [NSString stringWithCString:dbExample encoding:NSUTF8StringEncoding];
        char *dbUsage = (char *)sqlite3_column_text(stmt, 4);
        NSString *usage = [NSString stringWithCString:dbUsage encoding:NSUTF8StringEncoding];
        NSArray *arr = [NSArray arrayWithObjects:title,class,explain,example,usage, nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;

}


- (BOOL)deleteFromCatalogueTable:(int)PLID :(int)CatalogueID
{
    char *deleteSQL = "delete from CatalogueTable where PLID = ? and CatalogueID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, deleteSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, PLID);
    sqlite3_bind_int(stmt, 2, CatalogueID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}


- (BOOL)deleteAllFromCatalogueTable:(int)ID
{
    char *deleteSQL = "delete from CatalogueTable where PLID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, deleteSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, ID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}

- (NSMutableArray *)selectNoteData
{
    char *selectSQL = "select * from NoteTable";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        char *dbNote = (char *)sqlite3_column_text(stmt, 0);
        NSString *note = [NSString stringWithCString:dbNote encoding:NSUTF8StringEncoding];
        int PLID = (int)sqlite3_column_int(stmt, 1);
        int CatalogueID = (int)sqlite3_column_int(stmt, 2);
        NSArray *arr = [NSArray arrayWithObjects:note,[NSString stringWithFormat:@"%i",PLID], [NSString stringWithFormat:@"%i",CatalogueID],nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;
}




-(BOOL)insertNote:(NSString*)note :(int)PLID :(int)CatalogueID
{
    char *insertSQL = "insert into NoteTable (Note,PLID,CatalogueID) values (?,?,?)";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, insertSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [note UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 2, PLID);
    sqlite3_bind_int(stmt, 3, CatalogueID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}

-(BOOL)updateNote:(NSString*)note atPLID:(int)PLID atCatalogueID:(int)CatalogueID
{
    char *updateSQL = "update NoteTable set Note = ? where PLID = ? and CatalogueID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, updateSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [note UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 2, PLID);
    sqlite3_bind_int(stmt, 3, CatalogueID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}

- (NSMutableArray *)selectNoteAtPLID:(int)PLID :(int)CatalogueID
{
    char *selectSQL = "select Note from NoteTable where PLID = ? and CatalogueID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, PLID);
    sqlite3_bind_int(stmt, 2, CatalogueID);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        char *dbNote = (char *)sqlite3_column_text(stmt, 0);
        NSString *note = [NSString stringWithCString:dbNote encoding:NSUTF8StringEncoding];
        NSArray *arr = [NSArray arrayWithObjects:note, nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;

}

- (BOOL)deleteFromNoteTable:(int)PLID :(int)CatalogueID
{
    char *deleteSQL = "delete from NoteTable where PLID = ? and CatalogueID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, deleteSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, PLID);
    sqlite3_bind_int(stmt, 2, CatalogueID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}


- (NSMutableArray *)selectCollectData
{
    char *selectSQL = "select * from CollectTable";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        int PLID = (int)sqlite3_column_int(stmt, 0);
        int CatalogueID = (int)sqlite3_column_int(stmt, 1);
        NSArray *arr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%i",PLID], [NSString stringWithFormat:@"%i",CatalogueID],nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;
}

-(BOOL)insertCollect:(int)PLID :(int)CatalogueID
{
    char *insertSQL = "insert into CollectTable (PLID,CatalogueID) values (?,?)";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, insertSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, PLID);
    sqlite3_bind_int(stmt, 2, CatalogueID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}


- (NSMutableArray *)selectCollect:(int)PLID :(int)CatalogueID
{
    char *selectSQL = "select * from CollectTable where PLID = ? and CatalogueID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, selectSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, PLID);
    sqlite3_bind_int(stmt, 2, CatalogueID);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while (sqlite3_step(stmt) == SQLITE_ROW){
        int PLID = (int)sqlite3_column_int(stmt, 0);
        int CatalogueID = (int)sqlite3_column_int(stmt, 1);
        NSArray *arr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%i",PLID], [NSString stringWithFormat:@"%i",CatalogueID], nil];
        [array addObject:arr];
    }
    sqlite3_finalize(stmt);
    return array;
    
}

- (BOOL)deleteFromCollectTable:(int)PLID :(int)CatalogueID
{
    char *deleteSQL = "delete from CollectTable where PLID = ? and CatalogueID = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(sql, deleteSQL, -1, &stmt, nil) != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_int(stmt, 1, PLID);
    sqlite3_bind_int(stmt, 2, CatalogueID);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    return YES;
}
@end
