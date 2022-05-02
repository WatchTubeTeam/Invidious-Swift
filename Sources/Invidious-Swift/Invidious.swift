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
                let (data, _) = try await URLSession.shared.data(from: test)
                let trending = try? JSONDecoder().decode(InvTrending.self, from: data)
                if trending == nil { return false }
                UserDefaults.standard.set(url.absoluteString, forKey: "InvidiousInstanceURL")
                return true
            }
        } catch {
            return false
        }
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
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: instance.appendingPathComponent("api/v1/stats"))
            let stats = try? JSONDecoder().decode(InvStats.self, from: data)
            return stats
            
        } catch {
            return nil
        }
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
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        do {
            let url: URL = instance.appendingPathComponent(cc == nil ? "api/v1/videos/\(id)" : "api/v1/videos/\(id)?cc=\(cc ?? "us")")
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let video = try? JSONDecoder().decode(InvVideo.self, from: data)

            return video
        } catch {
            return nil
        }
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
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/comments/\(id)")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
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
            mutableURL.queryItems = queryitems
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let comments = try? JSONDecoder().decode(InvComments.self, from: data)
            return comments
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Captions
    /// Provides captions data for any video
    /// - Parameter id: ID of the video
    /// - Returns: Available captions along with a helper extension to generate a subtitle set for you
    static public func captions(id: String) async -> InvCaptions! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            let url = instance.appendingPathComponent("api/v1/captions/\(id)")
            let (data, _) = try await URLSession.shared.data(from: url)
            let captions = try? JSONDecoder().decode(InvCaptions.self, from: data)
            return captions
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Trending
    /// Gets the latest trending data from YouTube
    /// - Parameters:
    ///   - cc: Country code to get data for different countries
    ///   - type: Category of video types to get
    /// - Returns: An array of trending videos
    static public func trending(cc: String? = nil, type: TrendingType? = .none) async -> InvTrending! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/trending")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            var queryitems = [URLQueryItem]()
            if (cc != nil) {
                queryitems.append(URLQueryItem(name: "cc", value: cc))
            }
            if (type != nil) {
                queryitems.append(URLQueryItem(name: "type", value: type?.rawValue))
            }
            mutableURL.queryItems = queryitems
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let trending = try? JSONDecoder().decode(InvTrending.self, from: data)
            return trending
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Popular
    /// Returns popular videos from YouTube
    /// - Returns: An array of popular  videos
    static public func popular() async -> InvPopular! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            let url = instance.appendingPathComponent("api/v1/popular")
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let popular = try? JSONDecoder().decode(InvPopular.self, from: data)
            return popular
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Channel
    /// Get a channel's data
    /// - Parameters:
    ///   - udid: UDID of the channel
    ///   - sortby: What to sort the videos array by
    /// - Returns: All of the channel's data along with a video array
    static public func channel(udid: String, sortby: ChannelSortByType? = .none) async -> InvChannel! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/channels/\(udid)")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            
            if (sortby != nil) {
                mutableURL.queryItems = [URLQueryItem(name: "sort_by", value: sortby?.rawValue)]
            }
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let channel = try? JSONDecoder().decode(InvChannel.self, from: data)
            return channel
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Channel videos
    /// Get the videos of a channel
    /// - Parameters:
    ///   - udid: UDID of the channel
    ///   - page: The page number
    ///   - sortby: What to sort the videos by
    /// - Returns: An array of the channel's videos
    static public func channelVideos(udid: String, page: Int = 1, sortby: ChannelSortByType? = .none) async -> InvChannelVideos! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/channels/videos/\(udid)")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            var queryitems = [URLQueryItem]()
            if (sortby != nil) {
                queryitems.append(URLQueryItem(name: "sort_by", value: sortby?.rawValue))
            }
            queryitems.append(URLQueryItem(name: "page", value: String(page)))
            mutableURL.queryItems = queryitems
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let channel = try? JSONDecoder().decode(InvChannelVideos.self, from: data)
            return channel
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Search
    /// Searches YouTube for videos according to the query
    /// - Parameters:
    ///   - q: The query
    ///   - type: The type of content to filter out
    ///   - page: The page number
    /// - Returns: An array of different items, defined by the type property of the item
    static public func search(q: String, type: SearchType = .video, page: Int = 1) async -> InvSearch! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/search")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            var queryitems = [URLQueryItem]()
            queryitems.append(URLQueryItem(name: "q", value: q))
            queryitems.append(URLQueryItem(name: "page", value: String(page)))
            queryitems.append(URLQueryItem(name: "type", value: type.rawValue))
            mutableURL.queryItems = queryitems
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let search = try? JSONDecoder().decode(InvSearch.self, from: data)
            return search
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Search Suggestions
    /// Search suggestions for the query being typed
    /// - Parameter q: The query
    /// - Returns: An array of suggestions
    static public func searchSuggestions(q: String) async -> InvSearchSuggestions! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/search/suggestions")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            mutableURL.queryItems = [URLQueryItem(name: "q", value: q)]
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let suggest = try? JSONDecoder().decode(InvSearchSuggestions.self, from: data)
            return suggest
        } catch {
            return nil
        }
    }
    
    // MARK: - Endpoint - Playlist
    /// Retrive data about a playlist
    /// - Parameters:
    ///   - plid: PLID of the playlist
    ///   - page: The page number
    /// - Returns: Data of the playlist and an array of videos
    static public func playlist(plid: String, page: Int = 1) async -> InvPlaylist! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        
        do {
            var url = instance.appendingPathComponent("api/v1/playlists/\(plid)")
            var mutableURL: URLComponents = URLComponents(string: url.absoluteString)!
            mutableURL.queryItems = [URLQueryItem(name: "page", value: String(page))]
            url = mutableURL.url!
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let playlist = try? JSONDecoder().decode(InvPlaylist.self, from: data)
            return playlist
        } catch {
            return nil
        }
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
