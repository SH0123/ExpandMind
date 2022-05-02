//
//  VideoView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI

struct VideoView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var summary: String = ""
    @State private var videoID: String = "oWL3kOxpXcw"
    @Binding var writeStart: Bool
    var body: some View {
        ZStack{
            Color.bgColor
                .ignoresSafeArea()
            GeometryReader{ g in
                VStack(alignment: .leading){
                    YoutubeView(videoID: self.$videoID)
                        .frame(height: g.size.height*0.3)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("각자도생의 시대, '인구'를 알아야 내일이 있다")
                    HStack{
                        Text("2022. 3. 14")
                        Spacer()
                        Button(action: {}){
                            Image(systemName: "shuffle")}
                    }
                    Divider()
                    Text("요약 정리")
                    ScrollView{
                        TextEditor(text: self.$summary)
                            .disableAutocorrection(true)
                            .foregroundColor(.customBlack)
                            .lineSpacing(5)
                            .frame(height: 350)
                            .border(Color.white)
                            .cornerRadius(10)
                        
                    }
                }
                .foregroundColor(.customBlack)
                .padding(.horizontal, 20)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement:.navigationBarLeading){
                    Button("이전"){
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: WriteView(writeStart: self.$writeStart)){
                        Text("다음")
                    }
                    .disabled(summary == "")
                    
                    
                }
            }
            .tint(.customBlack)
            
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(writeStart: .constant(false))
    }
}
