//
//  Model.swift
//  BookCatalog
//
//  Created by Michael Ardizzone on 3/4/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation

struct Book: Codable {
    let author: String
    let categories: String
    let id: Int
    var lastCheckedOut: String?
    var lastCheckedOutBy: String?
    let publisher: String?
    let title: String
    let url: String
}
