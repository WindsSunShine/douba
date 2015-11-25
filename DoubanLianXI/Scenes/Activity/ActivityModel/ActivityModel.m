//
//  ActivityModel.m
//  DoubanLianXI
//
//  Created by 陈凯 on 15/10/9.
//  Copyright (c) 2015年 CK_. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"owner"]) {
        self.owner = value[@"name"];
    }
}
- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"%s, %d",__FUNCTION__,__LINE__);
}
- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
    NSLog(@"%s, %d",__FUNCTION__,__LINE__);
}
- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
    }
    NSLog(@"%s, %d",__FUNCTION__,__LINE__);
}
@end
