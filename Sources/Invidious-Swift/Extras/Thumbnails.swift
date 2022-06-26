//
//  File.swift
//  
//
//  Created by llsc12 on 26/06/2022.
//

import Foundation

extension InvVideoThumbnail {
    var source: String {
        let src = URL(string: self.url)
        let ytHost = URL(string: "https://i.ytimg.com/")
        let finalurl = URL(string: src!.path, relativeTo: ytHost)
    }
}
