//
//  VideoPlayerCommand.h
//  PhoneGapVideoPlayerPlugin25
//
//  Created by Ramon Lorico on 3/14/13.
//
//

#import <Cordova/CDV.h>

@interface VideoPlayerCommand : CDVPlugin

- (void)show:(CDVInvokedUrlCommand*)command;
- (void)MovieDidFinish:(NSNotification *)notification;

@end
