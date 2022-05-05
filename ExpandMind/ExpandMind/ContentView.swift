//
//  ContentView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI

struct ContentView: View {
    var network = Network()
    @AppStorage("isLaunched") var isLaunched = !UserDefaults.standard.bool(forKey: "isLaunched")
    
    var body: some View {
        TabView{
            MainView()
                .tabItem{
                    Image(systemName: "house")
                }                .environmentObject(network)
            RecordCategoryView()
                .tabItem{
                    Image(systemName: "books.vertical")
                }
            SettingView()
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
