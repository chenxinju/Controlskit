

#import <UIKit/UIKit.h>
typedef void(^SelectPrivenceBlock)(NSString *streets,long PrivenceAreaCode,NSString *CityAreaCode);

@interface PrivencePickerView : UIButton

@property (nonatomic, copy) SelectPrivenceBlock selectPrivenceBlock;

+ (instancetype)selectPrivenceWithPrivenceArr:(NSMutableArray *)privenceArr back:(SelectPrivenceBlock)selectPrivenceBlock;

- (void)show;

- (void)dismiss;

@end
