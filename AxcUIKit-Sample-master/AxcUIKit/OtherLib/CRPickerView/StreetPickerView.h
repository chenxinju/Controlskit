

#import <UIKit/UIKit.h>

typedef void(^SelectStreetBlock)(NSString *streets,NSInteger OperatorCode);

@interface StreetPickerView : UIButton

@property (nonatomic, copy) SelectStreetBlock selectStreetBlock;

+ (instancetype)selectStreetWithStreetArr:(NSMutableArray *)streetArr back:(SelectStreetBlock)selectStreetBlock;

- (void)show;

- (void)dismiss;

@end
