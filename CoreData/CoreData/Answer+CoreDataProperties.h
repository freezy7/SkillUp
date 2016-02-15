//
//  Answer+CoreDataProperties.h
//  CoreData
//
//  Created by R_flava_Man on 16/2/15.
//  Copyright © 2016年 R_style_Man. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Answer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Answer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *m4a;
@property (nonatomic) BOOL unlock;
@property (nonatomic) int16_t index;

@end

NS_ASSUME_NONNULL_END
