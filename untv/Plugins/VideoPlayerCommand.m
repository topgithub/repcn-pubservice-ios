//
//  VideoPlayerCommand.m
//  PhoneGapVideoPlayerPlugin25
//
//  Created by Ramon Lorico on 3/14/13.
//
//

#import "VideoPlayerCommand.h"
#import "MovieViewController.h"
#import <Cordova/CDV.h>

@interface VideoPlayerCommand()
{
    MovieViewController *player;
}

@end


@implementation VideoPlayerCommand


- (void)show:(CDVInvokedUrlCommand*)command //(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    NSString *movie = [command.arguments objectAtIndex:0];
    NSString *orient = [command.arguments objectAtIndex:1];
    NSRange range = [movie rangeOfString:@"http"];
    NSURL *fileURL = [NSURL URLWithString:movie];
    
    if(range.length > 0) {
        if ([@"YES" isEqualToString:orient]) {
            player = [[MovieViewController alloc] initWithContentURL:fileURL andOrientation:YES];
        } else {
            player = [[MovieViewController alloc] initWithContentURL:fileURL andOrientation:NO];
        }
        
    } else {
        NSArray *fileNameArr = [movie componentsSeparatedByString:@"."];
        NSString *prefix = [fileNameArr objectAtIndex:0];
        NSString *suffix = [fileNameArr objectAtIndex:1];
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:prefix ofType:suffix];
        NSURL *fileURL = [NSURL fileURLWithPath:soundFilePath];
        if ([@"YES" isEqualToString:orient]) {
            player = [[MovieViewController alloc] initWithContentURL:fileURL andOrientation:YES];
        } else {
            player = [[MovieViewController alloc] initWithContentURL:fileURL andOrientation:NO];
        }
    }
    if (player) {
//        PhoneGapViewController *cont = (PhoneGapViewController *) [super appViewController];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MovieDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        [self.viewController presentMoviePlayerViewControllerAnimated:player];
    }
}


- (void)MovieDidFinish:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
//    [self writeJavascript:@"videoplayerCallBack('finish');"];
}

@end