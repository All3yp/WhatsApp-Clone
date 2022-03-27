//
//  ChatCellViewModel.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 26/03/22.
//

import UIKit

struct ChatCellViewModel: Identifiable, Hashable {
	let id: UUID
	let name: String
	let message: String
	let hour: String
	let isRead: Bool

}

extension ChatCellViewModel: ViewCellModel {

	func cell(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell {
			
		}
		return ChatTableViewCell()
	}
}



/*
 extension PinSeriesInformationCellModel: PinDetailCollectionViewCellModel {
	 func cell(from collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
		 if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinCell.identifier, for: indexPath) as? PinCell {
			 cell.cellGeneralConfiguration()
			 cell.setUpPinViewModel(with: self)
			 return cell
		 }
		 return PinCell()
	 }
 }
 */
