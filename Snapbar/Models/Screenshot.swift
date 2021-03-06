//
//  Screenshot.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/6/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import Foundation

struct Screenshot: Codable, Identifiable, Hashable  {
    let id: UUID = UUID()
    let url: URL
    let createdAt: Date
}
