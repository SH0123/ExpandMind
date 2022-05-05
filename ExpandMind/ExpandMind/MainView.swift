//
//  MainView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI

struct MainView: View {
    @State private var writeStart = false
    @State private var fill:CGFloat = 0.5
    @AppStorage("count") var count = UserDefaults.standard.integer(forKey: "count")
    @AppStorage("howMany") var howMany = UserDefaults.standard.integer(forKey:"howMany") == 0 ? 1 : UserDefaults.standard.integer(forKey:"howMany")
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.bgColor
                    .ignoresSafeArea()
                VStack{
                    inner
                        .onTapGesture {
                            self.writeStart = true
                        }.disabled(count == howMany)
                    
                    
                    NavigationLink("", destination: VideoView(writeStart: self.$writeStart), isActive: self.$writeStart
                    )            }
            }
        }
                
    }
 

    var inner: some View{
        VStack{
            VStack{
                if count == howMany{
                    Text("다음주에 만나요")
                        .font(.title2)
                }
                else{
                    Group{
                        Text("화면을 탭해서")
                            .padding(.bottom, 5)
                        Text("생각의 틀을 넓혀보세요")
                    }
                    .font(.title3)
                }
            }
            ZStack{
                Circle()
                    .stroke(Color.customBlack.opacity(0.3),
                            lineWidth: 10)
                                    Circle()
                    .trim(from: 0, to: CGFloat(count)/CGFloat(howMany))
                    .stroke(Color.customBlack, lineWidth: 10)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear, value: self.fill)
                Text("\(Int(round((Float(count)/Float(howMany)*100))))%")
                    .foregroundColor(.customBlack)
                    .font(.system(size: 30))
            }
            .frame(width: 300, height: 300)
            .padding(50)
                    
        }
        .foregroundColor(.customBlack)
    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
