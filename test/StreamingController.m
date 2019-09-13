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
    [self setupNotifications];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configure];
}

-(void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:[ NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self updateAnimation: note];
        NSLog(@"didEnterBackground");
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:[ NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self updateAnimation: note];
        NSLog(@"willEnterForeground");
    }];
}

-(void)updateAnimation:(NSNotification*)notification{
    if (notification.name == UIApplicationDidEnterBackgroundNotification){
        [self.imageView stopAnimating];
    } else if (notification.name == UIApplicationWillEnterForegroundNotification) {
        [self.imageView startAnimating];
        [self startAnimateBackground];
    }
}

-(void)configure {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [[StreamingSingleton sharedInstance] playStreamWith:streamURLString];
    [self startAnimateBackground];
}

-(void)startAnimateBackground {
    self.imageView.transform = CGAffineTransformIdentity;
    [UIImageView animateWithDuration:5 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        CGAffineTransform scale = CGAffineTransformMakeScale(scaleRate, scaleRate);
        self.imageView.transform = scale;
    } completion:^(BOOL finished) {
        NSLog(@"completion");
    }];
}

- (IBAction)didTapClose:(id)sender {
    [[StreamingSingleton sharedInstance] stopStream];
    [self.navigationController popViewControllerAnimated: YES];
}
@end
