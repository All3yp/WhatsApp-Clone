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

	var filteredChats: [ChatCellViewModel] {
		chats.filter {
			if let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty {
				return $0.name.lowercased().contains(searchText) ||
				$0.message.lowercased().contains(searchText) ||
				$0.hour.lowercased().contains(searchText)
			} else {
				return true
			}
		}
	}

	var contacts: [Profile] = []

	let api = GetWhatsAppService()

	// MARK: - Views
	private let chatView: ChatView = ChatView(frame: UIScreen.main.bounds)

	private lazy var searchController: UISearchController = {
		let search = UISearchController(searchResultsController: nil)
		search.searchBar.placeholder = "Search"
		search.searchBar.sizeToFit()
		search.searchBar.backgroundColor = .clear
		search.searchBar.searchBarStyle = .minimal
		search.searchResultsUpdater = self
		return search
	}()

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
		setupNavigationWithSearch()
		removeLineUnderNavigationBar()

		chatView.tableView.delegate = self
		chatView.tableView.dataSource = self

	}

	private func setupNavigationWithSearch() {
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
	}

	func removeLineUnderNavigationBar() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithTransparentBackground()
		appearance.backgroundColor = .systemBackground
		self.navigationItem.scrollEdgeAppearance = appearance
	}

	private func fetchAPI() {
		api.fetch { zap in

			guard let zap = zap else { return }

			// load chats
			zap.profile.friends?.forEach { friend in
				self.chats.append(ChatCellViewModel.init(friendModel: friend))
			}

			// store contacts
			self.contacts = zap.allFriends
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
		let contactsVC = ContactsViewController()
		contactsVC.contacts = contacts
		contactsVC.modalPresentationStyle = .formSheet
		let newNav = UINavigationController(rootViewController: contactsVC)
		self.present(newNav, animated: true, completion: nil)
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
		return filteredChats.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = ChatTableViewCell()
		cell.setupCellModel(filteredChats[indexPath.row])
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

extension ChatViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		chatView.tableView.reloadData()
	}
}
