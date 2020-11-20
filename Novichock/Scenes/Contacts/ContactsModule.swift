//
//  ContactsModule.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

class ContactsModule {
	
	static func build() -> ContactsView {
		let view = ContactsView()
		let interactor = ContactsInteractor()
		let presenter = ContactsPresenter()
		view.interactor = interactor
		interactor.presenter = presenter
		presenter.view = view
		return view
	}
}
