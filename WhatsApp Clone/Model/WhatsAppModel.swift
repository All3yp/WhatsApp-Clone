//
//  WhatsAppModel.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 26/03/22.
//

import Foundation

// MARK: - WhatsApp
struct WhatsAppModel: Codable {
	let profile: Profile
	let friends, allFriends: [Profile]
}

// MARK: - Profile
struct Profile: Codable {
	let id: Int
	let name: String
	let picture: String
	let status: String?
	let chatlog: [Chatlog]?
	let friends: [Friend]?
}

// MARK: - Chatlog
struct Chatlog: Codable {
	let text, timestamp, side: String
	let messageID: Int

	enum CodingKeys: String, CodingKey {
		case text, timestamp, side
		case messageID = "message_id"
	}
}

// MARK: - Friend
struct Friend: Codable {
	let id: Int
	let name: String
	let picture: String
	let latestTimestamp, lastChat: String

	enum CodingKeys: String, CodingKey {
		case id, name, picture
		case latestTimestamp = "latest_timestamp"
		case lastChat
	}
}
