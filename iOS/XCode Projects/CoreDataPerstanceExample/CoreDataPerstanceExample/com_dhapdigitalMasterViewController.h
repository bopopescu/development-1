//
//  com_dhapdigitalMasterViewController.h
//  CoreDataPerstanceExample
//
//  Created by Brian Sterner on 5/9/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface com_dhapdigitalMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
