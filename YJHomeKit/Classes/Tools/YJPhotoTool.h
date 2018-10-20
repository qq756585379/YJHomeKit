//
//  YJPhotoTool.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/3.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface YJPhotoTool : NSObject

// 创建一个相册 (同步)
+ (PHAssetCollection *)sync_createNewAlbumCalled:(NSString *)albumName;

// 创建一个相册 (异步)
+ (void)async_createAlbum:(NSString *)ablumName
                  success:(void(^)(PHAssetCollection *))completionSuccess
                  failure:(void(^)(NSError *))failure;

/**
 *  保存一个UIImage对象到某一个相册里，若没有该相册会先自动创建
 */
+ (void)saveImage:(UIImage *)image
          ToAlbum:(NSString *)albumName
       completion:(void(^)(PHAsset *imageAsset))completion
          failure:(void(^)(NSError *error))failure;

/**
 *  通过一个图片的本地url保存该图片到某一个相册里
 */
+ (void)saveImageWithImageUrl:(NSURL *)imageUrl
                      ToAlbum:(NSString *)albumName
                   completion:(void(^)(PHAsset *imageAsset))completion
                      failure:(void(^)(NSError *error))failure;

/**
 *  保存一个imageData对象到某一个相册里
 */
+ (void)saveImageData:(NSData *)imageData
              ToAlbum:(NSString *)albumName
           completion:(void(^)(PHAsset *imageAsset))completion
              failure:(void(^)(NSError *error))failure;

/**
 *  保存一个视频对象到某一个相册里 (异步)
 */
+ (void)async_saveVideoWithUrl:(NSURL *)videoUrl
                       ToAlbum:(NSString *)albumName
                    completion:(void(^)(NSURL *videoUrl))completion
                       failure:(void(^)(NSError *error))failure;

/**
 *  获取photos app创建的相册里所有图片
 */
+ (void)loadImagesFromAlbum:(NSString *)albumName
                 completion:(void (^)(NSMutableArray *images, NSError *error))completion;

/**
 *  获取photos app创建的相册里所有
 */
+ (void)loadMediasFromAlbum:(NSString *)albumName
                 completion:(void (^)(PHFetchResult<PHAsset *>*result))completion;

/**
 *  删除
 */
+ (void)deleteFromAlbum:(NSString *)albumName
                withUrl:(NSURL *)url
             completion:(void(^)(void))completion
                failure:(void(^)(NSError *error))failure;

/**
 *  fetch
 */
+ (PHAsset *)fetchAssetFrom:(NSString *)assetId;

+ (void)fetchVideoUrlAndAVAssetFrom:(NSString *)assetId
                         completion:(void (^)(AVAsset *avasset, NSURL *url))completion;

@end
