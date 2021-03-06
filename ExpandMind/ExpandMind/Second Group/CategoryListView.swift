//
//  CategoryListView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/01.
//

import SwiftUI

struct CategoryListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var modalOn: Bool = false
    @State private var selected: VideoWriting?
    var lists: [VideoWriting] = []
    var category: String
    var recordsDummy: [Record] = makeMockData()
    let eng2kor: [String: String] = ["bookmark" : "북마크", "travel" : "여행", "education" :"교육", "technology" : "과학&기술", "nonprofit" : "비영리", "news" : "정치&뉴스", "extra" : "기타"]
    var body: some View {
        ZStack{
            Color.bgColor.ignoresSafeArea()
            GeometryReader{proxy in
                VStack(alignment:.leading){
                    Text(eng2kor[category]!)
                        .font(.system(size:20, weight:.semibold))
                    ScrollView(showsIndicators: false){
                        ForEach(lists, id:\.self){list in
                            listRow(data: list, proxy: proxy)
                        }
                    }
                    
                }.position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                    .sheet(isPresented: self.$modalOn){
                        WriteModal(modalOn: self.$modalOn, selected: self.$selected)
                    }
            }
            .foregroundColor(.customBlack)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button("이전"){
                    dismiss()
                }
            }
        }
        .tint(.customBlack)

    }
    private func listRow(data: VideoWriting, proxy: GeometryProxy) -> some View{
        Button(action:{
            self.selected = data
            self.modalOn = true
        }){
            HStack{
                Image(systemName: data.isBookmarked ? "bookmark.fill" : "bookmark")
                    .padding(.horizontal, 10)
                Text(data.title ?? "제목없음")
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .frame(width: proxy.size.width*0.9, height: proxy.size.width * 0.25)
        .background(.white)
        .cornerRadius(10)
        .shadow(color:.customBlack, radius:1, x:2, y:2 )
        .padding(.vertical, 5)
        .padding(.horizontal, 5)
    }
}


struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(category: "북마크")
    }
}
