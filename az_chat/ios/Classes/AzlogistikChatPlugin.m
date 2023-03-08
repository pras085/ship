#import "AzlogistikChatPlugin.h"
#if __has_include(<azlogistik_chat/azlogistik_chat-Swift.h>)
#import <azlogistik_chat/azlogistik_chat-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "azlogistik_chat-Swift.h"
#endif

@implementation AzlogistikChatPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAzlogistikChatPlugin registerWithRegistrar:registrar];
}
@end
