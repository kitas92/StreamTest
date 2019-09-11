//
//  StreamingSingletone.m
//  test
//
//  Created by iDeveloper on 9/11/19.
//  Copyright © 2019 AlexSytnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StreamingSingleton.h"

static StreamingSingleton *sharedInstance = nil;
@interface StreamingSingleton (){
    NSString * urlString;
}
@end
@implementation StreamingSingleton

+ (StreamingSingleton*) sharedInstance {
    static dispatch_once_t _singletonPredicate;
    static StreamingSingleton *_singleton = nil;
    
    dispatch_once(&_singletonPredicate, ^{
        _singleton = [[super allocWithZone:nil] init];
    });
    
    return _singleton;
}

+ (id) allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

-(void)playStreamWith:(NSString *)streamUrlString {
    urlString = streamUrlString;
    [self playStream];
}

-(void)playStream{
    NSURL *urlStream;
    urlStream = [[NSURL alloc] initWithString:urlString];
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:urlStream options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:avAsset];
    _audioPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    _audioPlayer = [AVPlayer playerWithURL:urlStream];
    if(!_audioPlayer.error){
        [_audioPlayer play];
    }
}

-(void)stopStream{
    [_audioPlayer pause];
}

@end
