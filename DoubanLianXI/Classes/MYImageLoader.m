

#import "MYImageLoader.h"
#import <CommonCrypto/CommonCrypto.h>
@interface MYImageLoader ()
@property (nonatomic, strong) NSMutableArray *downloadedImages;
@property (nonatomic, strong) NSURLSession *session;
@end
@implementation MYImageLoader

- (NSURLSession *)session {
    return [NSURLSession sharedSession];
}
- (NSMutableArray *)downloadedImages {
    if (!_downloadedImages) {
        _downloadedImages = [[NSMutableArray alloc]init];
    }
    return _downloadedImages;
}
static MYImageLoader *loader = nil;
+ (instancetype)shareDownLoader {
    @synchronized(self) {
        if (!loader) {
            loader = [[MYImageLoader alloc]init];
        }
    }
    return loader;
}


- (NSString *)getMD5StrFromString:(NSString *)sourceStr {
//    NSLog(@"%@",sourceStr);
    const char *cStr = [sourceStr UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    NSString *md5Str = [NSString stringWithFormat:@"%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
    return md5Str;
}

- (void)downloadURL:(NSURL *)imageURL ImageBlock:(void (^)(UIImage *))imageBlock {
    if (!imageURL) {
        return;
    }
    NSString *imagePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *imageFile = [imagePath stringByAppendingPathComponent:[self getMD5StrFromString:imageURL.path]];
    if ([self.downloadedImages containsObject:[self getMD5StrFromString:imageURL.path]]) {
        NSData *imageData = [[NSData alloc]initWithContentsOfFile:imageFile];
        imageBlock([[UIImage alloc]initWithData:imageData]);
        return;
    }
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if  (imageBlock) {
            NSString *imageName = [self getMD5StrFromString:imageURL.path];
            [data writeToFile:imageFile atomically:YES];
            [self.downloadedImages addObject:imageName];
            UIImage *image = [[UIImage alloc]initWithData:data];
            dispatch_sync(dispatch_get_main_queue(), ^{
                imageBlock(image);
            });
        }
    }];
    [dataTask resume];
}
@end

@implementation UIImageView (DownloadImage)

- (void)imageWithURL:(NSURL *)imageURL {
    [self imageWithURL:imageURL placeholderImage:nil];
}

- (void)imageWithURL:(NSURL *)imageURL placeholderImage:(UIImage *)image {
    __block UIImageView *weakImageView = self;
    if (image) {
        weakImageView.image = image;
    }
    [[MYImageLoader shareDownLoader]downloadURL:imageURL ImageBlock:^(UIImage *returnImage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakImageView) {
                weakImageView.image = returnImage;
            };
        });
    }];
}
@end