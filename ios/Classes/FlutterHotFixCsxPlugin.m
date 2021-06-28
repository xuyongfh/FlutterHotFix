#import "FlutterHotFixCsxPlugin.h"
#if __has_include(<flutter_hot_fix_csx/flutter_hot_fix_csx-Swift.h>)
#import <flutter_hot_fix_csx/flutter_hot_fix_csx-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_hot_fix_csx-Swift.h"
#endif

@implementation FlutterHotFixCsxPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterHotFixCsxPlugin registerWithRegistrar:registrar];
}
@end
