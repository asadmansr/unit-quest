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
    
    static func loadData(name: String, completion:@escaping ([UnitDetail]?, Error?) -> Void) {
        do {
            let realm = myRealm
            let units = realm.objects(UnitEntity.self)
            var items: [UnitDetail] = [UnitDetail]()
            
            for i in units {
                if ((i.name == "Knight") && (name == "Knight") ){
                    let quests =  realm.objects(QuestEntity.self).filter("unit == 'Knight'")
                    print(quests)
                    
                    var current = ""
                    if (quests.count > 0){
                        current = quests[0].quest
                    } else {
                        current = "No new quests"
                    }
                    
                    var warrior = UnitDetail.warrior
                    warrior.level = i.level
                    warrior.count = i.completedQuest
                    warrior.currentQuest = current
                    items.append(warrior)
                    
                } else if ((i.name == "Wizard") && (name == "Wizard")) {
                    let quests =  realm.objects(QuestEntity.self).filter("unit == 'Wizard'")
                    print(quests)

                    var current = ""
                    if (quests.count > 0){
                        current = quests[0].quest
                    } else {
                        current = "No new quests"
                    }

                    var wizard = UnitDetail.wizard
                    wizard.level = i.level
                    wizard.count = i.completedQuest
                    wizard.currentQuest = current
                    items.append(wizard)
                }
            }
            
            completion(items, nil)
        } catch {
            completion(nil, error)
        }
    }
}

var myRealm: Realm {
    var directory = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.asadmansoor.Unit-Quest")!
    directory.appendPathComponent("db.realm", isDirectory: true)
    let configuration = Realm.Configuration(fileURL: directory, schemaVersion: myRealmSchemaVersion)
    let realm = try! Realm(configuration: configuration)
    return realm
}

var myRealmSchemaVersion: UInt64 {
    return 1
}

class UnitEntity: Object {
    @objc dynamic var name = ""
    @objc dynamic var level = 0
    @objc dynamic var completedQuest = 0
}

class QuestEntity: Object {
    @objc dynamic var id = ""
    @objc dynamic var unit = ""
    @objc dynamic var quest = ""
    @objc dynamic var completed = false
    @objc dynamic var dateCreated = 0
}
