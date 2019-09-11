//
//  StreamingSingleton.h
//  test
//
//  Created by iDeveloper on 9/11/19.
//  Copyright © 2019 AlexSytnik. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface StreamingSingleton : NSObject<AVAudioPlayerDelegate>

+(StreamingSingleton *)sharedInstance;
@property AVPlayer *audioPlayer;
-(void)playStreamWith:(NSString *)streamUrlString;
-(void)stopStream;
@end
