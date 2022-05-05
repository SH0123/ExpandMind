//
//  VideoModel.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/03.
//

import Foundation
import UIKit

struct VideoModel: Codable{
    var items: [Item]

}
struct Item: Codable{
    var id: ID
    var snippet: Snippet


}
struct ID: Codable{
    var kind: String
    var videoId: String
}

struct Snippet: Codable{
    var title: String
    var publishTime: String
}

struct VideoCategoryModel: Decodable{
    var items: [Item2]
}

struct Item2: Decodable{
    var id: String
    var snippet: Snippet2
}
struct Snippet2: Decodable{
    var categoryId: String
}




//리팩토링 다시 해보기
//struct VideoCategoryModel: Decodable{
//    let categoryId: String
//
//    enum CodingKeys: CodingKey{
//        case items
//        case snippet
//        case categoryId
//    }
//
//    init(from decoder: Decoder)throws{
//        self.categoryId = try decoder.container(keyedBy: CodingKeys.self).nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet).decode(String.self, forKey: .categoryId)
//    }
//}
//


