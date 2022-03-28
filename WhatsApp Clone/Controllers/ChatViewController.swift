//
//  ChatViewController.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 26/03/22.
//

import UIKit

class ChatViewController: UIViewController {

	// MARK: - Model
	var chats: [ChatCellViewModel] = [] {
		didSet {
			DispatchQueue.main.async { [weak self] in
				self?.chatView.tableView.reloadData()
			}
		}
	}

	let api = GetWhatsAppService()

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

		fetchAPI()
		setupNavBarWithSharedButton()
		removeLineUnderNavigationBar()

		chatView.tableView.delegate = self
		chatView.tableView.dataSource = self
	}

	func removeLineUnderNavigationBar() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithTransparentBackground()
		appearance.backgroundColor = .systemBackground
		self.navigationItem.scrollEdgeAppearance = appearance
	}

	private func fetchAPI() {
		api.fetch { zap in
			zap?.profile.friends?.forEach { friend in
				self.chats.append(ChatCellViewModel.init(friendModel: friend))
			}
		}
	}

	private func setupNavBarWithSharedButton() {
		if let newChat = UIImage(systemName: "square.and.pencil") {
			navigationItem.rightBarButtonItem = UIBarButtonItem(
				image: newChat,
				style: .plain,
				target: self,
				action: #selector(newChatAction)
			)
		}
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			title: "Edit",
			style: .plain,
			target: self,
			action: #selector(editAction)
		)
	}

	@objc func newChatAction() {
		print("New Chat action")
	}

	private func setUpToolbar() -> UIToolbar {

		var toolBarItems = [UIBarButtonItem]()
		let toolbar = UIToolbar(
			frame: CGRect(
				origin: .zero,
				size: CGSize(width: UIScreen.main.bounds.width, height: 70)
			)
		)

		let broadcastItem = UIBarButtonItem(title: "Broadcast List", style: .plain, target: nil, action: nil)

		toolBarItems.append(broadcastItem)
		toolBarItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))

		let newGroup = UIBarButtonItem(title: "New group", style: .plain, target: nil, action: nil)
		toolBarItems.append(newGroup)
		toolbar.barTintColor = .systemBackground
		toolbar.items = toolBarItems
		return toolbar
	}

	@objc func editAction() {
		chatView.tableView.setEditing(!chatView.tableView.isEditing, animated: true)
		chatView.tableView.allowsMultipleSelectionDuringEditing = true
		navigationItem.leftBarButtonItem?.title = chatView.tableView.isEditing ? "Done" : "Edit"
		navigationItem.leftBarButtonItem?.style = chatView.tableView.isEditing ? .done : .plain
	}

}

// MARK: - Extensions

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

extension ChatViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return setUpToolbar()
	}

	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return UITableViewCell.EditingStyle.init(rawValue: 3)!
	}

}
