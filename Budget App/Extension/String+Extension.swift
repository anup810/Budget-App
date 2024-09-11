//
//  String+Extension.swift
//  Budget App
//
//  Created by Anup Saud on 2024-09-11.
//

import Foundation
extension String{
    var isEmptyOrWhitespace: Bool{
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
