//
//  UnitDetailView.swift
//  Unit Quest
//
//  Created by Asad Mansoor (LCL) on 2021-02-20.
//

import SwiftUI

struct UnitDetailView: View {
    
    let unit: UnitDetail
    @State private var items: [QuestItems] = []
    @State var quest: String = ""
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                UnitView(unit)
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
                    Text(verbatim: item.title)
                        .font(.system(size: 15.0))
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }.onDelete(perform: onDelete)
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.white
                    UITableViewCell.appearance().backgroundColor = UIColor.white
                }
            }.padding(.leading, 24)
            
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
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func onAdd(quest: String) {
        items.append(QuestItems(title: quest))
    }
    
    private func onDelete(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
