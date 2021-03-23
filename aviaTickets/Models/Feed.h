//
//  Feed.h
//  aviaTickets
//
//  Created by Ekaterina on 10.03.21.
//

#import <Foundation/Foundation.h>


@interface Feed : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descript;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *urlToImage;
@property (nonatomic, strong) NSString *publishedAt;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *author;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

