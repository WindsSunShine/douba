//
//  ActivityModel.h
//  DoubanLianXI
//
//  Created by 陈凯 on 15/10/9.
//  Copyright (c) 2015年 CK_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *begin_time;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *category_name;
@property (nonatomic, strong) NSNumber *wisher_count;
@property (nonatomic, strong) NSNumber *participant_count;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *owner;
/*
 title ： 活动标题
 begin_time :  开始时间
 end_time ：结束时间
 address ：地址
 category_name：活动类型
 participant_count：参加人数
 wisher_count：感兴趣人数
 image：活动图像(先显示占位图像)
	name：活动举办方
	category_name：活动类型
 */
@end
