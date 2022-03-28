//
//  ChatTableViewCell.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 26/03/22.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

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

	private let messageLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 2
		label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		label.textColor = .systemGray
		return label
	}()

	private lazy var nameAndMsgStackView: UIStackView = {
	  let stackView = UIStackView(arrangedSubviews: [personNameLabel, messageLabel])
	  stackView.axis = .vertical
	  stackView.alignment = .leading
	  stackView.distribution = .fill
	  stackView.spacing = 0
	  return stackView
	}()

	private let hourLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.font = UIFont.systemFont(ofSize: 14, weight: .light)
		label.textColor = .systemGray
		return label
	}()

	private let readLabel: PaddingLabel = {
		let label = PaddingLabel()
		label.numberOfLines = 1
		label.font = .systemFont(ofSize: 13)
		label.textColor = .white
		label.backgroundColor = .systemBlue
		label.clipsToBounds = true
		return label
	}()

	func setupCellModel(_ model: ChatCellViewModel) {
		self.photoImageView.loadImage(from: model.image)
		self.personNameLabel.text = model.name
		self.messageLabel.text = model.message
		self.hourLabel.text = model.hour
		self.readLabel.text = "\(model.unreadMessagesCount)"

		model.unreadMessagesCount > 0 ? highlightUnreadMessages() : hideUnreadMessages()
	}

	private func highlightUnreadMessages() {
		readLabel.isHidden = false
		hourLabel.textColor = .systemBlue
	}

	private func hideUnreadMessages() {
		readLabel.isHidden = true
		hourLabel.textColor = .systemGray
	}

	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		setupViewCode()
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		self.photoImageView.image = nil
		self.personNameLabel.text = nil
		self.messageLabel.text = nil
		self.hourLabel.text = nil
		self.readLabel.text = nil
	}
}

// MARK: Setup View Code
extension ChatTableViewCell: ViewCode {
	func buildHierarchy() {
		self.contentView.addSubviews(
			photoImageView,
			nameAndMsgStackView,
			hourLabel,
			readLabel
		)
		self.contentView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			photoImageView.heightAnchor.constraint(equalToConstant: 60),
			photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor),
			photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

			nameAndMsgStackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
			nameAndMsgStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			nameAndMsgStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

			hourLabel.topAnchor.constraint(equalTo: nameAndMsgStackView.topAnchor),
			hourLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			hourLabel.leadingAnchor.constraint(equalTo: nameAndMsgStackView.trailingAnchor, constant: 10),

			readLabel.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 5),
			readLabel.trailingAnchor.constraint(equalTo: hourLabel.trailingAnchor)
		])

		let height = nameAndMsgStackView.heightAnchor.constraint(equalToConstant: 65)
		height.priority = .defaultHigh
		height.isActive = true
	}

	func configureViews() {
		self.selectionStyle = .none
		self.photoImageView.layer.cornerRadius = 30
		self.readLabel.layer.cornerRadius = 7.5
	}

}
