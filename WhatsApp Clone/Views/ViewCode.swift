//
//  ViewCode.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 26/03/22.
//

import Foundation

protocol ViewCode {
	func buildHierarchy()
	func setupConstraints()
	func configureViews()
}

extension ViewCode {

	func configureViews() { }

	func setupViewCode() {
		buildHierarchy()
		setupConstraints()
		configureViews()
	}

}
