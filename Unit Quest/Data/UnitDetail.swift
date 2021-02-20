//
//  UnitDetail.swift
//  Unit Quest
//
//  Created by Asad Mansoor (LCL) on 2021-02-20.
//

import Foundation

struct UnitDetail {
    let name: String
    let image: String
    let level: Int
    
    static let warrior = UnitDetail(name: "Warrior", image: "Knight", level: 10)
    static let wizard = UnitDetail(name: "Wizard", image: "Wizard", level: 3)
}
