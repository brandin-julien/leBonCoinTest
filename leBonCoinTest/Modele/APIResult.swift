//
//  APIResult.swift
//  leBonCoinTest
//
//  Created by julien brandin on 22/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import Foundation
import UIKit

struct category: Decodable {
    var id: Int
    var name: String
}

struct advert: Decodable {
    var id: Int
    var category_id: Int
    var title: String
    var description: String
    var price: Int
    var images_url: [String: String]
    var creation_date: String
    var is_urgent: Bool
}


struct imageUrl: Decodable {
    var small: String
    var thumb: String
}
