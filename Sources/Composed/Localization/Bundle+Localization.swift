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
    public init(localized key: String, bundle: Bundle = Bundle.main) {
        self.init(stringLiteral: bundle.localizedString(forKey: key))
	}
    
    public init(localized format: String, bundle: Bundle = Bundle.main, _ arguments: CVarArg...) {
        let format = String(localized: format, bundle: bundle)
        let result = String.localizedStringWithFormat(format, arguments)
        self.init(stringLiteral: result)
    }
}
