//
//  UnitDetail.swift
//  Unit Quest
//
//  Created by Asad Mansoor (LCL) on 2021-02-20.
//

import Foundation
import RealmSwift

struct UnitDetail {
    let name: String
    let image: String
    var level: Int
    let abilities: [String]
    let rewards: [String]
    let url: URL
    var currentQuest: String
    let maxQuest: Int
    var count: Int
    var levelThreshold: Int
    
    static var warrior = UnitDetail(
        name: "Knight",
        image: "Knight",
        level: 10,
        abilities: [
            "- Can only have two active tasks at a time",
            "- Unfinished quests disappear after 24 hours",
            "- Levels every 10 quests and earns one reward"
        ],
        rewards: [
            "- Gain extra task",
            "- Deadline extended for extra 24 hours",
            "- Gain 3 quest XP for completing a single quest"
        ],
        url: URL(string: "app:///knight")!,
        currentQuest: "No new quests",
        maxQuest: 2,
        count: 0,
        levelThreshold: 10
    )
    
    static var wizard = UnitDetail(
        name: "Wizard",
        image: "Wizard",
        level: 3,
        abilities: [
            "- Can only have four active tasks at a time",
            "- Unfinished quests disappear after 24 hours",
            "- Levels every 24 quests and earns one reward"
        ],
        rewards: [
            "- Gain two extra task",
            "- Bring a quest back from the dead",
            "- Gain 5 quest XP for completing a single quest"
        ],
        url: URL(string: "app:///wizard")!,
        currentQuest: "No new quests",
        maxQuest: 4,
        count: 0,
        levelThreshold: 24
    )
}

