#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *venueLabel;
@property (nonatomic, weak) IBOutlet UILabel *basedLabel;
@property (nonatomic, weak) IBOutlet UIImageView *artistImage;

@end