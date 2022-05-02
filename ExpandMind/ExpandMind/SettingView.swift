//
//  SettingView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI
//slider 범위 문제 해결 못함
struct SettingView: View {
    @State private var start: CGFloat = 0.0
    @State private var end: CGFloat = 3600.0
    @State var categoryArr: [Categories] = makeCategoryData()

    var body: some View {
        ZStack{
            Color.bgColor.ignoresSafeArea()
            GeometryReader{proxy in
                VStack(alignment: .leading){
                    Text("영상 시간")
                        .padding(.vertical, 20)
                    Text("최소 시간")
                    Slider(
                        value: $start,
                        in: 0...3600
                    ){
                        Text("duration")
                    }minimumValueLabel: {
                        Text("00:00")
                    }maximumValueLabel: {
                        Text("60:00")
                    }
                    .tint(.customBlack)
                    .padding(.vertical, 10)
                    Text("최대 시간")
                    Slider(
                        value: $end,
                        in: 0...3600
                    ){
                        Text("duration")
                    }minimumValueLabel: {
                        Text("00:00")
                    }maximumValueLabel: {
                        Text("60:00")
                    }
                    .tint(.customBlack)
                    .padding(.vertical, 10)

                    HStack{
                        Spacer()
                        Text("\(checkDigit(val : Int(start)/60)):\(checkDigit(val : Int(start)%60))")
                            .frame(width: 80, height: 40)
                        Text("~")
                            .frame(height: 40)
                        Text("\(checkDigit(val : Int(end)/60)):\(checkDigit(val : Int(end)%60))")
                            .frame(width: 80, height: 40)
                        Spacer()
                    }
                    .padding(.top, 20)
                    Spacer()
                    Text("카테고리")
                        .padding(.vertical, 20)
                    categoryBox(proxy: proxy, items: categoryArr)
                    Spacer()
                }
                .frame(width: proxy.size.width * 0.9, height: proxy.size.height * 0.9, alignment: .top)
                .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
            }
        }
    }
    private func categoryBox(proxy: GeometryProxy, items: [Categories]) -> some View{
        VStack(spacing: 20){
            HStack{
                ForEach(0..<3, id:\.self){idx in
                    Text(items[idx].division)
                        .frame(width: proxy.size.width * 0.3 , height: proxy.size.height * 0.1)
                        .background(items[idx].isSelected ? Color.customBlack : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(items[idx].isSelected ? .white : .customBlack)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.customBlack.opacity(0.3), lineWidth: 1))
                        .onTapGesture {
                            categoryArr[idx].isSelected.toggle()
                        }
                }
            }
            HStack{
                ForEach(3..<items.count, id:\.self){idx in
                    Text(items[idx].division)
                        .frame(width: proxy.size.width * 0.3 , height: proxy.size.height * 0.1)
                        .background(items[idx].isSelected ? Color.customBlack : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(items[idx].isSelected ? .white : .customBlack)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.customBlack.opacity(0.3), lineWidth: 1))

                        .onTapGesture {
                            categoryArr[idx].isSelected.toggle()
                        }
                }
            }
        }
    }
    private func checkDigit(val: Int) -> String{
        return val / 10 > 0 ? String(val) : "0" + String(val)
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
