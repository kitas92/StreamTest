//
//  StreamingController.m
//  test
//
//  Created by iDeveloper on 9/11/19.
//  Copyright © 2019 AlexSytnik. All rights reserved.
//

#import "StreamingController.h"
#import "StreamingSingleton.h"

NSString *streamURLString = @"http://cast.loungefm.com.ua/chillout128.m3u";
CGFloat scaleRate = 1.5;

@interface StreamingController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation StreamingController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configure];
}

-(void)configure {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [[StreamingSingleton sharedInstance] playStreamWith:streamURLString];
    [self startAnimateBackground];
}

-(void)startAnimateBackground {
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        CGAffineTransform scale = CGAffineTransformMakeScale(scaleRate, scaleRate);
        self.imageView.transform = scale;
    } completion:^(BOOL finished) {}];
}

- (IBAction)didTapClose:(id)sender {
    [[StreamingSingleton sharedInstance] stopStream];
    [self.navigationController popViewControllerAnimated: YES];
}
@end
