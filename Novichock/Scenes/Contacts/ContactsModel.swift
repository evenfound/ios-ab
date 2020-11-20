//
//  ContactsModel.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

import UIKit

enum ContactsModel {
	
	struct Phone {
		let type: String
		let number: String
	}
	
	struct Contact {
		let avatar: UIImage?
		let name: String
		let mainPhone: String
		let phones: [Phone]
	}
	
	struct Response {
		let contacts: [Contact]
	}
	
	struct ViewModel {
		let contacts: [Contact]
	}
}
