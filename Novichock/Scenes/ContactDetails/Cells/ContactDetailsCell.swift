//
//  ContactDetailsCell.swift
//  Novichock
//
//  Created by umb on 20.11.2020.
//

import UIKit

class ContactDetailsCell: UITableViewCell {
	
	// MARK: - Private vars
	
	private lazy var customContentView: UIView = {
		let customContentView = UIView()
		customContentView.translatesAutoresizingMaskIntoConstraints = false
		customContentView.backgroundColor = AppColor.deselectedCellColor
		return customContentView
	}()
	
	private lazy var phoneTyppeLabel: UILabel = {
		let phoneTyppeLabel = UILabel()
		phoneTyppeLabel.translatesAutoresizingMaskIntoConstraints = false
		phoneTyppeLabel.font = .systemFont(ofSize: 14, weight: .medium)
		phoneTyppeLabel.textColor = .black
		return phoneTyppeLabel
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
		
		phoneTyppeLabel.text = nil
		phoneLabel.text = nil
	}
	
	// MARK: - Init
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public methods
	
	func fill(with phone: ContactsModel.Phone) {
		phoneTyppeLabel.text = phone.type
		phoneLabel.text = phone.number
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
		
		let space: CGFloat = 16
		customContentView.addSubview(phoneTyppeLabel)
		phoneTyppeLabel.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: space).isActive = true
		phoneTyppeLabel.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -space).isActive = true
		phoneTyppeLabel.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: space).isActive = true
		phoneTyppeLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
		
		customContentView.addSubview(phoneLabel)
		phoneLabel.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: space).isActive = true
		phoneLabel.leadingAnchor.constraint(equalTo: phoneTyppeLabel.trailingAnchor, constant: space).isActive = true
		phoneLabel.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -space).isActive = true
	}
}
