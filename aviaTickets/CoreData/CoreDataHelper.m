//
//  CoreDataHelper.m
//  aviaTickets
//
//  Created by Ekaterina on 20.03.21.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper ()

@end


@implementation CoreDataHelper

+ (instancetype)sharedInstance {
    static CoreDataHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataHelper alloc] init];
    });
    return instance;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DataModel"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



#pragma mark - FavoriteTicket

- (FavoriteTicket *)favoriteFromTicket:(Ticket *)ticket {
    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    
    NSString *format = @"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld";
    request.predicate = [NSPredicate predicateWithFormat:format, (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
    NSArray *tickets = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
        return nil;
    }
    
    return tickets.firstObject;
}

- (BOOL)isFavorite:(Ticket *)ticket {
    return [self favoriteFromTicket:ticket] != nil;
}

- (void)addToFavorite:(Ticket *)ticket {
    FavoriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteTicket" inManagedObjectContext:self.persistentContainer.viewContext];
    favorite.price = ticket.price.intValue;
    favorite.airline = ticket.airline;
    favorite.departure = ticket.departure;
    favorite.expires = ticket.expires;
    favorite.flightNumber = ticket.flightNumber.intValue;
    favorite.returnDate = ticket.returnDate;
    favorite.from = ticket.from;
    favorite.to = ticket.to;
    favorite.created = [NSDate date];
    [self saveContext];
}

- (void)removeFromFavorite:(Ticket *)ticket {
    FavoriteTicket *favorite = [self favoriteFromTicket:ticket];
    if (favorite) {
        [self.persistentContainer.viewContext deleteObject:favorite];
        [self saveContext];
    }
}

- (NSArray *)favorites {
    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    request.sortDescriptors = @[
        [NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]
    ];
    
    NSArray *tickets = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    return tickets;
}

#pragma mark - FavoriteMapPrice

- (BOOL)isFavoriteMapPrice:(MapPrice *)mapPrice {
    return [self favoriteFromMapPrice: mapPrice] != nil;
}

- (FavoriteMapPrice *)favoriteFromMapPrice:(MapPrice *)mapPrice {
    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteMapPrice"];
    
    NSString *format = @"destinationName == %@ AND destinationCode == %@ AND originName == %@ AND originCode == %@ AND departure == %@ AND returnDate == %@ AND numberOfChanges == %ld AND value == %ld AND distance == %ld";
    request.predicate = [NSPredicate predicateWithFormat:format, mapPrice.destination.name, mapPrice.destination.code, mapPrice.origin.name, mapPrice.origin.code, mapPrice.departure, mapPrice.returnDate, (long)mapPrice.numberOfChanges, (long)mapPrice.value, (long)mapPrice.distance];
    NSArray *tickets = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
        return nil;
    }
    
    return tickets.firstObject;
}

- (void)addToFavoriteMapPrice:(MapPrice *)mapPrice {
    FavoriteMapPrice *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteMapPrice" inManagedObjectContext:self.persistentContainer.viewContext];
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
    [self saveContext];
}

- (void)removeFromFavoriteMapPrice:(MapPrice *)mapPrice {
    FavoriteMapPrice *favoritePrice = [self favoriteFromMapPrice:mapPrice];
    if (favoritePrice) {
        [self.persistentContainer.viewContext deleteObject:favoritePrice];
        [self saveContext];
    }
}

- (NSArray *)favoriteMapPrices {
    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteMapPrice"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"departure" ascending:NO]];
    
    NSArray *tickets = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    return tickets;
}

@end
