//
//  ChatCellViewModel.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 26/03/22.
//

import UIKit

struct ChatCellViewModel: Identifiable, Hashable {
	let id: Int
	var image: String
	let name: String
	let message: String
	let hour: String
	let unreadMessagesCount: Int

	init(friendModel: Friend) {
		self.id = friendModel.id
		self.image = friendModel.picture
		self.name = friendModel.name
		self.message = friendModel.lastChat
		self.hour = friendModel.latestTimestamp
		self.unreadMessagesCount = Int.random(in: 0...3)
	}
}
