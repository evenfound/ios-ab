//
//  ContactDetailsModel.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

import UIKit

enum ContactDetailsModel {
	
	struct Response {
		let contact: ContactsModel.Contact
	}
	
	struct ViewModel {
		let contact: ContactsModel.Contact
	}
}
