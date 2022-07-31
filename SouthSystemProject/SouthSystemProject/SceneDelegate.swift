//
//  SceneDelegate.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewController = MainViewController()
        let navVC = UINavigationController(rootViewController: viewController)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
    }

}
