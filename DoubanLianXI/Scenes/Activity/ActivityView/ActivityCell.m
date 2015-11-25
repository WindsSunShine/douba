//
//  ActivityCell.m
//  DoubanLianXI
//
//  Created by 陈凯 on 15/10/9.
//  Copyright (c) 2015年 CK_. All rights reserved.
//

#import "ActivityCell.h"
#import "UIImageView+WebCache.h"
@interface ActivityCell ()
// 背景绿
@property (nonatomic, strong) UIImageView *greenBackView;
// 背景白
@property (nonatomic, strong) UIImageView *whiteBackView;
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 时间
@property (nonatomic, strong) UIImageView *timeImageView;

@property (nonatomic, strong) UILabel *timeLabel;
// 地址
@property (nonatomic, strong) UIImageView *addressImageView;
@property (nonatomic, strong) UILabel *addressLabel;
// 类型
@property (nonatomic, strong) UIImageView *categoryImageView;
@property (nonatomic, strong) UILabel *categoryLabel;
// 感兴趣人数
@property (nonatomic, strong) UILabel *wishLabel;
// 参加人数
@property (nonatomic, strong) UILabel *participantLabel;
// 图片
@property (nonatomic, strong) UIImageView *activityImageView;
@end
@implementation ActivityCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews {
    self.greenBackView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 365, 170)];
    [self.contentView addSubview:self.greenBackView];
    self.whiteBackView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 38, 361, 130)];
    [self.greenBackView addSubview:self.whiteBackView];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 6, 365, 30)];
    [self.greenBackView addSubview:self.titleLabel];
    self.greenBackView.image = [UIImage imageNamed:@"bg_eventlistcell"];
    self.whiteBackView.image = [UIImage imageNamed:@"bg_share_large"];
    // 时间
    self.timeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, 20, 20)];
    self.timeImageView.image = [UIImage imageNamed:@"icon_date"];
    [self.whiteBackView addSubview:self.timeImageView];
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 2, 240, 20)];
    [self.whiteBackView addSubview:self.timeLabel];
    // 地址
    self.addressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 30, 20, 20)];
    self.addressImageView.image = [UIImage imageNamed:@"icon_spot"];
    [self.whiteBackView addSubview:self.addressImageView];
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, 240, 20)];
    [self.whiteBackView addSubview:self.addressLabel];
    // 类型
    self.categoryImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 60, 20, 20)];
    self.categoryImageView.image = [UIImage imageNamed:@"icon_catalog"];
    [self.whiteBackView addSubview:self.categoryImageView];
    self.categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 60, 240, 20)];
    [self.whiteBackView addSubview:self.categoryLabel];
    // 感兴趣，参加
    self.wishLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 100, 120, 20)];
    [self.whiteBackView addSubview:self.wishLabel];
    self.participantLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 100, 110, 20)];
    [self.whiteBackView addSubview:self.participantLabel];
    // 图片
    self.activityImageView = [[UIImageView alloc]initWithFrame:CGRectMake(275, 2, 80, 125)];
    [self.whiteBackView addSubview:self.activityImageView];
}

// 重写setter
- (void)setActivity:(ActivityModel *)activity {
    if (_activity != activity) {
        _activity = nil;
        _activity = activity;
        [self layoutModel];
    }
}
- (void)layoutModel {
    self.titleLabel.text = self.activity.title;
    self.timeLabel.text = [[self.activity.begin_time substringWithRange:NSMakeRange(5, 11)] stringByAppendingString:[self.activity.end_time substringWithRange:NSMakeRange(5, 11)]];
    self.addressLabel.text = self.activity.address;
    self.categoryLabel.text = self.activity.category_name;
    // 带属性的字符串，看一看
    NSString *wishText = [NSString stringWithFormat:@"感兴趣：%@",self.activity.wisher_count];
    // 创建可变属性字符串
    NSMutableAttributedString *wishAttributedText = [[NSMutableAttributedString alloc]initWithString:wishText];
    // 设置字体颜色
    [wishAttributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(4, wishText.length - 4)];
    self.wishLabel.attributedText = wishAttributedText;
    // 参加人数
    NSString *partText = [NSString stringWithFormat:@"参加：%@",self.activity.participant_count];
    NSMutableAttributedString *partAttributedText = [[NSMutableAttributedString alloc]initWithString:partText];
    [partAttributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(3, partText.length - 3)];
    self.participantLabel.attributedText = partAttributedText;
    
    
    
    [self.activityImageView sd_setImageWithURL:[NSURL URLWithString:self.activity.image] placeholderImage:[UIImage imageNamed:@"picholder"]];
//    [self.activityImageView sd_setImageWithURL:[] placeholderImage:<#(UIImage *)#>]
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
