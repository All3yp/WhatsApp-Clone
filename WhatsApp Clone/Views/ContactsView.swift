//
//  ContactsView.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 27/03/22.
//

import UIKit

class ContactsView: UIView {

	// MARK: - Views
	lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero)
		tableView.backgroundColor = .clear
		return tableView
	}()

	// MARK: - View lifecycle
	init() {
		super.init(frame: .zero)
		setupViewCode()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

// MARK: - Setup View Code
extension ContactsView: ViewCode {
	func buildHierarchy() {
		self.addSubviews(tableView)
		self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}

	func configureViews() {
		self.backgroundColor = .systemBackground
	}

}
