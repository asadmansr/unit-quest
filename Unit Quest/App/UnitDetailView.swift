//
//  UnitDetailView.swift
//  Unit Quest
//
//  Created by Asad Mansoor (LCL) on 2021-02-20.
//

import SwiftUI
import RealmSwift
import WidgetKit

struct UnitDetailView: View {
    
    var unit: UnitDetail
    @State private var currentUnit: UnitDetail = .wizard
    @State private var items: [QuestItems] = []
    @State var quest: String = ""
    let realm = myRealm
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                UnitView(currentUnit)
                    .frame(width: 170, height: 170, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0))))
                
                VStack(alignment: .leading) {
                    Text("Rewards")
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                    ForEach(unit.rewards, id: \.self) { rewards in
                        Text(rewards)
                            .font(.system(size: 15.0))
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                }.padding(16)
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0))))
            }.padding(.horizontal, 36)
            
            Text("Abilities")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 36)
                .padding(.top, 16)
                .padding(.bottom, 4)
            
            ForEach(unit.abilities, id: \.self) { ability in
                Text(ability)
                    .font(.system(size: 15.0))
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 36)
            }
            
            Text("Quests")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 36)
                .padding(.top, 16)
            
            if (items.count == 0) {
                Text("No quests added yet...")
                    .font(.system(size: 15.0))
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 36)
                    .padding(.top, 4)
            }
            
            List {
                ForEach(items) { item in
                    HStack() {
                        Text(verbatim: item.title)
                            .font(.system(size: 15.0))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {
                            completeQuest(id: item.uid)
                        }) {
                            Text("Done")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.black)
                                .padding(6)
                                .background(Color(UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)))
                                .cornerRadius(8)

                        }
                    }
                    
                }.onDelete(perform: onDelete)
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.white
                    UITableViewCell.appearance().backgroundColor = UIColor.white
                }
            }.padding(.leading, 24)
            
            if (items.count < unit.maxQuest){
                HStack {
                    TextField("Create quest...", text: $quest)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing, 12)
                    
                    Button(action: {
                        onAdd(quest: quest)
                        self.quest = ""
                    }) {
                        Text("Add")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                }.padding(36)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear() {
            loadData()
        }
    }
    
    private func onAdd(quest: String) {
        let timestamp = getTimestamp()
        items.append(QuestItems(uid: "quest-" + String(timestamp), title: quest, completed: false))
        insertToDatabase(quest: quest, timestamp: timestamp)
        if (items.count > 0){
            currentUnit.currentQuest = items[0].title
        } else {
            currentUnit.currentQuest = "No new quests"
        }
    }
    
    private func onDelete(offsets: IndexSet) {
        for index in offsets {
            let id = items[index].uid
            deleteFromDatabase(id: id)
        }
        items.remove(atOffsets: offsets)
    }
    
    private func loadData() {
        let quests = realm.objects(QuestEntity.self)
        print(quests)
        for i in quests {
            if (i.unit == unit.name) {
                let item = QuestItems(uid: i.id, title: i.quest, completed: i.completed)
                items.append(item)
            }
        }
        currentUnit = unit
        if (items.count > 0){
            currentUnit.currentQuest = items[0].title
        } else {
            currentUnit.currentQuest = "No new quests"
        }
    }
    
    private func completeQuest(id: String) {
        updateQuestCount(id: id)
        var index = 0
        for quest in items {
            if (quest.uid == id) {
                items.remove(at: index)
            }
            index += 1
        }
        deleteFromDatabase(id: id)
    }
    
    private func insertToDatabase(quest: String, timestamp: Int) {
        let newQuest = QuestEntity()
        newQuest.id = "quest-" + String(timestamp)
        newQuest.unit = unit.name
        newQuest.quest = quest
        newQuest.dateCreated = timestamp
        
        try! realm.write {
            realm.add(newQuest)
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    private func deleteFromDatabase(id: String) {
        print(id)
        let item = realm.objects(QuestEntity.self)
        var itemToDelete: QuestEntity? = nil
        for i in item {
            if (i.id == id) {
                itemToDelete = i
            }
        }
        
        try! realm.write {
            if (itemToDelete != nil){
                realm.delete(itemToDelete!)
            }
        }
        
        if (items.count > 0){
            currentUnit.currentQuest = items[0].title
        } else {
            currentUnit.currentQuest = "No new quests"
        }
    }
    
    private func updateQuestCount(id: String) {
        let unitEntity = realm.objects(UnitEntity.self)
        var item: UnitEntity? = nil
        
        for i in unitEntity {
            if (i.name == unit.name) {
                item = i
            }
        }
        
        if (item != nil) {
            var completedQuest = item?.completedQuest
            completedQuest! += 1
            let level = Int(completedQuest! / unit.levelThreshold) + 1
            
            try! realm.write {
                item?.completedQuest = completedQuest!
                item?.level = level
            }
            
            currentUnit.level = level
            currentUnit.count = completedQuest!
        }
        
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    private func getTimestamp() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
}


