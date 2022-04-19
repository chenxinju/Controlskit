//
//  CDTouploadTipView.h
//  DIYPlusObjc
//
//  Created by iOS1 on 2022/4/6.
//

#import <UIKit/UIKit.h>



@interface CDTouploadTipView : UIView

@property(nonatomic,copy) void(^confirmBtnActionBlock)(void);

@property(nonatomic,copy) NSString * titleStr;
@end
