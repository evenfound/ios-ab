//
//  AppDelegate.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		if #available(iOS 13, *) {
		} else {
			DispatchQueue.main.async {
				UIApplication.shared.windows.first?.rootViewController = AppRouter.shared.navigationController
				UIApplication.shared.windows.first?.makeKeyAndVisible()
			}
		}
		
		return true
	}
	
	// MARK: UISceneSession Lifecycle
	
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}
}
