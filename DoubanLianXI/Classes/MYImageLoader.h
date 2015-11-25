//
//  MYImageLoader.h
//  DoubanLianXI
//
//  Created by 陈凯 on 15/10/10.
//  Copyright (c) 2015年 CK_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MYImageLoader : NSObject
+ (instancetype)shareDownLoader;
- (void)downloadURL:(NSURL *)imageURL ImageBlock:(void(^)(UIImage *returnImage))imageBlock;
@end

@interface UIImageView (DownloadImage)

- (void)imageWithURL:(NSURL *)imageURL;
- (void)imageWithURL:(NSURL *)imageURL placeholderImage:(UIImage *)image;
@end