//
//  CustomTabBarController.swift
//  WhatsApp Clone
//
//  Created by Alley Pereira on 26/03/22.
//

import UIKit

class CustomTabBarController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()

		configTabbar()
		tabBar.backgroundColor = .gray.withAlphaComponent(0.1)
	}

	private func configTabbar() {

		let statusVC = ViewController(titleNav: "Status")
		let callsVC = ViewController(titleNav: "Calls")
		let cameraVC = ViewController(titleNav: "Camera")
		let chatsVC = ViewController(titleNav: "Chats")
		let settingsVC = ViewController(titleNav: "Settings")

		self.viewControllers = [
			embledNav(viewController: statusVC, title: "Status", image: "circle.dashed.inset.filled"),
			embledNav(viewController: callsVC, title: "Calls", image: "phone.fill"),
			embledNav(viewController: cameraVC, title: "Camera", image: "camera.fill"),
			embledNav(viewController: chatsVC, title: "Chats", image: "bubble.left.and.bubble.right.fill"),
			embledNav(viewController: settingsVC, title: "Settings", image: "gearshape.fill")
		]
	}


	private func embledNav(
		viewController: UIViewController,
		title: String,
		image: String
	) -> UIViewController {
		let nav = UINavigationController(rootViewController: viewController)
		nav.tabBarItem.title = title
		nav.navigationBar.prefersLargeTitles = true
		nav.tabBarItem.image = UIImage(systemName: image)
		return nav
	}


}
