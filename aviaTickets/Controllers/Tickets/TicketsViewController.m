//
//  TicketsViewController.m
//  aviaTickets
//
//  Created by Ekaterina on 3.03.21.
//

#import "TicketsViewController.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketsViewController ()
@property (nonatomic, strong) NSArray *tickets;
@property (nonatomic, strong) NSArray *prices;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *dateTextField;
@end

@implementation TicketsViewController  {
    BOOL isFavorites;
    BOOL isTickets;
    TicketTableViewCell *notificationCell;
}

- (instancetype)initFavoriteTicketsController {
    self = [super init];
    if (self) {
        isFavorites = YES;
        isTickets = YES;
        self.tickets = [NSArray new];
        self.prices = [NSArray new];
        self.title = @"Избранное";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
    }
    return self;
}

- (instancetype)initWithTickets:(NSArray *)tickets {
    self = [super init];
    if (self)
    {
        isFavorites = NO;
        isTickets = YES;
        self.tickets = tickets;
        self.title = @"Билеты";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
        [self configurePicker];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (isFavorites) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.tickets = [[CoreDataHelper sharedInstance] favorites];
        self.prices = [[CoreDataHelper sharedInstance] favoriteMapPrices];
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (isFavorites) {
                self.navigationController.navigationBar.prefersLargeTitles = YES;
                self.navigationController.navigationBar.translucent = NO;
                
                self.title = @"Избранное";
                                
                self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Сохраненные билеты", @"Сохраненные из карты"]];
                [self.segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
                self.segmentedControl.tintColor = [UIColor blackColor];
                self.navigationItem.titleView = self.segmentedControl;
                self.segmentedControl.selectedSegmentIndex = 0;
            }
}

- (void)changeSource {
        isTickets = self.segmentedControl.selectedSegmentIndex == 0;
        [self.tableView reloadData];
    }


#pragma mark - datePicker configuration

- (void)configurePicker {
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.minimumDate = [NSDate date];
    
    self.dateTextField = [[UITextField alloc] initWithFrame:self.view.bounds];
    self.dateTextField.hidden = YES;
    self.dateTextField.inputView = self.datePicker;
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTap:)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    
    self.dateTextField.inputAccessoryView = keyboardToolbar;
    [self.view addSubview:self.dateTextField];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return isTickets ? self.tickets.count : self.prices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellReuseIdentifier forIndexPath:indexPath];
    if (isFavorites) {
        if (isTickets) {
            cell.favoriteTicket = [self.tickets objectAtIndex:indexPath.row];
        } else {
            cell.favoriteMapPrice = [self.prices objectAtIndex:indexPath.row];
        }
    } else {
        cell.ticket = [self.tickets objectAtIndex:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    if (isFavorites) return;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Сохранить выбранный билет?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    if ([[CoreDataHelper sharedInstance] isFavorite: [self.tickets objectAtIndex:indexPath.row]]) {
        favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] removeFromFavorite:[self->_tickets objectAtIndex:indexPath.row]];
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] addToFavorite:[self->_tickets objectAtIndex:indexPath.row]];
        }];
    }
    
    UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:@"Напомнить" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self->notificationCell = [tableView cellForRowAtIndexPath:indexPath];
        [self->_dateTextField becomeFirstResponder];
        }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:notificationAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.alpha = 0;
    cell.transform = CGAffineTransformMakeTranslation(-cell.frame.size.width, 0);
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        cell.transform = CGAffineTransformMakeTranslation(0, 0);
        cell.alpha = 0.8;
    }
                     completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2
                              delay:0.1
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            cell.contentView.alpha = 1;
        }
                         completion:nil];
    }];
}

- (void)doneButtonDidTap:(UIBarButtonItem *)sender {
    if (self.datePicker.date && notificationCell) {
        NSString *message = [NSString stringWithFormat:@"%@ - %@ за %@ руб.", notificationCell.ticket.from, notificationCell.ticket.to, notificationCell.ticket.price];
        
        NSURL *imageURL;
        if (notificationCell.airlineLogoView.image) {
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/%@.png", notificationCell.ticket.airline]];
            if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                UIImage *logo = notificationCell.airlineLogoView.image;
                NSData *pngData = UIImagePNGRepresentation(logo);
                [pngData writeToFile:path atomically:YES];
                
            }
            imageURL = [NSURL fileURLWithPath:path];
        }
        
        Notification notification = NotificationMake(@"Напоминание о билете", message, self.datePicker.date, imageURL);
        [[NotificationCenter sharedInstance] sendNotification:notification];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSLocale *ruLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
        [formatter setLocale:ruLocale];
        [formatter setDateFormat:@"dd MMMM yyyy в HH:mm"];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Успешно" message:[NSString stringWithFormat:@"Уведомление будет отправлено - %@", self.datePicker.date] preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.view endEditing:YES];
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    self.datePicker.date = [NSDate date];
    notificationCell = nil;
    [self.view endEditing:YES];
}


@end
