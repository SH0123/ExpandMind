//
//  CategoryListView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/01.
//

import SwiftUI

struct CategoryListView: View {
    @EnvironmentObject var coreDataManager: CoreDataManager
    @Environment(\.dismiss) private var dismiss
    @State private var modalOn: Bool = false
    @State private var selected: Record = Record(id: "1i9kcBHX2Nw", division: "news", date: "2022. 03. 13", title: "스티브잡스 연설", summary: "내용 요약", thoughts: "내 생각 적기", isBookmarked: true)
    var category: String
    var recordsDummy: [Record] = makeMockData()
    var body: some View {
        ZStack{
            Color.bgColor.ignoresSafeArea()
            GeometryReader{proxy in
                VStack(alignment:.leading){
                    Text(category)
                        .font(.system(size:20, weight:.semibold))
                    ScrollView(showsIndicators: false){
                        ForEach(recordsDummy, id:\.self){record in
                            listRow(data: record, proxy: proxy)
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
    private func listRow(data: Record, proxy: GeometryProxy) -> some View{
        Button(action:{
            self.selected = data
            self.modalOn = true
        }){
            HStack{
                Image(systemName: data.isBookmarked ? "bookmark.fill" : "bookmark")
                    .padding(.horizontal, 10)
                Text(data.title)
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
