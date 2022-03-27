//
//  UIView+Ext.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 26/03/22.
//

import UIKit

extension UIView {
	public func addSubviews(_ subviews: UIView...) {
		subviews.forEach(addSubview(_:))
	}
}
