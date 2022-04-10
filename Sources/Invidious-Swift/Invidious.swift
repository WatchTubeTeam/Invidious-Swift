//
//  API.swift
//  Invidious-Swift
//
//  Created by llsc12 on 10/04/2022.
//

import Foundation

public struct inv {
    // MARK: - Package stuff
    static public func setInstance(url: URL) async -> Bool {
        return false
    }
    
    // MARK: - Endpoint - Stats
    static public func stats() async -> Stats! {
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
    
    // MARK: - Endpoint - Video
    static public func video(id: String, cc: String? = nil) async -> Video! {
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
    
    // MARK: - Endpoint - Comments
    static public func comments(id: String, continuation: String? = nil, sortby: SortByTypes? = nil, source: CommentSources? = nil) async -> Comments! {
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
    
    // MARK: - Endpoint - Captions
    static public func captions(id: String) async -> Captions! {
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
    
    
    
    // MARK: - Endpoint - Trending
    static public func trending(cc: String? = nil, type: TrendingTypes? = .none) async -> Trending! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/trending")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            if (cc != nil) {
                mutableURL.queryItems?.append(URLQueryItem(name: "cc", value: cc))
            }
            if (type != nil) {
                mutableURL.queryItems?.append(URLQueryItem(name: "type", value: type?.rawValue))
            }
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let trending = try? JSONDecoder().decode(Trending.self, from: data)
            return trending
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Popular
    static public func popular() async -> Popular! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            let url = instance.appendingPathComponent("api/v1/popular")
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let popular = try? JSONDecoder().decode(Popular.self, from: data)
            return popular
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Channel
    static public func channel(udid: String, sortby: ChannelSortByTypes? = .none) async -> Channel! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/channels/\(udid)")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            
            if (sortby != nil) {
                mutableURL.queryItems?.append(URLQueryItem(name: "sort_by", value: sortby?.rawValue))
            }
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let channel = try? JSONDecoder().decode(Channel.self, from: data)
            return channel
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Channel videos
    static public func channelVideos(udid: String, page: Int = 1, sortby: ChannelSortByTypes? = .none) async -> Channel! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/channels/videos/\(udid)")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            
            if (sortby != nil) {
                mutableURL.queryItems?.append(URLQueryItem(name: "sort_by", value: sortby?.rawValue))
            }
            mutableURL.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let channel = try? JSONDecoder().decode(Channel.self, from: data)
            return channel
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Search
    static public func search(q: String, page: Int = 1) async -> Search! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/search")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            mutableURL.queryItems?.append(URLQueryItem(name: "q", value: q))
            mutableURL.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let search = try? JSONDecoder().decode(Search.self, from: data)
            return search
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Search Suggestions
    static public func searchSuggestions(q: String) async -> Suggestions! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/search/suggestions")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            mutableURL.queryItems?.append(URLQueryItem(name: "q", value: q))
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let suggest = try? JSONDecoder().decode(Suggestions.self, from: data)
            return suggest
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Playlist
    static public func playlist(plid: String, page: Int) async -> Playlist! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/playlists/\(plid)")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            mutableURL.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let playlist = try? JSONDecoder().decode(Playlist.self, from: data)
            return playlist
        } catch {
            return nil
        }
    }
    
    // MARK: - End of Endpoints
}

// MARK: - Enums - for parameters of endpoints

public enum SortByTypes: String {
    case top = "top"
    case new = "new"
}
public enum CommentSources: String {
    case youtube = "youtube"
    case reddit = "reddit"
}
public enum TrendingTypes: String {
    case music = "music"
    case gaming = "gaming"
    case news = "news"
    case movies = "movies"
}
public enum ChannelSortByTypes: String {
    case newest = "newest"
    case oldest = "oldest"
    case popular = "popular"
}
