import UIKit
import Flutter
import GoogleMaps
import FirebaseCore
// import FirebaseAuth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()

      GMSServices.provideAPIKey("AIzaSyDnxkJSdycr1f2V4sdLiYZX0viov12A2CQ")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
