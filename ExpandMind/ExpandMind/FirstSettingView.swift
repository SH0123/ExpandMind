//
//  FirstSettingView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/02.
//

import SwiftUI

struct FirstSettingView: View {
    @State private var selected = 0
    @Environment(\.dismiss) private var dismiss
    @AppStorage("howMany") var howMany = UserDefaults.standard.integer(forKey: "howMany")
    @AppStorage("isLaunched") var isLaunched = UserDefaults.standard.bool(forKey: "isLaunched")
    //@EnvironmentObject var store: Store
    var howManyArr: [Int] = [1, 2, 3, 4, 5, 6, 7]
    var body: some View {
        ZStack{
            Color.bgColor.ignoresSafeArea()
            VStack{
                Spacer()
                Text("1주일에 몇 회 글을 쓸까요?")
                Spacer()
                Picker("몇회", selection: self.$howMany){
                    ForEach(howManyArr, id:\.self){num in
                        Text("\(num)회")
                    }
                }
                Spacer()
                Button(action:{
                    isLaunched = true
                    dismiss()
                }){
                    Text("완료")
                        .frame(width: 100, height: 50)
                        .background(Color.customBlack)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                }
                Spacer()
                            }
            .pickerStyle(WheelPickerStyle())
        }
    }
}

struct FirstSettingView_Previews: PreviewProvider {
    static var previews: some View {
        FirstSettingView()
    }
}
