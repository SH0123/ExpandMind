//
//  Network.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/03.
//

import Foundation

class Network: ObservableObject{
    @Published var videos: [Item] = []

    private func name2num(division: String)->Int{
        switch division{
        case "technology":
            return 28
        case "news":
            return 25
        case "nonprofit":
            return 29
        default:
            return 0
        }

    }
    
    func getVideos(
        division: [String],
        timeDuration: String,
        completionHandler: @escaping () -> Void
    ){
        for category in division{
        var components = URLComponents(string: "https://www.googleapis.com/youtube/v3/search")
        let privateKey = URLQueryItem(name:"key", value:"AIzaSyCcyPBM6KPJCXsJ1U56ZYccNk5swOhaJ14")
        let part = URLQueryItem(name:"part", value: "snippet")
        let type = URLQueryItem(name:"type", value: "video")
        let regionCode = URLQueryItem(name:"regionCode", value: "KR")
        let order = URLQueryItem(name:"order", value: "viewCount")
        let videoEmbeddable = URLQueryItem(name:"videoEmbeddable", value: "true")
        let maxResults = URLQueryItem(name:"maxResults", value: "50")
        let safeSearch = URLQueryItem(name:"safeSearch", value: "strict")
        let videoDuration = URLQueryItem(name:"videoDuration", value: timeDuration)
        
        
            switch category{
            case "technology", "news", "nonprofit" :
                let videoCategoryId = URLQueryItem(name:"videoCategoryId", value: "\(name2num(division:category))") // value 값 변경
                components?.queryItems = [privateKey, part, type, regionCode, order, videoCategoryId, videoEmbeddable, maxResults, safeSearch, videoDuration]
            case "travel":
                    let q = URLQueryItem(name:"q", value: "여행")
                components?.queryItems = [privateKey, part, type, regionCode, order, q, videoEmbeddable, maxResults, safeSearch, videoDuration]
            default:
                let q = URLQueryItem(name:"q", value: "교육")
                components?.queryItems = [privateKey, part, type, regionCode, order, q, videoEmbeddable, maxResults, safeSearch, videoDuration]
            }
        
                        
        guard let url = components?.url else{fatalError("MISSING URL")}
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest){(data, response, error) in
            if let error = error{
                print("Request Error", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else{return}
            if response.statusCode == 200{
                guard let data = data else{return}
                DispatchQueue.main.async{
                    do{
                        let decodedVideos = try JSONDecoder().decode(VideoModel.self, from: data)
                        self.videos += decodedVideos.items
                        print(decodedVideos)
                        completionHandler()
                    }catch let error{
                        print("Error Decoding", error)
                    }
                }
            }
        }
        
        dataTask.resume()
        }
        
            }
    }
