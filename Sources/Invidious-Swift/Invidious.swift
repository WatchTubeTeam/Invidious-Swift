//
//  API.swift
//  Invidious-Swift
//
//  Created by llsc12 on 10/04/2022.
//

import Foundation

/// Structure containing all API interaction functions and other utilities
/// > Every exposed endpoint here returns an optional. If any issues of any type occur, you will receive `nil`
public struct inv {
    
    static public var Timeout: Double = 15
    
    // MARK: - Package stuff
    /// Package function to change the instance being used.
    /// # Usage
    /// ```swift
    ///
    /// await inv.setInstance(url: URL(string: "https://invidious.osi.kr")!)
    /// // This function will return a Bool depending on the selftest result
    /// // If you receive false, the instance was not set as the selftest failed
    ///
    /// // You may skip the check like this
    /// await inv.setInstance(url: URL(string: "https://invidious.osi.kr")!, skipCheck: true)
    ///
    /// ```
    /// - Parameter url: A URL to the instance you wish to use
    /// - Returns: Returns a boolean indicating if the instance was set sucessfully
    static public func setInstance(url: URL, skipCheck: Bool = false) async -> Bool {
        do {
            if skipCheck {
                UserDefaults.standard.set(url.absoluteString, forKey: "InvidiousInstanceURL")
                return true
            } else {
                let test = url.appendingPathComponent("api/v1/trending")
                let req = URLRequest(url: test, timeoutInterval: Timeout)
                let (data, _) = try await URLSession.shared.data(for: req)
                let trending = try? JSONDecoder().decode(InvTrending.self, from: data)
                if trending == nil { return false }
                UserDefaults.standard.set(url.absoluteString, forKey: "InvidiousInstanceURL")
                return true
            }
        } catch {
            return false
        }
    }
    
    static public func internalCaching(_ cache: Bool) {
        UserDefaults.standard.set(cache, forKey: "InvidiousInternalCaching")
    }
    
    // MARK: - Endpoint - Stats
    /// Provides information about the current instance
    /// # Usage
    /// ```
    ///
    /// let stats = await inv.stats()
    /// print(stats?.version) // Prints "2.0" (at time of writing)
    ///
    /// ```
    /// - Returns: instance data
    static public func stats() async -> InvStats! {
        let stats = await fetch(InvStats.self, "stats")
        return stats
    }
    
    // MARK: - Endpoint - Video
    /// Retrieves data of any given video
    /// # Usage
    /// ```
    ///
    /// let video = await inv.video("o5RhbG3tOT8")
    /// print(video?.title) // Prints "The Raid - Animation vs. Minecraft Shorts Ep. 28"
    ///
    /// ```
    /// - Parameters:
    ///   - id: The ID of the video
    ///   - cc: Country code to use
    /// - Returns: All of the video data
    static public func video(id: String, cc: String? = nil) async -> InvVideo! {
        var params = [URLQueryItem]()
        if cc != nil { params.append(URLQueryItem(name: "cc", value: cc))}
        let vid = await fetch(InvVideo.self, "videos/\(id)", params: params)
        return vid
    }
    
    // MARK: - Endpoint - Comments
    /// An extendable structure of comments of any given video
    /// - Parameters:
    ///   - id: ID of the video
    ///   - continuation: A continuation string from a previous request to get the next set of comments
    ///   - sortby: What to sort the comments by
    ///   - source: Sources Reddit or YouTube comments
    /// - Returns: A structure containing comments data
    static public func comments(id: String, continuation: String? = nil, sortby: CommentSortByType? = nil, source: CommentSource? = nil) async -> InvComments! {
        var queryitems = [URLQueryItem]()
        if (continuation != nil) {
            queryitems.append(URLQueryItem(name: "continuation", value: continuation))
        }
        if (sortby != nil) {
            queryitems.append(URLQueryItem(name: "sort_by", value: sortby?.rawValue))
        }
        if (source != nil) {
            queryitems.append(URLQueryItem(name: "source", value: source?.rawValue))
        }
        let comments = await fetch(InvComments.self, "comments/\(id)", params: queryitems)
        return comments
    }
    
