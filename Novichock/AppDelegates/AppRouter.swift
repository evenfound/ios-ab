//
//  MainModule.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

import UIKit

class AppRouter {
	
	static let shared: AppRouter = AppRouter()
	
	let navigationController: UINavigationController = {
		let scene = ContactsModule.build()
		
		return UINavigationController(rootViewController: scene)
	}()
	
	func showContactDetails(contact: ContactsModel.Contact) {
		let scene = ContactDetailsModule.build(contact: contact)
		
		navigationController.pushViewController(scene, animated: true)
	}
	
	func showContactsAccessAlert(title: String? = nil, message: String) {
		
		DispatchQueue.main.async {
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			let okAction = UIAlertAction( title: "ОК", style: .default )
			
			let settingsAction = UIAlertAction(
				title: "Настройки",
				style: .default,
				handler: { _ in
					guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
					UIApplication.shared.open(settingsURL)
				})
			
			alert.addAction(okAction)
			alert.addAction(settingsAction)
			
			self.navigationController.viewControllers.last?.present(alert, animated: true)
		}
	}
}
