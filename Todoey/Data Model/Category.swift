//
//  Category.swift
//  Todoey
//
//  Created by Leo Francoeur on 11/2/18.
//  Copyright © 2018 Leo Francoeur. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
    
}