    // MARK: - Endpoint - Captions
    /// Provides captions data for any video
    /// - Parameter id: ID of the video
    /// - Returns: Available captions along with a helper extension to generate a subtitle set for you
    static public func captions(id: String) async -> InvCaptions! {
        let captions = await fetch(InvCaptions.self, "captions/\(id)")
        return captions
    }
    
    // MARK: - Endpoint - Trending
    /// Gets the latest trending data from YouTube
    /// - Parameters:
    ///   - cc: Country code to get data for different countries
    ///   - type: Category of video types to get
    /// - Returns: An array of trending videos
    static public func trending(cc: String? = nil, type: TrendingType? = .none) async -> InvTrending! {
        var queryitems = [URLQueryItem]()
        if (cc != nil) {
            queryitems.append(URLQueryItem(name: "cc", value: cc))
        }
        if (type != nil) {
            queryitems.append(URLQueryItem(name: "type", value: type?.rawValue))
        }
        let trending = await fetch(InvTrending.self, "trending", params: queryitems)
        return trending
    }
    
    // MARK: - Endpoint - Popular
    /// Returns popular videos from YouTube
    /// - Returns: An array of popular  videos
    static public func popular() async -> InvPopular! {
        let popular = await fetch(InvPopular.self, "popular")
        return popular
    }
    
    // MARK: - Endpoint - Channel
    /// Get a channel's data
    /// - Parameters:
    ///   - udid: UDID of the channel
    ///   - sortby: What to sort the videos array by
    /// - Returns: All of the channel's data along with a video array
    static public func channel(udid: String, sortby: ChannelSortByType? = .none) async -> InvChannel! {
        var queryitems = [URLQueryItem]()
        if (sortby != .none) {
            queryitems.append(URLQueryItem(name: "sort_by", value: sortby?.rawValue))
        }
        let channel = await fetch(InvChannel.self, "channels/\(udid)", params: queryitems)
        return channel
    }
    
    // MARK: - Endpoint - Channel videos
    /// Get the videos of a channel
    /// - Parameters:
    ///   - udid: UDID of the channel
    ///   - page: The page number
    ///   - sortby: What to sort the videos by
    /// - Returns: An array of the channel's videos
    static public func channelVideos(udid: String, page: Int = 1, sortby: ChannelSortByType? = .none) async -> InvChannelVideos! {
        var queryitems = [URLQueryItem]()
        if (sortby != .none) {
            queryitems.append(URLQueryItem(name: "sort_by", value: sortby?.rawValue))
        }
        queryitems.append(URLQueryItem(name: "page", value: String(page)))
        let chnlVideos = await fetch(InvChannelVideos.self, "channels/videos/\(udid)", params: queryitems)
        return chnlVideos
    }
    
    // MARK: - Endpoint - Search
    /// Searches YouTube for videos according to the query
    /// - Parameters:
    ///   - q: The query
    ///   - type: The type of content to filter out
    ///   - page: The page number
    /// - Returns: An array of different items, defined by the type property of the item
    static public func search(q: String, type: SearchType = .video, page: Int = 1) async -> InvSearch! {
        var queryitems = [URLQueryItem]()
        queryitems.append(URLQueryItem(name: "q", value: q))
        queryitems.append(URLQueryItem(name: "page", value: String(page)))
        queryitems.append(URLQueryItem(name: "type", value: type.rawValue))
        let search = await fetch(InvSearch.self, "search", params: queryitems)
        return search
    }
    
    // MARK: - Endpoint - Search Suggestions
    /// Search suggestions for the query being typed
    /// - Parameter q: The query
    /// - Returns: An array of suggestions
    static public func searchSuggestions(q: String) async -> InvSearchSuggestions! {
        var queryitems = [URLQueryItem]()
        queryitems.append(URLQueryItem(name: "q", value: q))
        let suggest = await fetch(InvSearchSuggestions.self, "search/suggestions", params: queryitems)
        return suggest
    }
    
