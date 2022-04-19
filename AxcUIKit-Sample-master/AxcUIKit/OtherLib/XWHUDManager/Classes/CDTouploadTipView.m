//
//  CDTouploadTipView.m
//  DIYPlusObjc
//
//  Created by iOS1 on 2022/4/6.
//

#import "CDTouploadTipView.h"

@interface CDTouploadTipView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation CDTouploadTipView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (CGSize)intrinsicContentSize {
    CGFloat contentViewH = 50;
    CGFloat contentViewW = SCREEN_WIDTH - 72*2;
    return CGSizeMake(contentViewW, contentViewH);
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CDTouploadTipView" owner:nil options:nil].firstObject;
         self.translatesAutoresizingMaskIntoConstraints = NO;
         self.layer.cornerRadius = 8;
         self.layer.masksToBounds = YES;
    }
    
   
    return self;
}



- (IBAction)confirmBtnAction:(UIButton *)sender {
    
    if (self.confirmBtnActionBlock) {
        self.confirmBtnActionBlock();
    }
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    if (titleStr.length) {
        self.titleLabel.text = titleStr;
    }
}


@end
