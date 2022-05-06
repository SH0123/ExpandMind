//
//  SettingView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI
import CoreData
struct SettingView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @State var presented: Bool = false
    @EnvironmentObject var network: Network
    @State var categoryArr: [Categories] = makeCategoryData()
    @State var selectedDuration: String? = UserDefaults.standard.string(forKey:"selectedDuration")
    @State var selectedCategories = UserDefaults.standard.array(forKey:"selectedCategories") as? [String] ?? [String]()
    
    var body: some View {
        ZStack{
            Color.bgColor.ignoresSafeArea()
            GeometryReader{proxy in
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        Button(action:{
                            UserDefaults.standard.set(selectedDuration, forKey: "selectedDuration")
                            network.videos = []
                            presented = true
                        }){
                            Text("저장")
                                .foregroundColor(.customBlack)
                        }
                        .alert("저장되었습니다",isPresented: self.$presented){
                            Button("확인",role:.cancel,action:{})                        }
                    }
                    Spacer()
                    HStack{
                    Text("영상 시간")
                        .font(.system(size:17, weight:.semibold))
                        Spacer()
                    }
                        .padding(.vertical, 20)
                    HStack{
                        Text("4분 미만")
                            .boxStyle(selected: selectedDuration=="short", proxy: proxy)
                            .onTapGesture{
                                self.selectedDuration = selectedDuration=="short" ? nil : "short"
                            }
                        Text("4분 ~ 20분")
                            .boxStyle(selected: selectedDuration=="medium", proxy: proxy)
                            .onTapGesture{
                                self.selectedDuration = selectedDuration=="medium" ? nil : "medium"

                            }

                        Text("20분 이상")
                            .boxStyle(selected: selectedDuration=="long", proxy: proxy)
                            .onTapGesture{
                                self.selectedDuration = selectedDuration=="long" ? nil : "long"

                            }
                    }
                    Spacer()
                    Text("카테고리")
                        .font(.system(size:17, weight:.semibold))
                        .padding(.vertical, 20)
                    categoryBox(proxy: proxy, items: categoryArr)
                    Spacer()
                }
                .frame(width: proxy.size.width * 0.9, height: proxy.size.height * 0.9, alignment: .top)
                .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
            }
        }
            }
    static func makeCategoryData() -> [Categories]{
        [
        Categories(division: "education", isSelected: false),
        Categories(division: "travel", isSelected: false),
        Categories(division: "technology", isSelected: false),
        Categories(division: "news", isSelected: false),
        Categories(division: "nonprofit", isSelected: false)
        ]
    }
    
    private func categoryBox(proxy: GeometryProxy, items: [Categories]
) -> some View{
        VStack(spacing: 20){
            HStack{
                ForEach(0..<3, id:\.self){idx in
                    Text(items[idx].division)
                        .boxStyle(selected:items[idx].isSelected, proxy: proxy)
                        .onTapGesture {
                            categoryArr[idx].isSelected.toggle()
                        }
                }
            }
            HStack{
                ForEach(3..<items.count, id:\.self){idx in
                    Text(items[idx].division)
                        .boxStyle(selected:items[idx].isSelected, proxy: proxy)
                        .onTapGesture {
                            categoryArr[idx].isSelected.toggle()
                        }
                }
            }
        }
    }
    
    func findIdx(category: String, arr: [String]) -> Int {
        for idx in 0..<arr.count{
            if arr[idx] == category{
                    return idx
            }
        }
        return -1
    }
}

struct boxStyleModifier: ViewModifier{
    var selected: Bool
    var proxy: GeometryProxy
    func body(content: Content) -> some View{
        content
            .frame(width: proxy.size.width * 0.3 , height: proxy.size.height * 0.1)
            .background(selected ? Color.customBlack : .white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(selected ? .white : .customBlack)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.customBlack.opacity(0.3), lineWidth: 1))

    }
}

extension View{
    func boxStyle(selected: Bool, proxy: GeometryProxy) ->some View{
        modifier(boxStyleModifier(selected: selected, proxy: proxy))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
