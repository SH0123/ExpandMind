//
//  WriteModal.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/01.
//

import SwiftUI

struct WriteModal: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Binding var modalOn: Bool
    @Binding var selected: VideoWriting?
    @Environment(\.dismiss) private var dismiss
    let defaultLink = "091Mdv_Rjb4&t=1230s"
    
    var body: some View {
        NavigationView{
        ZStack{
            Color.bgColor.ignoresSafeArea()
            GeometryReader{proxy in
                ScrollView(showsIndicators: false){
                VStack(alignment: HorizontalAlignment.leading){
                    HStack(alignment: .top){
                        Text("제목")
                            .font(.system(size:17, weight:.semibold))
                        Text(selected?.title ?? "제목 없음")
                    }
                .padding(.vertical, 10)
                HStack(alignment:.top){
                        Text("날짜")
                        .font(.system(size:17, weight:.semibold))
                        Text(selected?.date ?? "날짜 없음")
                    }
                .padding(.vertical, 10)
                    Link(destination:URL(string: "https://www.youtube.com/watch?v=\(selected?.id ?? defaultLink)")!){
                        Text("영상 보러 가기")
                            .font(.system(size:17, weight:.semibold))
                    }
                        .foregroundColor(.blue)
                    .padding(.vertical, 10)
                    VStack(alignment: .leading){
                        Text("요약 정리")
                            .font(.system(size:17, weight:.semibold))
                            .padding(.vertical, 10)
                        Text(selected?.summary ?? "요약 없음")
                    }
                    .padding(.vertical, 10)
                    VStack(alignment: .leading){
                        Text("영상에 대한 내 생각")
                            .font(.system(size:17, weight:.semibold))
                            .padding(.vertical, 10)
                        Text(selected?.thoughts ?? "생각 없음")
                    }
                }
                }
            .foregroundColor(.customBlack)
            .frame(width: proxy.size.width*0.9, alignment: .topLeading)
            .padding(.horizontal, 20)
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(action:{
                    selected?.isBookmarked.toggle()
                    CoreDataViewModel().saveContext(context: managedObjContext)
                }){
                Image(systemName: (selected?.isBookmarked ?? true) ? "bookmark.fill" : "bookmark")
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

