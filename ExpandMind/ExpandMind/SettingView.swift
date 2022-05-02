//
//  SettingView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI

struct SettingView: View {
    @State private var start: CGFloat = 0.0
    @State private var end: CGFloat = 3600.0
    @State var CategoryArr: [Categories] = makeCategoryData()

    var body: some View {
        ZStack{
            Color.bgColor.ignoresSafeArea()
            GeometryReader{proxy in
                VStack{
                    Text("영상 시간")
                    Text("최소 시간")
                    Slider(
                        value: $start,
                        in: 0...end
                    ){
                        Text("duration")
                    }minimumValueLabel: {
                        Text("00:00")
                    }maximumValueLabel: {
                        Text("60:00")
                    }
                    .tint(.customBlack)
                    Text("최대 시간")
                    Slider(
                        value: $end,
                        in: start...3600
                    ){
                        Text("duration")
                    }minimumValueLabel: {
                        Text("00:00")
                    }maximumValueLabel: {
                        Text("60:00")
                    }
                    .tint(.customBlack)
                    HStack{
                        Text("\(Int(start)/60):\(Int(start)%60)")
                        Text("~")
                        Text("\(Int(end)/60):\(Int(end)%60)")                    }
                }
            }
        }
    }
    static func makeCategoryData() -> [Categories]{
        [
        Categories(division: "travel", isSelected: false),
        Categories(division: "education", isSelected: false),
        Categories(division: "technology", isSelected: false),
        Categories(division: "howto", isSelected: false),
        Categories(division: "news", isSelected: false),
        Categories(division: "nonprofit", isSelected: false),
        ]

    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
