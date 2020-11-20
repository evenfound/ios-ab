//
//  ContactsView.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

import UIKit

protocol ContactsDisplayLogic: class {
	func displayContacts(viewModel: ContactsModel.ViewModel)
}

class ContactsView: UIViewController {
	
	// MARK: - Public vars
	
	var interactor: ContactsBusinessLogic?
	
	// MARK: - Private vars
	
	private var contacts = [ContactsModel.Contact]()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		tableView.alwaysBounceVertical = true
		tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.className)
		tableView.dataSource = self
		tableView.delegate = self
		return tableView
	}()
	
	// MARK: - Overrides
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setLayout()
		
		interactor?.fetchContacts()
	}
	
	// MARK: - Private methods
	
	private func setLayout() {
		view.backgroundColor = AppColor.viewBackgroundColor
		
		let offset: CGFloat = 16
		view.addSubview(tableView)
		tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -offset).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: offset).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -offset).isActive = true
	}
}

// MARK: - ContactsDisplayLogic
extension ContactsView: ContactsDisplayLogic {
	
	func displayContacts(viewModel: ContactsModel.ViewModel) {
		self.contacts = viewModel.contacts
		
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}

// MARK: - UITableViewDataSource
extension ContactsView: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return contacts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.className) as? ContactCell
		else { return UITableViewCell() }
		
		cell.fill(with: contacts[indexPath.row])
		return cell
	}
}

// MARK: - UITableViewDelegate
extension ContactsView: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) as? ContactCell else { return }
		cell.setBackgroundColor(color: AppColor.selectedCellColor)
		
		interactor?.showContact(contact: contacts[indexPath.row])
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) as? ContactCell else { return }
		cell.setBackgroundColor(color: AppColor.deselectedCellColor)
	}
}
