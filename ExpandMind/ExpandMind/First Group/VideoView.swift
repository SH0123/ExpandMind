//
//  VideoView.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/04/28.
//

import SwiftUI

struct VideoView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var network: Network
    @State private var summary: String = ""
    @State private var videoID: String = "oWL3kOxpXcw"
    @State private var shouldAnimate: Bool = true
    @State var watchedVideoId = UserDefaults.standard.array(forKey:"watchedVideoId") ?? []
    @State var selectedDuration = UserDefaults.standard.string(forKey:"selectedDuration")
    var categories: [Categories] = [
        Categories(division: "travel", isSelected: false),
        Categories(division: "education", isSelected: true),
        Categories(division: "technology", isSelected: false),
        Categories(division: "news", isSelected: false),
        Categories(division: "nonprofit", isSelected: true)
    ]
    @Binding var writeStart: Bool
    var categoryId: String?
    var randInt: Int = Int.random(in: 0..<30)
    
    var body: some View {
        ZStack{
            Color.bgColor
                .ignoresSafeArea()
            GeometryReader{ g in
                VStack(alignment: .leading){
                    ZStack{
                    YoutubeView(videoID: self.$videoID)
                        .frame(height: g.size.height*0.3)
                    }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("각자도생의 시대, '인구'를 알아야 내일이 있다")
                        .font(.system(size:17, weight:.semibold))
                        .padding(.vertical, 10)
                    HStack{
                        Text("2022. 3. 14")

                        Spacer()
                        Button(action: {
                            while(true){
                                let id = network.videos[Int.random(in:0..<100)].id.videoId
                                if let watchedList = self.watchedVideoId as? [String]{
                                    if !watchedList.contains(id){
                                        watchedVideoId.append(id)
                                        videoID = id
                                        break
                                    }
                                }                            }
                        }){
                            Image(systemName: "shuffle")}
                    }
                    Divider()
                    Text("요약 정리")
                        .font(.system(size:17, weight:.semibold))

                        .padding(.vertical, 5)
                        TextEditor(text: self.$summary)
                            .disableAutocorrection(true)
                            .foregroundColor(.customBlack)
                            .lineSpacing(5)
                            .frame(height: 350)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.customBlack.opacity(0.3), lineWidth: 1))


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
                    NavigationLink(destination: WriteView(writeStart: self.$writeStart, summary: self.summary, id: self.videoID, title: "title" , categoryId: "23324" )){
                        Text("다음")
                    }
                    .disabled(summary == "")
                    
                    
                }
            }
            .tint(.customBlack)
                        
        }.onAppear{
            
            //network.getVideos(division: ["travel", "nonprofit"], timeDuration: selectedDuration ?? "any"){
                //print("---------------")
                //print(network.videos[randInt].id.videoId)
               // print(randInt)
            //}
                }
        
        
        //동기적으로 처리하고 싶다.
        //videos 받아와서 radom값으로 비디오 고르고, 이미 봤던 비디오인지 확인
        //본 적 없는 비디오라면 영상 재생
        //데이터 받아오기까지 activity view, 데이터 받아온 뒤에는 loading 화면 사라짐
        
    }
    
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(writeStart: .constant(false))
            .environmentObject(Network())
    }
}