    // MARK: - Endpoint - Playlist
    /// Retrive data about a playlist
    /// - Parameters:
    ///   - plid: PLID of the playlist
    ///   - page: The page number
    /// - Returns: Data of the playlist and an array of videos
    static public func playlist(plid: String, page: Int = 1) async -> InvPlaylist! {
        var queryitems = [URLQueryItem]()
        queryitems.append(URLQueryItem(name: "page", value: String(page)))
        let playlist = await fetch(InvPlaylist.self, "playlists/\(plid)", params: queryitems)
        return playlist
    }
    
    // MARK: - End of Endpoints
}

// MARK: - Enums - for parameters of endpoints

public enum CommentSortByType: String {
    case top = "top"
    case new = "new"
}
public enum CommentSource: String {
    case youtube = "youtube"
    case reddit = "reddit"
}
public enum TrendingType: String {
    case music = "music"
    case gaming = "gaming"
    case news = "news"
    case movies = "movies"
}
public enum ChannelSortByType: String {
    case newest = "newest"
    case oldest = "oldest"
    case popular = "popular"
}
public enum SearchType: String {
    case video = "video"
    case playlist = "playlist"
    case channel = "channel"
    case all = "all"
}

// MARK: - Private Stuff - for internal caching stuff

internal func cacheData(_ data: Data, _ name: String) {
    var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    try? FileManager.default.createDirectory(at: path!.appendingPathComponent("InvidiousSwiftWrapperCache/"), withIntermediateDirectories: true)
    path?.appendPathComponent("InvidiousSwiftWrapperCache/\(name)")
    try? data.write(to: path!)
}
internal func getData(_ name: String) -> Data! {
    var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    path?.appendPathComponent("InvidiousSwiftWrapperCache/\(name)")
    let data = try? Data(contentsOf: path!)
    return UserDefaults.standard.bool(forKey: "InvidiousInternalCaching") ? data : nil /// im sorry but i will always cache data even if you disable caching.
}

internal extension String {
    /// Returns a hash value that is reproducible across sessions.
    /// This doesn't need to be secure as we're just using the hash to lookup and store data
    var hashed: String {
        var result = UInt64 (5381)
        let buf = [UInt8](self.utf8)
        for b in buf {
            result = 127 * (result & 0x00ffffffffffffff) + UInt64(b)
        }
        return String(result) /// though if caching is off, i will not load any cached data.
    }
}

internal func fetch<T: Decodable>(_ T: T.Type, _ path: String, params: [URLQueryItem] = []) async -> T! {
    let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
    guard let instance = URL(string: instanceURLstring) else { return nil}
    do {
        var url = instance.appendingPathComponent("api/v1/\(path)")
        var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
        mutableURL.queryItems = params
        url = mutableURL.url!
        
        var data: Data = Data()
        
        let hash: String = {
            let path = url.pathComponents.joined(separator: "/")
            return path.hashed
        }()
        
        let cached = getData(hash)
        if cached != nil && Bool.random() { /// using random as a way to eventually update cached data
            if ( try? JSONDecoder().decode(T.self, from: data) ) != nil {
                data = cached!
            } else {
                let req = URLRequest(url: url, timeoutInterval: inv.Timeout)
                let (res, _) = try await URLSession.shared.data(for: req)
                data = res
                cacheData(res, hash)
            }
        } else {
            let req = URLRequest(url: url, timeoutInterval: inv.Timeout)
            let (res, _) = try await URLSession.shared.data(for: req)
            data = res
            cacheData(res, hash)
        }
        let final = try JSONDecoder().decode(T.self, from: data)
        return final
    } catch {
        print("[Inv-Wrapper] \(error)")
        return nil
    }
}
