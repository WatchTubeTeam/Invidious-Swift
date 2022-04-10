//
//  API.swift
//  Invidious-Swift
//
//  Created by llsc12 on 10/04/2022.
//

import Foundation

public struct inv {
    // MARK: - Package stuff
    static func setInstance(url: URL) async -> Bool {
        return false
    }
    
    // MARK: - Endpoint Wrapping
    
    static func stats() async -> Stats! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: instance.appendingPathComponent("api/v1/stats"))
            let stats = try? JSONDecoder().decode(Stats.self, from: data)
            return stats
            
        } catch {
            return nil
        }
    }
    
    static func video(id: String, cc: String? = nil) async -> Video! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        do {
            let url: URL = instance.appendingPathComponent(cc == nil ? "api/v1/videos/\(id)" : "api/v1/videos/\(id)?cc=\(cc ?? "us")")
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let video = try? JSONDecoder().decode(Video.self, from: data)

            return video
        } catch {
            return nil
        }
    }
    
    static func comments(id: String, continuation: String? = nil, sortby: SortByTypes? = nil, source: CommentSources? = nil) async -> Comments! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/comments/\(id)")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            if (continuation != nil) {
                mutableURL.queryItems?.append(URLQueryItem(name: "continuation", value: continuation))
            }
            if (sortby != nil) {
                mutableURL.queryItems?.append(URLQueryItem(name: "sort_by", value: sortby?.rawValue))
            }
            if (source != nil) {
                mutableURL.queryItems?.append(URLQueryItem(name: "source", value: source?.rawValue))
            }
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let comments = try? JSONDecoder().decode(Comments.self, from: data)
            return comments
        } catch {
            return nil
        }
    }
    
    static func captions(id: String) async -> Captions! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            let url = instance.appendingPathComponent("api/v1/captions/\(id)")
            let (data, _) = try await URLSession.shared.data(from: url)
            let captions = try? JSONDecoder().decode(Captions.self, from: data)
            return captions
        } catch {
            return nil
        }
    }
    
    static func trending(cc: String? = nil) async -> Trending! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            let url = instance.appendingPathComponent(cc == nil ? "api/v1/trending" : "api/v1/trending?cc=\(cc ?? "us")")
            let (data, _) = try await URLSession.shared.data(from: url)
            let trending = try? JSONDecoder().decode(Trending.self, from: data)
            return trending
        } catch {
            return nil
        }
    }
}

enum SortByTypes: String {
    case top = "top"
    case new = "new"
}
enum CommentSources: String {
    case youtube = "youtube"
    case reddit = "reddit"
}
