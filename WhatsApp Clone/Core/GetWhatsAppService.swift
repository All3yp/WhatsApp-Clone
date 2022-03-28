//
//  GetWhatsAppService.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 27/03/22.
//  swiftlint:disable switch_case_alignment

import Foundation

protocol GetWhatsAppServiceProtocol {

	var network: ServiceProtocol { get }

	func fetch(_ completion: @escaping (WhatsAppModel?) -> Void)
}

struct GetWhatsAppService: GetWhatsAppServiceProtocol {

	var network: ServiceProtocol = Service()

	func fetch(_ completion: @escaping (WhatsAppModel?) -> Void) {

		let endpoint = "https://run.mocky.io/v3/b5085cf9-ef2f-493e-bfc4-ad01d116539c"

		guard let url = URL(string: endpoint) else { return }

		network.get(url, of: WhatsAppModel.self) { result in
			switch result {
				case .success(let result):
					completion(result)
				case .failure:
					completion(nil)
			}
		}
	}

}
