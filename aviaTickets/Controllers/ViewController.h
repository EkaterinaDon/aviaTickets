//
//  ViewController.h
//  aviaTickets
//
//  Created by Ekaterina on 3.03.21.
//

#import <UIKit/UIKit.h>
#import "TicketsViewController.h"
#import "DataManager.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) UILabel *labelFrom;

@property (nonatomic, strong) UILabel *labelTo;

@property (nonatomic, strong) UITextField *textFieldFrom;

@property (nonatomic, strong) UITextField *textFieldTo;

@property(nonatomic, strong) UIButton *buttonFind;

@end

