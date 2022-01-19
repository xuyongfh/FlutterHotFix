import Flutter
import UIKit

public class SwiftFlutterHotFixCsxPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_hot_fix_csx", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterHotFixCsxPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let infoDictionary = NSBundle.mainBundle().infoDictionary
    switch call.messenger {
    case "getAppVersion":
      result(infoDictionary! ["CFBundleShortVersionString"])
      break
    case "Bsdiff_bsdiff":
      
    default:
      break
    }
  }
}
