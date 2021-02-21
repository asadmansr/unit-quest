//
//  ContentView.swift
//  Unit Quest
//
//  Created by Asad Mansoor (LCL) on 2021-02-20.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State var isWarriorActive: Bool = false
    @State var isWizardActive: Bool = false
    @State var items: [UnitDetail] = [UnitDetail]()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your units are unique. They help you track and complete quests. Any quests not completed in 24 hours will be deleted and will not count towards your progress. So pick your quests wisely.")
                    .font(.system(size: 15.0))
                    .foregroundColor(.gray)
                    .fontWeight(.medium)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                
                List {
                    if (items.count > 0){
                        NavigationLink(destination: UnitDetailView(unit: items[0]), isActive: (items[0].name == "Knight") ? $isWarriorActive : $isWizardActive) {
                            UnitRowView(unit: items[0])
                        }
                        
                        NavigationLink(destination: UnitDetailView(unit: items[1]), isActive: (items[1].name == "Wizard") ? $isWizardActive : $isWarriorActive) {
                            UnitRowView(unit: items[1])
                        }
                    }
                }.listStyle(PlainListStyle())
                
                Text("New units will be added in upcoming updates! ⚔️")
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .padding(.horizontal, 36)
                    .padding(.bottom, 64)
            }
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor.white
                UITableViewCell.appearance().backgroundColor = UIColor.white
                loadData()
            }
            .navigationBarTitle("Your Units")
            .onOpenURL(perform: { (url) in
                self.isWizardActive = url == UnitDetail.wizard.url
                self.isWarriorActive = url == UnitDetail.warrior.url
            })
        }
    }
    
    private func loadData() {
        let realm = try! Realm()
        let units = realm.objects(UnitEntity.self)
        
        print(units)
        
        if (units.count == 0){
            UnitDetail.warrior.level = 1
            UnitDetail.wizard.level = 1
            
            let warrior = UnitDetail.warrior
            let wizard = UnitDetail.wizard
            
            let warriorEntity = UnitEntity()
            warriorEntity.name = warrior.name
            warriorEntity.level = warrior.level
            
            let wizardEntity = UnitEntity()
            wizardEntity.name = wizard.name
            wizardEntity.level = wizard.level
            
            try! realm.write {
                realm.add(warriorEntity)
                realm.add(wizardEntity)
            }
            
            items.append(warrior)
            items.append(wizard)
        } else {
            self.items.removeAll()
            for i in units {
                if (i.name == "Knight") {
                    var warrior = UnitDetail.warrior
                    warrior.level = i.level
                    warrior.count = i.completedQuest
                    items.append(warrior)
                } else if (i.name == "Wizard") {
                    var wizard = UnitDetail.wizard
                    wizard.level = i.level
                    wizard.count = i.completedQuest
                    items.append(wizard)
                }
            }
        }
    }
}

class UnitEntity: Object {
    @objc dynamic var name = ""
    @objc dynamic var level = 0
    @objc dynamic var completedQuest = 0
}


struct UnitRowView: View {
    let unit: UnitDetail
    
    var body: some View {
        HStack {
            Image(unit.image)
                .resizable()
                .frame(width: 72, height: 72, alignment: .center)
                .background(Color(UIColor(red: 230/255, green: 238/255, blue: 156/255, alpha: 1.0)))
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(unit.name)
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.65)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16.0)
                Text("Level \(unit.level)")
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16.0)
                
            }
        }
    }
}
