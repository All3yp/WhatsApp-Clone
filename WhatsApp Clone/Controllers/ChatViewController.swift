//
//  ChatViewController.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 26/03/22.
//

import UIKit

class ChatViewController: UIViewController {

	// MARK: - Model
	var chats: [ChatCellViewModel] = [
		ChatCellViewModel(
			id: UUID(),
			image: "imageTest",
			name: "Alley Pereira",
			message: "Estou realizando um teste aqui rapidinho ta beleza?",
			hour: "23:23", unreadMessagesCount: 0
		),
		ChatCellViewModel(
			id: UUID(),
			image: "imageTest",
			name: "Alley Pereira",
			message: "Estou realizando um teste aqui rapidinho ta beleza?",
			hour: "23:23", unreadMessagesCount: 23
		),
		ChatCellViewModel(
			id: UUID(),
			image: "imageTest",
			name: "Alley Pereira",
			message: "Estou realizando um teste aqui rapidinho ta beleza?",
			hour: "23:23", unreadMessagesCount: 23
		)
	] {
		didSet {
			chatView.tableView.reloadData()
		}
	}

	// MARK: - Views
	private let chatView: ChatView = ChatView(frame: UIScreen.main.bounds)

	// MARK: - View lifecycle
	init(titleNav: String) {
		super.init(nibName: nil, bundle: nil)
		title = titleNav
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		super.loadView()
		self.view = chatView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .systemBackground

		chatView.tableView.delegate = self
		chatView.tableView.dataSource = self
	}

}

// MARK: - Extensions
extension ChatViewController: UITableViewDelegate {}

extension ChatViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return chats.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = ChatTableViewCell()
		cell.setupCellModel(chats[indexPath.row])
		return cell
	}

}
