// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import Foundation

// MARK: - Common UITableView text styling
extension NSAttributedString {
    static func tableRowTitle(_ string: String, enabled: Bool) -> NSAttributedString {
        var color: [NSAttributedString.Key: UIColor]
        if enabled {
            color = [NSAttributedString.Key.foregroundColor: UIColor.legacyTheme.tableView.rowText]
        } else {
            color = [NSAttributedString.Key.foregroundColor: UIColor.legacyTheme.tableView.disabledRowText]
        }

        return NSAttributedString(string: string, attributes: color)
    }
}
