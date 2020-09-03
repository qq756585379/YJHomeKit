//
//  YJPhotoTool.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/3.
//

#import "YJPhotoTool.h"

@implementation YJPhotoTool

+ (void)getPHAuthorization:(void(^)(BOOL auth))completion
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        if (completion) completion(NO);
        return;
    }
    
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                if (completion) completion(YES);
            } else {
                if (completion) completion(NO);
            }
        }];
    } else {
        if (completion) completion(YES);
    }
}

+ (NSMutableArray<PHAsset *>*)fetchAssetCollection
{
    NSMutableArray<PHAsset *>* assets = [NSMutableArray array];
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult<PHAsset *> *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    [allPhotos enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAsset *asset = (PHAsset *)obj;
        if (asset.mediaType == PHAssetMediaTypeVideo) {
            [assets addObject:asset];
        }
    }];
    return assets;
}

// 创建一个相册 (异步)
+ (void)async_createAlbum:(NSString *)ablumName
                  success:(void(^)(PHAssetCollection *))completionSuccess
                  failure:(void(^)(NSError *))failure
{
    __block NSString *collectionId = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:ablumName];
        collectionId = request.placeholderForCreatedAssetCollection.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            completionSuccess([[PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil] firstObject]);
        } else {
            failure(error);
        }
    }];
}

// 创建一个相册 (同步)
+ (PHAssetCollection *)sync_createNewAlbumCalled:(NSString *)albumName
{
    // 获得软件名字
    //NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    
    // 抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                                               subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                                               options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:albumName]) {
            NSLog(@"相册存在：%@",albumName);
            return collection;
        }
    }
    
    // 创建一个【自定义相册】
    NSError *error = nil;
    __block NSString *collectionId = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
        collectionId = request.placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (!error) {
        NSLog(@"相册创建成功：%@",albumName);
        return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
    }else{
        NSLog(@"相册创建失败 error：%@",error);
        return nil;
    }
}

/**
 *  保存一个UIImage对象到某一个相册里，若没有该相册会先自动创建
 */
+ (void)saveImage:(UIImage *)image
          ToAlbum:(NSString *)albumName
       completion:(void(^)(PHAsset *imageAsset))completion
          failure:(void(^)(NSError *error))failure
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    PHAssetCollection *collection = [self sync_createNewAlbumCalled:albumName];
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        assetID = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
        PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
        //[request insertAssets:asset atIndexes:[NSIndexSet indexSetWithIndex:0]];
        [request addAssets:@[asset]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"Finished updating asset. %@", (success ? @"Success." : error));
        if (success) {
            PHAsset *imageAsset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
            completion(imageAsset);
        }else{
            failure(error);
        }
    }];
}

/**
 *  通过一个图片的本地url保存该图片到某一个相册里
 */
+ (void)saveImageWithImageUrl:(NSURL *)imageUrl
                      ToAlbum:(NSString *)albumName
                   completion:(void(^)(PHAsset *imageAsset))completion
                      failure:(void(^)(NSError *error))failure
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    PHAssetCollection *collection = [self sync_createNewAlbumCalled:albumName];
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        assetID = [PHAssetCreationRequest creationRequestForAssetFromImageAtFileURL:imageUrl].placeholderForCreatedAsset.localIdentifier;
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
        PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
        //[request insertAssets:asset atIndexes:[NSIndexSet indexSetWithIndex:0]];
        [request addAssets:@[asset]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"Finished updating asset. %@", (success ? @"Success." : error));
        if (success) {
            PHAsset *imageAsset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
            completion(imageAsset);
        }else{
            failure(error);
        }
    }];
}

/**
 *  保存一个imageData对象到某一个相册里
 */
