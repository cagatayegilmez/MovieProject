//
//  AppDelegate.swift
//  Mobillium Project
//
//  Created by Çağatay Eğilmez on 14.05.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var serviceLayer = ServiceLayer()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if #available(iOS 13.0, *) {
            // SceneDelegate will set up the window/rootVC
        } else {
            redirectHome()
        }
        return true
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func redirectHome() {
        let home: UIViewController = HomeBuilder.build(apiClient: self.serviceLayer)
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = NavigationController(rootViewController: home)
        window.makeKeyAndVisible()
    }
}

public enum Environment {
    
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()

  static let rootURL: URL = {
    guard let rootURLstring = Environment.infoDictionary["API_URL"] as? String else {
      fatalError("Root URL not set in plist for this environment")
    }
    guard let url = URL(string: rootURLstring) else {
      fatalError("Root URL is invalid")
    }
    return url
  }()

  static let apiKey: String = {
    guard let apiKey = Environment.infoDictionary["API_KEY"] as? String else {
      fatalError("API Key not set in plist for this environment")
    }
    return apiKey
  }()
}
