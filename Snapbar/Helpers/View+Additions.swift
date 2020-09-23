//
//  View+Additions.swift
//  Snapbar
//
//  Created by Jay Stakelon on 9/22/20.
//  Copyright © 2020 Jay Stakelon. All rights reserved.
//

import SwiftUI

extension View {
    func debugPrint(_ value: Any) -> some View {
        #if DEBUG
        print(value)
        #endif
        return self
    }
}
