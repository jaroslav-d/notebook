//
//  Record.swift
//  notebook
//
//  Created by Ярослав Дроздов on 28.02.2023.
//

import Foundation

struct Record: Identifiable, Codable, Hashable {
    var id: Int = Int(Date().timeIntervalSince1970)
    var title: String = ""
    var content: String = ""
}
