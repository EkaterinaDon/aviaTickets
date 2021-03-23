//
//  Feed.m
//  aviaTickets
//
//  Created by Ekaterina on 10.03.21.
//

#import "Feed.h"

@implementation Feed

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSDictionary *source = [dictionary valueForKey:@"source"];
        if (source && ![source isEqual:[NSNull null]]) {
            _id = [source valueForKey:@"id"];
            _name = [source valueForKey:@"name"];
        }
        _title = [dictionary valueForKey:@"title"];
        _descript = [dictionary valueForKey:@"description"];
        _url = [dictionary valueForKey:@"url"];
        _urlToImage = [dictionary valueForKey:@"urlToImage"];
        _publishedAt = [dictionary valueForKey:@"publishedAt"];
        _content = [dictionary valueForKey:@"content"];
        _author = [dictionary valueForKey:@"author"];
    }    
    return self;
}

@end
