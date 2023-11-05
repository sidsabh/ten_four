//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<agora_rtc_engine/AgoraRtcNgPlugin.h>)
#import <agora_rtc_engine/AgoraRtcNgPlugin.h>
#else
@import agora_rtc_engine;
#endif

#if __has_include(<auth0_flutter/Auth0FlutterPlugin.h>)
#import <auth0_flutter/Auth0FlutterPlugin.h>
#else
@import auth0_flutter;
#endif

#if __has_include(<iris_method_channel/IrisMethodChannelPlugin.h>)
#import <iris_method_channel/IrisMethodChannelPlugin.h>
#else
@import iris_method_channel;
#endif

#if __has_include(<permission_handler_apple/PermissionHandlerPlugin.h>)
#import <permission_handler_apple/PermissionHandlerPlugin.h>
#else
@import permission_handler_apple;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AgoraRtcNgPlugin registerWithRegistrar:[registry registrarForPlugin:@"AgoraRtcNgPlugin"]];
  [Auth0FlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"Auth0FlutterPlugin"]];
  [IrisMethodChannelPlugin registerWithRegistrar:[registry registrarForPlugin:@"IrisMethodChannelPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
}

@end
