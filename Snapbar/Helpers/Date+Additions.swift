//
//  Date+Additions.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/7/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import Foundation

extension Date {
    func relativeTime(in locale: Locale = .current) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
