//
//  ContactDetailsPresenter.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

protocol ContactDetailsPresentationLogic: class {
	func presentContactDetails(response: ContactDetailsModel.Response)
}

class ContactDetailsPresenter {
	
	// MARK: - Public vars
	
	weak var view: ContactDetailsDisplayLogic?
}

// MARK: - ContactDetailsPresentationLogic
extension ContactDetailsPresenter: ContactDetailsPresentationLogic {
	
	func presentContactDetails(response: ContactDetailsModel.Response) {
		let viewModel = ContactDetailsModel.ViewModel(contact: response.contact)
		view?.displayContactDetails(viewModel: viewModel)
	}
}
