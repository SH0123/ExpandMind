//
//  WriteModal.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/01.
//

import SwiftUI

struct WriteModal: View {
    @Binding var modalOn: Bool
    @Binding var selected: Record
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView{
        ZStack{
            Color.bgColor.ignoresSafeArea()
            GeometryReader{proxy in
                ScrollView(showsIndicators: false){
                VStack(alignment: HorizontalAlignment.leading){
                    HStack(alignment: .top){
                        Text("제목")
                        Text(selected.title)
                    }
                .padding(.vertical, 10)
                HStack(alignment:.top){
                        Text("날짜")
                        Text(selected.date)
                    }
                .padding(.vertical, 10)
                    Link("영상 보러가기", destination:URL(string: "https://www.youtube.com/watch?v=\(selected.id)")!)
                        .foregroundColor(.blue)
                    .padding(.vertical, 10)
                    VStack(alignment: .leading){
                        Text("요약 정리")
                            .padding(.vertical, 10)
                        Text(selected.summary)
                    }
                    .padding(.vertical, 10)
                    VStack(alignment: .leading){
                        Text("영상에 대한 내 생각")
                            .padding(.vertical, 10)
                        Text(selected.thoughts)
                    }
                }
                }
            .foregroundColor(.customBlack)
            .frame(width: proxy.size.width*0.9, alignment: .topLeading)
            .padding(.horizontal, 20)
            //.position(x:proxy.size.width / 2, y:proxy.size.height * 1/2)
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(action:{
                    print("toggle")
                }){
                Image(systemName: selected.isBookmarked ? "bookmark.fill" : "bookmark")
                }
                .tint(.customBlack)
            }
            ToolbarItem(placement:.navigationBarTrailing){
                Button(action:{
                    dismiss()
                }){
                    Text("닫기")
                }
                .tint(.customBlack)
            }
        }
    }
    }
}

struct WriteModal_Previews: PreviewProvider {
    static var previews: some View {
        WriteModal(modalOn: .constant(true), selected: .constant(Record(id: "KLe7Rxkrj94", division: "news", date: "2022. 03. 13", title: "더 락 당신은 누구인가? 당신의 그 에너지는 어디에서 흘러나오는가?", summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", thoughts: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", isBookmarked: false)))
    }
}
