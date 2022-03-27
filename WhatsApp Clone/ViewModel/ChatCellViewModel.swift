//
//  ChatCellViewModel.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 26/03/22.
//

import UIKit

struct ChatCellViewModel: Identifiable, Hashable {
	let id: UUID
	var image: String
	let name: String
	let message: String
	let hour: String
	let unreadMessagesCount: Int
}
