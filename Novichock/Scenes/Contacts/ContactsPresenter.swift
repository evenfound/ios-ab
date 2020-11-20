//
//  ContactsPresenter.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

protocol ContactsPresentationLogic: class {
	func presentContacts(response: ContactsModel.Response)
}

class ContactsPresenter {
	
	// MARK: - Public vars
	
	weak var view: ContactsDisplayLogic?
}

// MARK: - ContactsPresentationLogic
extension ContactsPresenter: ContactsPresentationLogic {
	
	func presentContacts(response: ContactsModel.Response) {
		let viewModel = ContactsModel.ViewModel(contacts: response.contacts)
		view?.displayContacts(viewModel: viewModel)
	}
}
