//
//  ContactCell.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

import UIKit

class ContactCell: UITableViewCell {
	
	// MARK: - Private vars
	
	private lazy var customContentView: UIView = {
		let customContentView = UIView()
		customContentView.translatesAutoresizingMaskIntoConstraints = false
		customContentView.backgroundColor = AppColor.deselectedCellColor
		return customContentView
	}()
	
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
	
	private lazy var phoneLabel: UILabel = {
		let phoneLabel = UILabel()
		phoneLabel.translatesAutoresizingMaskIntoConstraints = false
		phoneLabel.font = .systemFont(ofSize: 14)
		phoneLabel.textColor = .black
		return phoneLabel
	}()
	
	// MARK: - Overrides
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		avatarImageView.image = UIImage()
		nameLabel.text = nil
		phoneLabel.text = nil
		
		setBackgroundColor(color: AppColor.deselectedCellColor)
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setLayout()
	}
	
	// MARK: - Init
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public methods
	
	func fill(with contact: ContactsModel.Contact) {
		avatarImageView.image = contact.avatar
		nameLabel.text = contact.name
		phoneLabel.text = contact.mainPhone
	}
	
	func setBackgroundColor(color: UIColor) {
		customContentView.backgroundColor = color
	}
	
	// MARK: - Private methods
	
	private func setLayout() {
		backgroundColor = .clear
		contentView.backgroundColor = .clear
		
		let customContentViewSpace: CGFloat = 2
		addSubview(customContentView)
		customContentView.topAnchor.constraint(equalTo: topAnchor, constant: customContentViewSpace).isActive = true
		customContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -customContentViewSpace).isActive = true
		customContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: customContentViewSpace).isActive = true
		customContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -customContentViewSpace).isActive = true
		
		let avatarImageViewWidth: CGFloat = 50
		let avatarImageViewVerticalSpace: CGFloat = 20
		customContentView.addSubview(avatarImageView)
		avatarImageView.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: avatarImageViewVerticalSpace).isActive = true
		avatarImageView.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -avatarImageViewVerticalSpace).isActive = true
		avatarImageView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 20).isActive = true
		avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageViewWidth).isActive = true
		avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageViewWidth).isActive = true
		avatarImageView.layer.cornerRadius = avatarImageViewWidth / 2
		
		let nameLabelHorizontalSpace: CGFloat = 20
		customContentView.addSubview(nameLabel)
		nameLabel.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 20).isActive = true
		nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: nameLabelHorizontalSpace).isActive = true
		nameLabel.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -nameLabelHorizontalSpace).isActive = true
		
		customContentView.addSubview(phoneLabel)
		phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
		phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 10).isActive = true
		phoneLabel.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -20).isActive = true
	}
}
