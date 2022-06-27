//
//  File.swift
//  
//
//  Created by llsc12 on 26/06/2022.
//

import Foundation

public extension InvVideoThumbnail {
    var source: String {
        let src = URLComponents(string: self.url)
        let ytHost = URL(string: "https://i.ytimg.com/")
        let id = src!.url!.pathComponents.dropFirst()[2]
        let finalurl = URL(string: "/vi/\(id)/maxresdefault.jpg", relativeTo: ytHost)
        return finalurl!.absoluteString
    }
}
