//
//  ContentView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLaunched") var isLaunched = !UserDefaults.standard.bool(forKey: "isLaunched")
    @StateObject var store = Store()
    var body: some View {
//        if isLaunched{
//            FirstSettingView(isLaunched: self.$isLaunched)
//        }
//        else{
//        TabView{
//            MainView()
//                .tabItem{
//                    Image(systemName: "house")
//                }
//            RecordCategoryView()
//                .tabItem{
//                    Image(systemName: "books.vertical")
//                }
//            SettingView()
//                .tabItem{
//                    Image(systemName: "gearshape")
//                }
//        }
//        }
        TabView{
            MainView()
                .tabItem{
                    Image(systemName: "house")
                }
            RecordCategoryView()
                .tabItem{
                    Image(systemName: "books.vertical")
                }
            SettingView()
                .tabItem{
                    Image(systemName: "gearshape")
                }
            FirstSettingView()
                .tabItem{
                    Image(systemName: "gearshape")
                }
        }        .fullScreenCover(isPresented: self.$isLaunched){
            FirstSettingView()

        }    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
