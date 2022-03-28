//
//  ContactTableViewCell.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 27/03/22.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

	// MARK: Views
	private var photoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.clipsToBounds = true
		return imageView
	}()

	private let personNameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		label.textColor = .label
		return label
	}()

	private let statusLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 2
		label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		label.textColor = .systemGray
		return label
	}()

	private lazy var nameAndStatusStackView: UIStackView = {
	  let stackView = UIStackView(arrangedSubviews: [personNameLabel, statusLabel])
	  stackView.axis = .vertical
	  stackView.alignment = .leading
	  stackView.distribution = .fill
	  stackView.spacing = 0
	  return stackView
	}()

	func setupCellModel(_ model: Profile) {
		self.photoImageView.loadImage(from: model.picture)
		self.personNameLabel.text = model.name
		self.statusLabel.text = model.status
	}

	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		setupViewCode()
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		self.photoImageView.image = nil
		self.personNameLabel.text = nil
		self.statusLabel.text = nil
	}
}

// MARK: Setup View Code
extension ContactTableViewCell: ViewCode {
	func buildHierarchy() {
		self.contentView.addSubviews(
			photoImageView,
			nameAndStatusStackView
		)
		self.contentView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			photoImageView.heightAnchor.constraint(equalToConstant: 60),
			photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor),
			photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

			nameAndStatusStackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
			nameAndStatusStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			nameAndStatusStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			nameAndStatusStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
		])

		let height = nameAndStatusStackView.heightAnchor.constraint(equalToConstant: 65)
		height.priority = .defaultHigh
		height.isActive = true
	}

	func configureViews() {
		self.photoImageView.layer.cornerRadius = 30
	}

}
