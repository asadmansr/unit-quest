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
    var unit: UnitDetail
    
    init(_ unit: UnitDetail) {
        self.unit = unit
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Avatar(unit: unit).padding(.trailing, 4)
                    UnitNameView(unit: unit)
                }
                VStack(alignment: .leading, spacing: 6) {
                    CustomProgressView(progress: ((unit.count % unit.levelThreshold) * 10))
                    Text(unit.currentQuest)
                        .font(.system(size: 15.0))
                        .lineLimit(2)
                        .padding(.top, 12)
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


struct CustomProgressView: View {
    
    let progress: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack {}
                .frame(width: 100, height: 6, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 3).fill(Color.blue))
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center),content: {})
                .frame(width: CGFloat(progress), height: 6, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 3).fill(Color.green))
        }
    }
}
