//
//  ContactDetailsInteractor.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

protocol ContactDetailsBusinessLogic: class {
	func fetchContacts()
}

class ContactDetailsInteractor {
	
	// MARK: - Public vars
	
	var presenter: ContactDetailsPresentationLogic?
	
	// MARK: - Private vars
	
	private let contact: ContactsModel.Contact
	
	// MARK: - Init
	
	init(contact: ContactsModel.Contact) {
		self.contact = contact
	}
}

// MARK: - ContactDetailsBusinessLogic
extension ContactDetailsInteractor: ContactDetailsBusinessLogic {
	
	func fetchContacts() {
		let response = ContactDetailsModel.Response(contact: contact)
		presenter?.presentContactDetails(response: response)
	}
}
