//
//  Double+Round.swift
//  Japan-Temperature_Mobile
//
//  Created by Dev Tech on 2025/08/10.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let p = pow(10.0, Double(places))
        return (self * p).rounded() / p
    }
}
