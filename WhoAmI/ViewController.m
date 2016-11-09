//
//  ViewController.m
//  WhoAmI
//
//  Created by 凌空 on 2016/11/7.
//  Copyright © 2016年 amoyio. All rights reserved.
//

#import "ViewController.h"
#import "SpriteManager.h"
@interface ViewController ()
@property(nonatomic,assign) NSUInteger difficultDegree;
@property (weak, nonatomic) IBOutlet UIImageView *topImgView;
@property (weak, nonatomic) IBOutlet UIImageView *midImgView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImgView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (weak, nonatomic) IBOutlet UIButton *midBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@property(nonatomic,assign) NSInteger topIndex;
@property(nonatomic,assign) NSInteger midIndex;
@property(nonatomic,assign) NSInteger bottomIndex;
@property(nonatomic,copy) NSArray *imgList;
@end

@implementation ViewController

-(void)loadView{
    [super loadView];
    self.difficultDegree = 8;
}

-(void)reloadGame{
    self.imgList = [[SpriteManager shareManager] generateListInCount:self.difficultDegree];
    self.topIndex = arc4random() % self.difficultDegree;
    self.midIndex = arc4random() % self.difficultDegree;
    self.bottomIndex = arc4random() % self.difficultDegree;
    NSString *topImgName = self.imgList[self.topIndex][0];
    NSString *midImgName = self.imgList[self.midIndex][0];
    NSString *bottomImgName = self.imgList[self.bottomIndex][0];
    
    self.topImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%03ld",[topImgName integerValue]]];
    self.midImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%03ld",[midImgName integerValue]]];
    self.bottomImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%03ld",[bottomImgName integerValue]]];
    self.resultLabel.text = @"???";
    [self.topBtn setBackgroundImage:[UIImage imageNamed:@"frame"] forState:UIControlStateNormal];
    [self.midBtn setBackgroundImage:[UIImage imageNamed:@"frame"] forState:UIControlStateNormal];
    [self.bottomBtn setBackgroundImage:[UIImage imageNamed:@"frame"] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadGame];
}

- (IBAction)changeTopImg:(UIButton *)sender {
    self.topIndex = (self.topIndex + 1) % self.difficultDegree;
    NSString *topImgName = self.imgList[self.topIndex][0];
    self.topImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%03ld",[topImgName integerValue]]];
    if ([self checkSuccess]) {
        [self successStatusAction];
    }
}
- (IBAction)changeMidImg:(UIButton *)sender {
    self.midIndex = (self.midIndex + 3) % self.difficultDegree;
    NSString *midImgName = self.imgList[self.midIndex][0];
    self.midImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%03ld",[midImgName integerValue]]];
    if ([self checkSuccess]) {
        [self successStatusAction];
    }
}
- (IBAction)changeBottomImg:(UIButton *)sender {
    self.bottomIndex = (self.bottomIndex + 5) % self.difficultDegree;
    NSString *bottomImgName = self.imgList[self.bottomIndex][0];
    self.bottomImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%03ld",[bottomImgName integerValue]]];
    if ([self checkSuccess]) {
        [self successStatusAction];
    }else{
        [self failStatusAction];
    }
}

- (BOOL)checkSuccess{
    if (self.topIndex == self.midIndex) {
        if (self.midIndex == self.bottomIndex) {
            return YES;
        }
    }
    return NO;
}

- (void)successStatusAction{
    [self.topBtn setBackgroundImage:[UIImage imageNamed:@"frame_success"] forState:UIControlStateNormal];
    [self.midBtn setBackgroundImage:[UIImage imageNamed:@"frame_success"] forState:UIControlStateNormal];
    [self.bottomBtn setBackgroundImage:[UIImage imageNamed:@"frame_success"] forState:UIControlStateNormal];
    self.resultLabel.text = self.imgList[self.topIndex][1][@"name"];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Awesome!" message:@"You find it's name ! Play once more ?" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof (self) weakSelf = self;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.difficultDegree += 3;
        [weakSelf reloadGame];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:confirmAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)failStatusAction{
    self.resultLabel.text = @"???";
}

@end
