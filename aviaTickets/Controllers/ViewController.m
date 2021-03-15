//
//  ViewController.m
//  aviaTickets
//
//  Created by Ekaterina on 3.03.21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
    
    [self.view setBackgroundColor: [UIColor orangeColor]];
    
    [[DataManager sharedInstance] loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataComplete) name:kDataManagerLoadDataDidComplete object:nil];
    
}

#pragma mark - Notification center

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
}

#pragma mark - Load data

- (void)loadDataComplete {
    self.view.backgroundColor = [UIColor yellowColor];
}

#pragma mark - Configure UI

- (void) addSubviews {
    
    CGRect frameLabelFrom = CGRectMake(16.0, 120.0, ([UIScreen mainScreen].bounds.size.width - 32.0), 20.0);
    
    _labelFrom = [[UILabel alloc] initWithFrame: frameLabelFrom];
    
    _labelFrom.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
    
    _labelFrom.textColor = [UIColor darkGrayColor];
    
    _labelFrom.textAlignment = NSTextAlignmentCenter;
    
    _labelFrom.text = @"Выберите город вылета";
    
    [self.view addSubview: _labelFrom];
    
    
    CGRect frameTextFieldFrom = CGRectMake(16.0, 160.0, ([UIScreen mainScreen].bounds.size.width - 32.0), 40.0);
    
    _textFieldFrom = [[UITextField alloc] initWithFrame:frameTextFieldFrom];
    
    _textFieldFrom.borderStyle = UITextBorderStyleRoundedRect;
    
    _textFieldFrom.placeholder = @"Откуда";
    
    _textFieldFrom.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightLight];
    
    [self.view addSubview: _textFieldFrom];
    
    
    CGRect frameLabelTo = CGRectMake(16.0, 220.0, ([UIScreen mainScreen].bounds.size.width - 32.0), 20.0);
    
    _labelTo = [[UILabel alloc] initWithFrame: frameLabelTo];
    
    _labelTo.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
    
    _labelTo.textColor = [UIColor darkGrayColor];
    
    _labelTo.textAlignment = NSTextAlignmentCenter;
    
    _labelTo.text = @"Выберите город посадки";
    
    [self.view addSubview: _labelTo];

    
    CGRect frameTextFieldTo = CGRectMake(16.0, 260.0, ([UIScreen mainScreen].bounds.size.width - 32.0), 40.0);
    
    _textFieldTo = [[UITextField alloc] initWithFrame:frameTextFieldTo];
    
    _textFieldTo.borderStyle = UITextBorderStyleRoundedRect;
    
    _textFieldTo.placeholder = @"Куда";
    
    _textFieldTo.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightLight];
    
    [self.view addSubview: _textFieldTo];
    
    CGRect frameButtonFind = CGRectMake(16.0, 330.0, ([UIScreen mainScreen].bounds.size.width - 32.0), 40.0);
    
    _buttonFind = [[UIButton alloc] initWithFrame:frameButtonFind];
    
    [_buttonFind setTitle:@"Искать" forState:UIControlStateNormal];
    
    _buttonFind.backgroundColor = [UIColor redColor];
    
    [_buttonFind addTarget:self action:@selector(findButtonTupped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: _buttonFind];
}

#pragma mark - Metods

-(void)findButtonTupped:sender {

    TicketsViewController *ticketsViewController = [[TicketsViewController alloc] init];
    [self.navigationController showViewController:ticketsViewController sender:self];
}

@end
