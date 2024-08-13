import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let dataChannel = FlutterMethodChannel(name: "com.vulh.countdown/eventData",
                                           binaryMessenger: controller.binaryMessenger)

    dataChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "sendEventData" {
        if let arguments = call.arguments as? [String: Any],
           let events = arguments["events"] as? [[String: String]] {
          let userDefaults = UserDefaults(suiteName: "group.com.vulh")
          userDefaults?.set(events, forKey: "eventData")
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Data format is 111", details: nil))
          result("Event data saved")
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Data format is incorrect", details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
