//
//  ProgressView.h
//  aviaTickets
//
//  Created by Ekaterina on 23.03.21.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

+ (instancetype)sharedInstance;

- (void)show:(void (^)(void))completion;
- (void)dismiss:(void (^)(void))completion;

@end


