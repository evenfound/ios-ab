//
//  ContactDetailsModule.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

class ContactDetailsModule {
	
	static func build(contact: ContactsModel.Contact) -> ContactDetailsView {
		let view = ContactDetailsView()
		let interactor = ContactDetailsInteractor(contact: contact)
		let presenter = ContactDetailsPresenter()
		view.interactor = interactor
		interactor.presenter = presenter
		presenter.view = view
		return view
	}
}
