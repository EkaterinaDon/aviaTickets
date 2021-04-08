//
//  NSString+Localization.m
//  aviaTickets
//
//  Created by Ekaterina on 31.03.21.
//

#import "NSString+Localization.h"

@implementation NSString (Localize)

- (NSString *)localize {
    return NSLocalizedString(self, "");
}

@end
