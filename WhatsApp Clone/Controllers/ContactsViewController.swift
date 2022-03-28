//
//  ContactsViewController.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 27/03/22.
//

import UIKit

class ContactsViewController: UIViewController {

	// MARK: - Model

	var contacts: [Profile] = [] {
		didSet {
			reloadDictionary()
			DispatchQueue.main.async {
				self.contactsView.tableView.reloadData()
			}
		}
	}

	private var filteredContacts: [Profile] {
		contacts.filter {
			if let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty {
				return $0.name.lowercased().contains(searchText) || ($0.status?.lowercased().contains(searchText) ?? false)
			} else {
				return true
			}
		}
	}

	private var dictionary: [String: [Profile]] = [:]

	private var sortedDictionary: [(key: String, value: [Profile])] {
		dictionary.sorted {
			$0.key.lowercased() < $1.key.lowercased()
		}
	}

	private func reloadDictionary() {
		let str = "abcdefghijklmnopqrstuvwxyz"
		let alphabet: [String] = Array(str).map { "\($0)" }
		alphabet.forEach { letter in
			dictionary[letter] = filteredContacts
				.filter { "\($0.name.first!.lowercased())" == letter }
				.sorted { $0.name.lowercased() < $1.name.lowercased() }
		}
	}

	// MARK: - Views

	lazy var contactsView: ContactsView = {
		let view = ContactsView()
		view.tableView.delegate = self
		view.tableView.dataSource = self
		return view
	}()

	private lazy var searchController: UISearchController = {
		let search = UISearchController(searchResultsController: nil)
		search.searchBar.placeholder = "Search"
		search.searchBar.sizeToFit()
		search.searchBar.backgroundColor = .clear
		search.searchBar.searchBarStyle = .minimal
		search.searchResultsUpdater = self
		return search
	}()

	// MARK: - Life Cycle

	override func loadView() {
		super.loadView()
		self.view = contactsView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "New Chat"

		setupNavigationWithSearch()

		self.navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .close,
			target: self,
			action: #selector(closeModalAction)
		)
	}

	// MARK: - Helpers

	@objc private func closeModalAction() {
		dismiss(animated: true, completion: {
			print("Dismiss")
		})
	}

	private func setupNavigationWithSearch() {
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
	}

}

// MARK: - SearchController

extension ContactsViewController: UISearchResultsUpdating {

	func updateSearchResults(for searchController: UISearchController) {
		reloadDictionary()
		contactsView.tableView.reloadData()
	}
}

// MARK: - TableView

extension ContactsViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return dictionary.keys.count
	}

	func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		return sortedDictionary.map { $0.key.uppercased() }
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return sortedDictionary[section].key.uppercased()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sortedDictionary[section].value.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let contact = sortedDictionary[indexPath.section].value[indexPath.row]
		let cell = ContactTableViewCell()
		cell.setupCellModel(contact)
		return cell
	}

}

extension ContactsViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		if let header = view as? UITableViewHeaderFooterView {
			header.contentView.backgroundColor = UIColor.secondarySystemBackground
		}
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 30
	}

}
