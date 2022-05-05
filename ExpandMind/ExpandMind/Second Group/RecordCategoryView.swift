//
//  RecordCategoryView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI

struct RecordCategoryView: View {
    @State private var goDetail: Bool = false
    @State private var selectedCategory: String = "" // 이게 맞을까?
    let twoColumnGrid: [GridItem] = Array(repeating: .init(.flexible(),spacing:10), count: 2)
    let categories: [String] = ["bookmark", "travel","education", "news", "technology", "nonprofit"]
    let eng2kor: [String: String] = ["bookmark" : "북마크", "travel" : "여행", "education" :"교육", "technology" : "과학&기술", "nonprofit" : "비영리", "news" : "뉴스&시사"]
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.bgColor.ignoresSafeArea()
                GeometryReader{ proxy in
                    VStack(alignment:.leading){
                    Text("카테고리")
                            .font(.system(size:20, weight:.semibold))
                            .padding(.bottom, 10)
                            .foregroundColor(.customBlack)
                    ScrollView(showsIndicators: false){
                        LazyVGrid(columns: twoColumnGrid, spacing: 20){
                            ForEach(0..<categories.count ,id:\.self){idx in
                                card(name: categories[idx], proxy: proxy)
                            }
                        }
                    }
                
                }
                .padding(.horizontal, 20)
                }
            }
        }
    }
        private func card(name: String, proxy: GeometryProxy) -> some View{
            Button(action:{
                self.goDetail.toggle()
                self.selectedCategory = eng2kor[name]!
                
            }){
                VStack{
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: proxy.size.width * 0.35, height: proxy.size.height * 0.3)
                    Text(eng2kor[name] ?? "북마크")
                        .font(.system(size:17, weight:.semibold))
                        .foregroundColor(.customBlack)
                    NavigationLink("", destination: CategoryListView(category: self.selectedCategory), isActive: self.$goDetail)
                }
            }
            .frame(width: proxy.size.width * 0.4, height: proxy.size.height * 0.35)
            .background(.white)
            .cornerRadius(10)
            .shadow(color:.customBlack, radius:1, x:2, y:2)
        }
    
}
struct RecordCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        RecordCategoryView()
    }
}
