//
//  Bundle+Localization.swift
//  ZoeLog
//
//  Created by Zoe Van Brunt on 7/5/17.
//  Copyright © 2017 Zoe Van Brunt. All rights reserved.
//

import Foundation

extension Bundle {
    public func localizedString(forKey key: String) -> String {
        return localizedString(forKey: key, value: nil, table: nil)
    }
}

extension String {
	public init(localized key: String) {
        self.init(stringLiteral: Bundle.main.localizedString(forKey: key))
	}
    
    public init(localized format: String, _ arguments: CVarArg...) {
        self.init(stringLiteral: String.localizedStringWithFormat(String(localized: format), arguments))
    }
}
