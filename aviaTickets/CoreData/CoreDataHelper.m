//
//  CoreDataHelper.m
//  aviaTickets
//
//  Created by Ekaterina on 20.03.21.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper ()
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@end


@implementation CoreDataHelper

+ (instancetype)sharedInstance {
    static CoreDataHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataHelper alloc] init];
        [instance setup];
    });
    return instance;
}

#pragma mark - FavoriteTicket

- (void)setup {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"DataModel.sqlite"];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSPersistentStore* store = [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    if (!store) {
        abort();
    }
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
}

- (void)save {
    NSError *error;
    [self.managedObjectContext save: &error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (FavoriteTicket *)favoriteFromTicket:(Ticket *)ticket {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    request.predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
    return [[self.managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavorite:(Ticket *)ticket {
    return [self favoriteFromTicket:ticket] != nil;
}

- (void)addToFavorite:(Ticket *)ticket {
    FavoriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteTicket" inManagedObjectContext:self.managedObjectContext];
    favorite.price = ticket.price.intValue;
    favorite.airline = ticket.airline;
    favorite.departure = ticket.departure;
    favorite.expires = ticket.expires;
    favorite.flightNumber = ticket.flightNumber.intValue;
    favorite.returnDate = ticket.returnDate;
    favorite.from = ticket.from;
    favorite.to = ticket.to;
    favorite.created = [NSDate date];
    [self save];
}

- (void)removeFromFavorite:(Ticket *)ticket {
    FavoriteTicket *favorite = [self favoriteFromTicket:ticket];
    if (favorite) {
        [self.managedObjectContext deleteObject:favorite];
        [self save];
    }
}

- (NSArray *)favorites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
    return [self.managedObjectContext executeFetchRequest:request error:nil];
}

#pragma mark - FavoriteMapPrice

- (BOOL)isFavoriteMapPrice:(MapPrice *)mapPrice {
    return [self favoriteFromMapPrice: mapPrice] != nil;
}

- (FavoriteMapPrice *)favoriteFromMapPrice:(MapPrice *)mapPrice {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteMapPrice"];
    request.predicate = [NSPredicate predicateWithFormat:@"destinationName == %@ AND destinationCode == %@ AND originName == %@ AND originCode == %@ AND departure == %@ AND returnDate == %@ AND numberOfChanges == %ld AND value == %ld AND distance == %ld", mapPrice.destination.name, mapPrice.destination.code, mapPrice.origin.name, mapPrice.origin.code, mapPrice.departure, mapPrice.returnDate, (long)mapPrice.numberOfChanges, (long)mapPrice.value, (long)mapPrice.distance];
    
    return [[self.managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (void)addToFavoriteMapPrice:(MapPrice *)mapPrice {
    FavoriteMapPrice *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteMapPrice" inManagedObjectContext:self.managedObjectContext];
    favorite.destinationName = mapPrice.destination.name;
    favorite.destinationCode = mapPrice.destination.code;
    favorite.originName = mapPrice.origin.name;
    favorite.originCode = mapPrice.origin.code;
    favorite.departure = mapPrice.departure;
    favorite.returnDate = mapPrice.returnDate;
    favorite.numberOfChanges = mapPrice.numberOfChanges;
    favorite.value = mapPrice.value;
    favorite.distance = mapPrice.distance;
    favorite.actual = mapPrice.actual;
    [self save];
}

- (void)removeFromFavoriteMapPrice:(MapPrice *)mapPrice {
    FavoriteMapPrice *favoritePrice = [self favoriteFromMapPrice:mapPrice];
    if (favoritePrice) {
        [self.managedObjectContext deleteObject:favoritePrice];
        [self save];
    }
}

- (NSArray *)favoriteMapPrices {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteMapPrice"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"departure" ascending:NO]];
    return [self.managedObjectContext executeFetchRequest:request error:nil];
}

@end
