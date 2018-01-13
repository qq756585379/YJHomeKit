//
//  YJPhotoToolVC.m
//  Example
//
//  Created by 杨俊 on 2018/1/3.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "YJPhotoToolVC.h"
#import "YJExample.h"
#import <YJHomeKit/YJHomeKit.h>

@interface YJPhotoToolVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<YJExample *>*examples;
@end

@implementation YJPhotoToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self configData];
    [self.tableView reloadData];
}

-(void)configData{
    self.examples = @[[YJExample exampleWithTitle:@"saveImage" selector:@"saveImage"],
                      [YJExample exampleWithTitle:@"saveImageWithImageUrl" selector:@"saveImageWithImageUrl"],
                      [YJExample exampleWithTitle:@"saveImageData" selector:@"saveImageData"],
                      [YJExample exampleWithTitle:@"saveVideoWithUrl" selector:@"saveVideoWithUrl"],
                      [YJExample exampleWithTitle:@"loadImagesFromAlbum" selector:@"loadImagesFromAlbum"]
                      ];
    
}

-(void)saveImage{
    [YJPhotoTool saveImage:[UIImage imageNamed:@"猫猫.jpg"]
                   ToAlbum:@"新相册" completion:^(PHAsset *imageAsset) {
                       NSLog(@"%@",imageAsset);
                   } failure:^(NSError *error) {
                       
                   }];
}

-(void)saveImageWithImageUrl{
    [YJPhotoTool saveImageWithImageUrl:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"猫猫" ofType:@"jpg"]]
                               ToAlbum:@"ios9新相册" completion:^(PHAsset *imageAsset) {
                                   NSLog(@"%@",imageAsset);
                               } failure:^(NSError *error) {
                                   
                               }];
}

-(void)saveImageData{
    [YJPhotoTool saveImageData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"猫猫" ofType:@"jpg"]]
                       ToAlbum:@"ios9新相册1" completion:^(PHAsset *imageAsset){
                           NSLog(@"%@",imageAsset);
                       } failure:^(NSError *error) {
                           
                       }];
}

-(void)saveVideoWithUrl{
    [YJPhotoTool async_saveVideoWithUrl:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bug" ofType:@"mov"]]
                                ToAlbum:@"视频相册2"
                             completion:^(NSURL *videoUrl) {
                                 
                             } failure:^(NSError *error) {
                                 
                             }];
}

-(void)loadImagesFromAlbum{
    [YJPhotoTool loadImagesFromAlbum:@"新相册" completion:^(NSMutableArray *images, NSError *error) {
        NSLog(@"%@",images);
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJExample *example = self.examples[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJExampleCell" forIndexPath:indexPath];
    cell.textLabel.text = example.title;
    cell.textLabel.textColor = self.view.tintColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [cell.textLabel.textColor colorWithAlphaComponent:0.1f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YJExample *example = self.examples[indexPath.row];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:example.selector];
#pragma clang diagnostic pop
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
}

-(UITableView *)tableView{
    if (!_tableView){
        CGRect rect = CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_AREA_BOTTOM - NAV_BAR_HEIGHT);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YJExampleCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
