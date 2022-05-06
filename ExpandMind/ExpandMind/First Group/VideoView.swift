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
    @State private var videoId: String = "oWL3kOxpXcw"
    @State private var isLoading: Bool = true
    @State var watchedVideoId = UserDefaults.standard.array(forKey:"watchedVideoId") ?? []
    @State var selectedDuration = UserDefaults.standard.string(forKey:"selectedDuration")
    @State var nowVideo: Item?
    var categories: [Categories] = [
        Categories(division: "travel", isSelected: false),
        Categories(division: "education", isSelected: true),
        Categories(division: "technology", isSelected: false),
        Categories(division: "news", isSelected: false),
        Categories(division: "nonprofit", isSelected: true)
    ]
    @Binding var writeStart: Bool
    @State var categoryId: String?

    var body: some View {
        ZStack{
            Color.bgColor
                .ignoresSafeArea()
            
            if isLoading{
                ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .customBlack))
                .padding()
            }
            else{
            GeometryReader{ g in
                VStack(alignment: .leading){
                    ZStack{
                    YoutubeView(videoID: self.$videoId)
                        .frame(height: g.size.height*0.3)
                    }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text(nowVideo?.snippet.title ?? "")
                        .font(.system(size:17, weight:.semibold))
                        .padding(.vertical, 10)
                    HStack{
                        Text(dateFormatter(inputDate: nowVideo?.snippet.publishTime ?? "2020-01-03"))

                        Spacer()
                        Button(action: {
                            while(true){
                                nowVideo = network.videos[Int.random(in:0..<100)]
                                let id = nowVideo?.id.videoId
                                if let watchedList = self.watchedVideoId as? [String]{
                                    if !watchedList.contains(id!){
                                        watchedVideoId.append(id!)
                                        self.videoId = id!
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
            
            
            .tint(.customBlack)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement:.navigationBarLeading){
                Button("이전"){
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink(destination: WriteView(writeStart: self.$writeStart, summary: self.summary, id: self.videoId, title: nowVideo?.snippet.title ?? "", categoryId: self.categoryId ?? "" )){
                    Text("다음")
                }
                .disabled(summary == "")
                
                
            }
        }
        .onAppear{
            
            network.getVideos(division: ["travel","news", "nonprofit","technology"], timeDuration: selectedDuration ?? "long"){
                print(network.videos.count)
                nowVideo = network.videos[Int.random(in: 0..<network.videos.count)]
                self.videoId = nowVideo?.id.videoId ?? "oWL3kOxpXcw"
                network.getVideoCategory(videoId: self.videoId){
                    self.categoryId = network.videoCategory
                    self.isLoading = false
                            }

            }
                }
        
    }
    func dateFormatter(inputDate: String) -> String{
        let formatter = DateFormatter()
        let convertFormat = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let convertDate = formatter.date(from: inputDate)
        convertFormat.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: convertDate!)
    }

    
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(writeStart: .constant(false))
            .environmentObject(Network())
    }
}
