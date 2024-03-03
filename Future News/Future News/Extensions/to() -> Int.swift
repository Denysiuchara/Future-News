//
//  + Int.swift
//  Future News
//
//  Created by Danya Denisiuk on 04.02.2024.
//

import Foundation

extension SignedInteger {
    func to<T:FixedWidthInteger & SignedInteger>() -> T {
        return T(self)
    }
}

extension Int {
    //Convert to any FixWidth SigndeInt by generic
    func to<T:FixedWidthInteger & SignedInteger>() -> T {
        return T(self)
    }

}

extension Int64 {
    //Convert to any FixWidth SigndeInt by generic
    func to<T:FixedWidthInteger & SignedInteger>() -> T {
        return T(self)
    }
}

extension Int32 {
    //Convert to any FixWidth SigndeInt by generic
    func to<T:FixedWidthInteger & SignedInteger>() -> T {
        return T(self)
    }
}
