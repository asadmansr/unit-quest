//
//  ContentView.swift
//  Unit Quest
//
//  Created by Asad Mansoor (LCL) on 2021-02-20.
//

import SwiftUI

struct ContentView: View {
    
    @State var isWarriorActive: Bool = false
    @State var isWizardActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your units are unique. They help you track and complete quests. Any quests not completed in 24 hours will be deleted and will not count towards your progress. So pick your quests wisely.")
                    .font(.system(size: 15.0))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 36)
                    .padding(.vertical, 8)
                
                List {
                    NavigationLink(destination: UnitDetailView(), isActive: $isWarriorActive) {
                        UnitRowView(unit: .warrior)
                    }
                    NavigationLink(destination: UnitDetailView(), isActive: $isWarriorActive) {
                        UnitRowView(unit: .wizard)
                    }
                }.listStyle(PlainListStyle())
                
                Text("New units will be added in upcoming updates! ⚔️")
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .padding(36)
            }
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor.white
                UITableViewCell.appearance().backgroundColor = UIColor.white
            }
            .navigationBarTitle("Your Units")
        }
    }
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
            VStack {
                Text(unit.name)
                    .foregroundColor(.black)
                    .fontWeight(.medium)
                    .padding(.leading, 16.0)
                Text("Level \(unit.level)")
                    .foregroundColor(.gray)
                    .padding(.leading, 16.0)
                    .padding(.top, 2)
            }
        }
    }
}
