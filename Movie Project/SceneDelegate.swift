//
//  SceneDelegate.swift
//  Mobillium Project
//
//  Created by Çağatay Eğilmez on 2.01.2026.
//

import UIKit

@available(iOS 13.0, *)
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let serviceLayer = ServiceLayer()

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let home = HomeBuilder.build(apiClient: serviceLayer)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = NavigationController(rootViewController: home)
        window.makeKeyAndVisible()
        self.window = window
    }
}
