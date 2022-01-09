//
//  SimplyDequeueable.swift
//  ZVBUIUtilities
//
//  Created by Zoe Van Brunt on 10/1/17.
//  Copyright © 2017 Zoe Van Brunt. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public protocol SimplyDequeueable {
	static var standardReuseIdentifier: String { get }
}

extension SimplyDequeueable where Self: UITableViewCell {
	public static func register(with tableView: UITableView) {
		tableView.register(self, forCellReuseIdentifier: standardReuseIdentifier)
	}

	public static func dequeue(from tableView: UITableView, indexPath: IndexPath) -> Self {
		guard let cell = tableView
			.dequeueReusableCell(withIdentifier: standardReuseIdentifier, for: indexPath)
			as? Self else { fatalError("Simply Dequeueable Cell not registered with Table View") }
		return cell
	}
}

extension SimplyDequeueable where Self: UITableViewHeaderFooterView {
	public static func registerHeaderFooter(with tableView: UITableView) {
		tableView.register(self, forHeaderFooterViewReuseIdentifier: standardReuseIdentifier)
	}

	public static func dequeue(from tableView: UITableView, section: Int) -> Self {
		guard let view = tableView
			.dequeueReusableHeaderFooterView(withIdentifier: standardReuseIdentifier)
			as? Self else { fatalError("Simply Dequeueable Header Footer View not registered with Table View") }
		return view
	}
}

#endif