+ (void)saveImageData:(NSData *)imageData
              ToAlbum:(NSString *)albumName
           completion:(void(^)(PHAsset *imageAsset))completion
              failure:(void(^)(NSError *error))failure
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    PHAssetCollection *collection = [self sync_createNewAlbumCalled:albumName];
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCreationRequest *creationRequest = [PHAssetCreationRequest creationRequestForAsset];
        [creationRequest addResourceWithType:PHAssetResourceTypePhoto data:imageData options:nil];
        assetID = creationRequest.placeholderForCreatedAsset.localIdentifier;
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
        PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
        //[request insertAssets:asset atIndexes:[NSIndexSet indexSetWithIndex:0]];
        [request addAssets:@[asset]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"Finished updating asset. %@", (success ? @"Success." : error));
        if (success) {
            PHAsset *imageAsset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
            completion(imageAsset);
        }else{
            failure(error);
        }
    }];
}

/**
 *  保存一个视频对象到某一个相册里 (异步)
 */
+ (void)async_saveVideoWithUrl:(NSURL *)videoUrl
                       ToAlbum:(NSString *)albumName
                    completion:(void(^)(NSURL *videoUrl))completion
                       failure:(void(^)(NSError *error))failure
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    PHAssetCollection *collection = [self sync_createNewAlbumCalled:albumName];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        assetID = [PHAssetCreationRequest creationRequestForAssetFromVideoAtFileURL:videoUrl].placeholderForCreatedAsset.localIdentifier;
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
        PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
        //[request insertAssets:asset atIndexes:[NSIndexSet indexSetWithIndex:0]];
        [request addAssets:@[asset]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"Finished updating asset. %@", (success ? @"Success." : error));
        if (success) {
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
            [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                completion([(AVURLAsset *)asset URL]);
            }];
        }else{
            failure(error);
        }
    }];
}

/**
 *  获取photos app创建的相册里所有图片
 */
+ (void)loadImagesFromAlbum:(NSString *)albumName completion:(void (^)(NSMutableArray *images, NSError *error))completion
{
    if (![YJPhotoTool canAccessPhotoAlbum]) {
        
    }else{
        PHFetchResult<PHAssetCollection *>*collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                                                       subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        PHFetchOptions *fetchOptions = [PHFetchOptions new];
        fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        
        [collectionResult enumerateObjectsUsingBlock:^(PHAssetCollection * collection, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([collection.localizedTitle isEqualToString:albumName])
            {
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:fetchOptions];
                __block NSMutableArray *imagesArr = [[NSMutableArray alloc] init];
                [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    PHAsset *asset = (PHAsset *)obj;
                    PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
                    option.networkAccessAllowed = YES;
                    [[PHImageManager defaultManager] requestImageForAsset:asset
                                                               targetSize:PHImageManagerMaximumSize
                                                              contentMode:PHImageContentModeAspectFit
                                                                  options:option
                                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                                BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
                                                                if (downloadFinined && result) {
                                                                    [imagesArr addObject:result];
                                                                    if (imagesArr.count == fetchResult.count) {
                                                                        completion(imagesArr,nil);
                                                                    }
                                                                }
                                                            }];
                }];
                *stop = YES;
                return;
            }
        }];
    }
}

/**
 *  获取photos app创建的相册里所有
 */
+ (void)loadMediasFromAlbum:(NSString *)albumName completion:(void (^)(PHFetchResult<PHAsset *>*result))completion
{
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.predicate = [NSPredicate predicateWithFormat:@"title = %@", albumName];
    PHFetchResult *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                               subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                               options:option];
    PHAssetCollection *collection = [collectionResult firstObject];
    PHFetchOptions *fetchOptions= [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult<PHAsset *>*result = [PHAsset fetchAssetsInAssetCollection:collection options:fetchOptions];
    if (completion) {
        completion(result);
    }
}

/**
 *  删除
 */
+ (void)deleteFromAlbum:(NSString *)albumName
                withUrl:(NSURL *)url
             completion:(void(^)(void))completion
                failure:(void(^)(NSError *error))failure
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:url];
        PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:array options:nil];
        NSArray *phas = [result objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [result count])]];
        [PHAssetChangeRequest deleteAssets:phas];
    } completionHandler:^(BOOL success, NSError *error) {
        NSLog(@"Finished delete asset. %@", (success ? @"Success." : error));
        if (success) {
            completion();
        } else {
            failure(error);
        }
    }];
}

