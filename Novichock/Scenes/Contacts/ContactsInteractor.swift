//
//  ContactsInteractor.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

import UIKit
import Contacts

protocol ContactsBusinessLogic: class {
	func fetchContacts()
	func showContact(contact: ContactsModel.Contact)
}

class ContactsInteractor {
	
	// MARK: - Public vars
	
	var presenter: ContactsPresentationLogic?
	
	// MARK: - Private methods
	
	private func requestForAccess(completion: @escaping (Bool) -> Void) {
		let status = CNContactStore.authorizationStatus(for: .contacts)
		
		switch status {
		case .authorized:
			completion(true)
			
		case .denied:
			AppRouter.shared.showContactsAccessAlert(
				title: "Доступ к контактам запрещен",
				message: "Для работы приложения необходим доступ к контактам.\nЗайдите в настройки и разрешите доступ.")
			
			completion(false)
			
		case .notDetermined:
			CNContactStore().requestAccess(for: .contacts, completionHandler: { granted, error in
				if let _ = error {
					AppRouter.shared.showContactsAccessAlert(
						title: "Нет доступа к контактам",
						message: "Для работы приложения необходим доступ к контактам.\nЗайдите в настройки и разрешите доступ.")
				}
				
				completion(granted)
			})
		default:
			AppRouter.shared.showContactsAccessAlert(
				title: "Нет доступа к контактам",
				message: "Для работы приложения необходим доступ к контактам.\nЗайдите в настройки и проверьте доступ.")
			
			completion(false)
		}
	}
	
	private func getContacts() -> [ContactsModel.Contact] {
		var contacts = [ContactsModel.Contact]()
		
		guard let keysToFetch = [
				CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
				CNContactPhoneNumbersKey,
				CNContactThumbnailImageDataKey] as? [CNKeyDescriptor] else {
			
			AppRouter.shared.showContactsAccessAlert(message: "Ошибка при получении контактных данных из адресной книги.")
			
			return contacts
		}
		
		let contactStore = CNContactStore()
		let request = CNContactFetchRequest(keysToFetch: keysToFetch)
		
		do {
			try contactStore.enumerateContacts(with: request) { cnContact, stop in
				var avatar = UIImage(named: "noImage")
				if let imageData = cnContact.thumbnailImageData {
					avatar = UIImage(data: imageData)
				}
				
				let name = "\(cnContact.familyName) \(cnContact.givenName)"
				let mainPhone = cnContact.phoneNumbers.first(where: { $0.label == CNLabelPhoneNumberMain })?.value.stringValue ?? ""
				
				let phones = cnContact.phoneNumbers.map { ContactsModel.Phone(
					type: CNLabeledValue<NSString>.localizedString(forLabel: $0.label ?? ""),
					number: $0.value.stringValue) }
				
				let contact = ContactsModel.Contact(avatar: avatar, name: name, mainPhone: mainPhone, phones: phones)
				contacts.append(contact)
			}
		} catch {
			AppRouter.shared.showContactsAccessAlert(message: "Ошибка при получении контактных данных из адресной книги.\n\(error.localizedDescription)")
		}
		
		return contacts
	}
}

// MARK: - ContactsBusinessLogic
extension ContactsInteractor: ContactsBusinessLogic {
	
	func fetchContacts() {
		requestForAccess { [weak self] isSuccess in
			guard let self = self, isSuccess else { return }
			
			let response = ContactsModel.Response(contacts: self.getContacts())
			self.presenter?.presentContacts(response: response)
		}
	}
	
	func showContact(contact: ContactsModel.Contact) {
		AppRouter.shared.showContactDetails(contact: contact)
	}
}
