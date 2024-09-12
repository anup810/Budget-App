//
//  Locale+Extension.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-11.
//

import Foundation

extension Locale{
    static var currencyCode: String{
        Locale.current.currency?.identifier ?? "USD"
    }
}
