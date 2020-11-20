//
//  ContactDetailsView.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

import UIKit

protocol ContactDetailsDisplayLogic: class {
	func displayContactDetails(viewModel: ContactDetailsModel.ViewModel)
}

class ContactDetailsView: UIViewController {
	
	// MARK: - Public vars
	
	var interactor: ContactDetailsBusinessLogic?
	
	// MARK: - Private vars
	
	private var contact: ContactsModel.Contact?
	
	private lazy var avatarImageView: UIImageView = {
		let avatarView = UIImageView()
		avatarView.translatesAutoresizingMaskIntoConstraints = false
		avatarView.contentMode = .scaleAspectFit
		return avatarView
	}()
	
	private lazy var nameLabel: UILabel = {
		let nameLabel = UILabel()
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
		nameLabel.textColor = .black
		return nameLabel
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		tableView.alwaysBounceVertical = true
		tableView.register(ContactDetailsCell.self, forCellReuseIdentifier: ContactDetailsCell.className)
		tableView.dataSource = self
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
		
		let avatarImageViewWidth: CGFloat = 100
		view.addSubview(avatarImageView)
		avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
		avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
		avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageViewWidth).isActive = true
		avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageViewWidth).isActive = true
		avatarImageView.layer.cornerRadius = avatarImageViewWidth / 2
		
		let nameLabelHorizontalSpace: CGFloat = 20
		view.addSubview(nameLabel)
		nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
		nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: nameLabelHorizontalSpace).isActive = true
		nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -nameLabelHorizontalSpace).isActive = true
		
		let offset: CGFloat = 20
		view.addSubview(tableView)
		tableView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 30).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -offset).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: offset).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -offset).isActive = true
	}
}

// MARK: - ContactDetailsDisplayLogic
extension ContactDetailsView: ContactDetailsDisplayLogic {
	
	func displayContactDetails(viewModel: ContactDetailsModel.ViewModel) {
		contact = viewModel.contact
		
		DispatchQueue.main.async {
			self.avatarImageView.image = self.contact?.avatar
			self.nameLabel.text = self.contact?.name
			self.tableView.reloadData()
		}
	}
}

// MARK: - UITableViewDataSource
extension ContactDetailsView: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return contact?.phones.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailsCell.className) as? ContactDetailsCell,
			  let phones = contact?.phones
		else { return UITableViewCell() }
		
		cell.fill(with: phones[indexPath.row])
		return cell
	}
}
