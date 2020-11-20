//
//  SceneDelegate.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = AppRouter.shared.navigationController
		window?.makeKeyAndVisible()
	}
}
