//
//  UnitView.swift
//  Unit Quest
//
//  Created by Asad Mansoor (LCL) on 2021-02-20.
//

import SwiftUI
import WidgetKit

struct Avatar: View {
    var unit: UnitDetail
    
    var body: some View {
        Image(unit.image)
            .resizable()
            .frame(width: 50, height: 50, alignment: .center)
            .background(Color(UIColor(red: 230/255, green: 238/255, blue: 156/255, alpha: 1.0)))
            .clipShape(Circle())
    }
}

struct UnitView: View {
    var character: UnitDetail
    
    init(_ character: UnitDetail) {
        self.character = character
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Avatar(unit: character).padding(.trailing, 4)
                    UnitNameView(unit: character)
                }
                VStack(alignment: .leading, spacing: 6) {
                    ProgressView("", value: 60, total: 100)
                    Text("My first adventure awaits")
                        .font(.callout)
                        .lineLimit(2)
                        .padding(.top, 4)
                }
            }
        }
        .padding()
    }
}


struct UnitNameView: View {
    let unit: UnitDetail
    
    var body: some View {
        VStack(alignment: .center) {
            Text(unit.name)
                .font(.headline)
                .fontWeight(.bold)
                .minimumScaleFactor(0.25)
            Text("Level \(unit.level)")
                .minimumScaleFactor(0.5)
        }
    }
}
