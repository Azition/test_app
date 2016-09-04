#import "CustomViewController.h"
#import "THSHTTPCommunication.h"
#import "BandsintownAPIClass.h"
#import "CustomTableCell.h"

@interface CustomViewController ()
@property (nonatomic) UITableView *tableArtists;
@property (nonatomic) NSArray *listData;
@property (nonatomic) BandsintownAPIClass *api;
@end

@implementation CustomViewController

@synthesize listData;
@synthesize tableArtists;
@synthesize api;
@synthesize parentObject;

-(void)changeOrientation:(CGSize)size{
    CGRect rect;
    if (size.height < size.width) {
        rect = CGRectMake(0, 0, size.width, size.height);
    }
    else {
        rect = CGRectMake(0, 20, size.width, size.height - 20);
    }
    [self.tableArtists setFrame:rect];
}

- (void) retriveRandomJokes{
    
    self.api = [[BandsintownAPIClass alloc] init];
    [self.api search:^(NSArray *listArtists){
        self.listData = listArtists;
//        NSLog(@"%@", self.listData);
        [self.tableArtists reloadData];
    }];
}

-(UITableView *) makeTableView {
    CGFloat x = 0;
    CGFloat y = 20;
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height - y;
    rect = CGRectMake(x, y, width, height);
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    
    tableView.rowHeight = 123;
    tableView.sectionFooterHeight = tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

#pragma mark Table View Data Source Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    CustomTableCell *cell = (CustomTableCell *)[tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableCell"
                                                     owner:self
                                                   options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSUInteger row = [indexPath row];
    NSDictionary *artist = [listData objectAtIndex:row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", artist[@"name"]];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", artist[@"datetime"]];
    NSDictionary *venue = artist[@"venue"];
    cell.venueLabel.text = [NSString stringWithFormat:@"%@ %@", venue[@"country"], venue[@"city"]];
    cell.basedLabel.text = [NSString stringWithFormat:@"%@", venue[@"name"]];
    cell.artistImage.image = [UIImage imageWithData:
                              [NSData dataWithContentsOfURL:
                               [NSURL URLWithString:artist[@"imageURL"]]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    NSDictionary *artist = [self.listData objectAtIndex:row];
    NSLog(@"%@",artist);
    [ parentObject getSignal:@"mainController" imageURL:[api getURLImageArtist:artist[@"name"] thumb_url:NO]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableArtists = [self makeTableView];
//    [self.tableArtists registerClass:[CustomTableCell class]
//              forCellReuseIdentifier:@"SimpleTableIdentifier" ];
    [self.view addSubview:self.tableArtists];
    [self retriveRandomJokes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
