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




