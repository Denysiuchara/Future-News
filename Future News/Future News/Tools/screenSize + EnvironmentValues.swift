//
//  + EnvironmentValues.swift
//  Future News
//
//  Created by Danya Denisiuk on 15.01.2024.
//

import SwiftUI

extension EnvironmentValues {
    var screenSize: CGSize {
        get { self[ScreenSizeEnvironmentKey.self] }
        set { self[ScreenSizeEnvironmentKey.self] = newValue }
    }
}
