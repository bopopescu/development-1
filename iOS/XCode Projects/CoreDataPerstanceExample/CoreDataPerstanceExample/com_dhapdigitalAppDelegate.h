//
//  com_dhapdigitalAppDelegate.h
//  CoreDataPerstanceExample
//
//  Created by Brian Sterner on 5/9/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface com_dhapdigitalAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
