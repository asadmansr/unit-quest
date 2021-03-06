//
//  QuestItems.swift
//  Unit Quest
//
//  Created by Asad Mansoor (LCL) on 2021-02-20.
//

import Foundation

struct QuestItems: Identifiable {
    let id = UUID()
    let uid: String
    let title: String
    let completed: Bool
}