//  判断授权状态
+ (BOOL)canAccessPhotoAlbum
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        // User has not yet made a choice with regards to this application
        NSLog(@"用户还没有关于这个应用程序做出了选择");
        return YES;
    }else if (status == PHAuthorizationStatusRestricted){
        // This application is not authorized to access photo data.
        // The user cannot change this application’s status, possibly due to active restrictions
        //   such as parental controls being in place.
        NSLog(@"家长控制,不允许访问");
        return NO;
    }else if (status == PHAuthorizationStatusDenied){
        // User has explicitly denied this application access to photos data.
        NSLog(@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关");
        return NO;
    }else if (status == PHAuthorizationStatusAuthorized){
        // User has authorized this application to access photos data.
        NSLog(@"用户允许当前应用访问相册");
        return YES;
    }
    
    return NO;
}

/***************************************** fetch **********************************************/
+ (PHAsset *)fetchAssetFrom:(NSString *)assetId{
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
}

+ (void)fetchVideoUrlAndAVAssetFrom:(NSString *)assetId completion:(void (^)(AVAsset *avasset, NSURL *url))completion
{
    __block NSURL *url = nil;
    [[PHImageManager defaultManager] requestAVAssetForVideo:[PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        url = [(AVURLAsset *)asset URL];
        !completion ? : completion(asset, url);
    }];
}

+ (NSURL *)fetchVideoUrlFrom:(NSString *)assetId{
    __block NSURL *url = nil;
    PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
    [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        url = [(AVURLAsset *)asset URL];
    }];
    return url;
}

+ (AVAsset *)fetchVideoAVAssetFrom:(NSString *)assetId{
    __block AVAsset *avasset = nil;
    [[PHImageManager defaultManager] requestAVAssetForVideo:[PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        avasset = asset;
    }];
    return avasset;
}

+ (NSString *)fetchFileNameFrom:(PHAsset *)asset
{
    NSArray *resources = [PHAssetResource assetResourcesForAsset:asset];
    return ((PHAssetResource *)resources[0]).originalFilename;
}

+ (void)fetchUIImageFrom:(PHAsset *)asset completion:(void (^)(UIImage *image))completion
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize
                                              contentMode:PHImageContentModeDefault
                                                  options:options
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    if (completion) {
                                                        completion(result);
                                                    }
                                                });
                                            }];
}

+ (void)fetchUIImageFrom:(PHAsset *)asset
        withDeliveryMode:(PHImageRequestOptionsDeliveryMode)mode
              completion:(void (^)(UIImage *image))completion
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = mode;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize
                                              contentMode:PHImageContentModeDefault
                                                  options:options
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    if (completion) {
                                                        completion(result);
                                                    }
                                                });
                                            }];
}

+ (void)fetchAVPlayerItemFrom:(PHAsset *)asset completion:(void (^)(AVPlayerItem *playerItem))completion
{
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    [[PHImageManager defaultManager] requestPlayerItemForVideo:asset options:options resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(playerItem);
            }
        });
    }];
}

+ (void)fetchFileURLFrom:(PHAsset *)asset completion:(void (^)(NSURL *fileURL, AVAsset *avasset))completion
{
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.networkAccessAllowed = YES;
    
//    [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
//        if ([asset isKindOfClass:[AVURLAsset class]] == YES) {
//            AVURLAsset *avurlasset = (AVURLAsset *)asset;
//            if (completion) {
//                completion(avurlasset.URL, asset);
//            }
//        }
//    }];
    
    [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        NSString *url = [[[info objectForKey:@"PHImageFileSandboxExtensionTokenKey"] componentsSeparatedByString:@";"] lastObject];
        completion(url, asset);
    }];
}

@end
