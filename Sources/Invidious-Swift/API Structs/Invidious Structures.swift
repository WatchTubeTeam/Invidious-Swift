//
//  Invidious Structures.swift
//  Invidious-Swift
//
//  Created by llsc12 on 10/04/2022.
//
//  Structures generated with quicktype but patched manually to fix random issues

import Foundation

// MARK: - InvSearchSuggestions
/// Contains original query and suggestions for it
public struct InvSearchSuggestions: Codable {
    public let query: String
    public let suggestions: [String]
}

// MARK: - InvPlaylist
/// Playlist data and it's list of videos
public struct InvPlaylist: Codable, Identifiable {
    public var id: String { playlistID }
    public let type: String
    public let title, playlistID: String
    public let playlistThumbnail: String
    public let author, authorID, authorURL: String
    public let authorThumbnails: [InvAuthorMedia]
    public let playlistDescription, descriptionHTML: String
    public let videoCount, viewCount, updated: Double
    public let isListed: Bool
    public let videos: [InvPlaylistVideo]

    public enum CodingKeys: String, CodingKey {
        case type, title
        case playlistID = "playlistId"
        case playlistThumbnail, author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case authorThumbnails
        case playlistDescription = "description"
        case descriptionHTML = "descriptionHtml"
        case videoCount, viewCount, updated, isListed, videos
    }
}

// MARK: - InvAuthor
public struct InvAuthorMedia: Codable {
    public let url: String
    public let width, height: Int
}

// MARK: - InvPlaylistVideo
/// Basic data of a video in a playlist
public struct InvPlaylistVideo: Codable, Identifiable {
    public var id: String { videoID }
    public let title, videoID, author, authorID: String
    public let authorURL: String
    public let videoThumbnails: [InvVideoThumbnail]
    public let index, lengthSeconds: Int

    public enum CodingKeys: String, CodingKey {
        case title
        case videoID = "videoId"
        case author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case videoThumbnails, index, lengthSeconds
    }
}

// MARK: - InvVideoThumbnail
public struct InvVideoThumbnail: Codable {
    public let quality: InvVideoThumbnailQuality
    public let url: String
    public let width, height: Int
}

public enum InvVideoThumbnailQuality: String, Codable {
    case end = "end"
    case high = "high"
    case maxres = "maxres"
    case maxresdefault = "maxresdefault"
    case medium = "medium"
    case middle = "middle"
    case qualityDefault = "default"
    case sddefault = "sddefault"
    case start = "start"
}

// MARK: - InvChannelPlaylists
/// A channel's playlists
public struct InvChannelPlaylists: Codable {
    public let playlists: [InvChannelPlaylist]
    public let continuation: String?
}

// MARK: - InvChannelPlaylist
/// Playlist from a channel
public struct InvChannelPlaylist: Codable, Identifiable {
    public var id: String { playlistID }
    public let type: String
    public let title, playlistID: String
    public let playlistThumbnail: String
    public let author: String
    public let authorID: String
    public let authorURL: String
    public let videoCount: Double
    public let videos: [JSONAny]

    public enum CodingKeys: String, CodingKey {
        case type, title
        case playlistID = "playlistId"
        case playlistThumbnail, author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case videoCount, videos
    }
}

// MARK: - InvChannelVideoElement
/// A channel's video
public struct InvChannelVideo: Codable, Identifiable {
    public var id: String { videoID }
    public let type: String
    public let title, videoID: String
    public let author: String
    public let authorID: String
    public let authorURL: String
    public let videoThumbnails: [InvVideoThumbnail]
    public let videoDescription, descriptionHTML: String
    public let viewCount: Double
    public let published: Int
    public let publishedText: String
    public let lengthSeconds: Int
    public let liveNow, premium, isUpcoming: Bool

    public enum CodingKeys: String, CodingKey {
        case type, title
        case videoID = "videoId"
        case author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case videoThumbnails
        case videoDescription = "description"
        case descriptionHTML = "descriptionHtml"
        case viewCount, published, publishedText, lengthSeconds, liveNow, premium, isUpcoming
    }
}

// MARK: - InvPopularVideo
public struct InvPopularVideo: Codable, Identifiable {
    public var id: String { videoID }
    public let type: String
    public let title, videoID: String
    public let videoThumbnails: [InvVideoThumbnail]
    public let lengthSeconds: Int
    public let author, authorID, authorURL: String
    public let published: Int
    public let publishedText: String
    public let viewCount: Double

    public enum CodingKeys: String, CodingKey {
        case type, title
        case videoID = "videoId"
        case videoThumbnails, lengthSeconds, author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case published, publishedText, viewCount
    }
}

// MARK: - InvTrendingVideo
public struct InvTrendingVideo: Codable, Identifiable {
    public var id: String { videoID }
    public let type: String
    public let title, videoID, author, authorID: String
    public let authorURL: String
    public let videoThumbnails: [InvVideoThumbnail]
    public let trendingDescription, descriptionHTML: String
    public let viewCount: Double
    public let published: Int
    public let publishedText: String
    public let lengthSeconds: Int
    public let liveNow, premium, isUpcoming: Bool

    public enum CodingKeys: String, CodingKey {
        case type, title
        case videoID = "videoId"
        case author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case videoThumbnails
        case trendingDescription = "description"
        case descriptionHTML = "descriptionHtml"
        case viewCount, published, publishedText, lengthSeconds, liveNow, premium, isUpcoming
    }
}

// MARK: - InvCaptions
public struct InvCaptions: Codable {
    public let captions: [InvCaption]
}

// MARK: - InvCaption
public struct InvCaption: Codable, Identifiable {
    public var id: String { languageCode }
    public let label, languageCode, url: String
}

// MARK: - InvComments
public struct InvComments: Codable {
    public let commentCount: Double?
    public let videoID: String
    public let comments: [InvComment]
    public let continuation: String?

    public enum CodingKeys: String, CodingKey {
        case commentCount
        case videoID = "videoId"
        case comments, continuation
    }
}

// MARK: - InvComment
public struct InvComment: Codable, Identifiable {
    public var id: String { commentID }
    public let author: String
    public let authorThumbnails: [InvAuthorMedia]
    public let authorID, authorURL: String
    public let isEdited: Bool
    public let content, contentHTML: String
    public let published: Int
    public let publishedText: String
    public let likeCount: Int
    public let commentID: String
    public let authorIsChannelOwner: Bool
    public let creatorHeart: InvCreatorHeart?
    public let replies: InvReplies?
    public let verified: Bool?

    public enum CodingKeys: String, CodingKey {
        case author, authorThumbnails
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case isEdited, content
        case contentHTML = "contentHtml"
        case published, publishedText, likeCount
        case commentID = "commentId"
        case authorIsChannelOwner, creatorHeart, replies, verified
    }
}

// MARK: - InvCreatorHeart
public struct InvCreatorHeart: Codable {
    public let creatorThumbnail: String
    public let creatorName: String
}

// MARK: - InvReplies
public struct InvReplies: Codable {
    public let replyCount: Double
    public let continuation: String?
}

// MARK: - InvVideo
public struct InvVideo: Codable, Identifiable {
    public var id: String { videoID }
    public let type: String
    public let title, videoID: String
    public let videoThumbnails: [InvVideoThumbnail]
    public let storyboards: [InvStoryboard]
    public let videoDescription, descriptionHTML: String
    public let published: Int
    public let publishedText: String
    public let keywords: [String]
    public let viewCount, likeCount, dislikeCount: Double
    public let paid, premium, isFamilyFriendly: Bool
    public let allowedRegions: [String]
    public let genre: String
    public let genreURL: JSONNull?
    public let author, authorID, authorURL: String
    public let authorThumbnails: [InvAuthorMedia]
    public let subCountText: String
    public let lengthSeconds: Int
    public let allowRatings: Bool
    public let rating: Int
    public let isListed, liveNow, isUpcoming: Bool
    public let premiereTimestamp: Int?
    public let dashURL: String
    public let adaptiveFormats: [InvAdaptiveFormat]
    public let formatStreams: [InvFormatStream]
    public let captions: [InvVideoCaption]
    public let recommendedVideos: [InvRecommendedVideo]

    public enum CodingKeys: String, CodingKey {
        case type, title
        case videoID = "videoId"
        case videoThumbnails, storyboards
        case videoDescription = "description"
        case descriptionHTML = "descriptionHtml"
        case published, publishedText, keywords, viewCount, likeCount, dislikeCount, paid, premium, isFamilyFriendly, allowedRegions, genre
        case genreURL = "genreUrl"
        case author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case authorThumbnails, subCountText, lengthSeconds, allowRatings, rating, isListed, liveNow, isUpcoming, premiereTimestamp
        case dashURL = "dashUrl"
        case adaptiveFormats, formatStreams, captions, recommendedVideos
    }
}

// MARK: - InvAdaptiveFormat
public struct InvAdaptiveFormat: Codable, Identifiable {
    public var id: String { itag }
    public let index, adaptiveFormatInit: String?
    public let bitrate: String
    public let url: String
    public let itag, type, clen, lmt: String
    public let projectionType: String
    public let fps: Int?
    public let container: String?
    public let encoding: String?
    public let resolution, qualityLabel: String?

    public enum CodingKeys: String, CodingKey {
        case index, bitrate
        case adaptiveFormatInit = "init"
        case url, itag, type, clen, lmt, projectionType, fps, container, encoding, resolution, qualityLabel
    }
}

// MARK: - InvVideoCaption
public struct InvVideoCaption: Codable, Identifiable {
    public var id: String { languageCode }
    public let label, languageCode, url: String

    public enum CodingKeys: String, CodingKey {
        case label
        case languageCode = "language_code"
        case url
    }
}

// MARK: - InvFormatStream
public struct InvFormatStream: Codable, Identifiable {
    public var id: String { itag }
    public let url: String
    public let itag: String
    public let type: String
    public let quality: String
    public let fps: Int
    public let container: String
    public let encoding: String
    public let resolution, qualityLabel: String
    public let size: String
}

// MARK: - InvRecommendedVideo
public struct InvRecommendedVideo: Codable, Identifiable {
    public var id: String { videoID }
    public let videoID, title: String
    public let videoThumbnails: [InvVideoThumbnail]
    public let author, authorURL, authorID: String
    public let lengthSeconds: Int
    public let viewCountText: String
    public let viewCount: Double?

    public enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case title, videoThumbnails, author
        case authorURL = "authorUrl"
        case authorID = "authorId"
        case lengthSeconds, viewCountText, viewCount
    }
}

// MARK: - InvStoryboard
public struct InvStoryboard: Codable {
    public let url: String
    public let templateURL: String
    public let width, height, count, interval: Int
    public let storyboardWidth, storyboardHeight, storyboardCount: Int

    public enum CodingKeys: String, CodingKey {
        case url
        case templateURL = "templateUrl"
        case width, height, count, interval, storyboardWidth, storyboardHeight, storyboardCount
    }
}

// MARK: - InvStats
public struct InvStats: Codable {
    public let version: String
    public let software: InvSoftware
    public let openRegistrations: Bool
    public let usage: InvUsage
    public let metadata: InvMetadata
}

// MARK: - InvMetadata
public struct InvMetadata: Codable {
    public let updatedAt, lastChannelRefreshedAt: Int
}

// MARK: - InvSoftware
public struct InvSoftware: Codable {
    public let name, version, branch: String
}

// MARK: - InvUsage
public struct InvUsage: Codable {
    public let users: InvUsers
}

// MARK: - InvUsers
public struct InvUsers: Codable {
    public let total, activeHalfyear, activeMonth: Int
}

// MARK: - InvChannel
public struct InvChannel: Codable, Identifiable {
    public var id: String { authorID }
    public let author: String
    public let authorID: String
    public let authorURL: String
    public let authorBanners, authorThumbnails: [InvAuthorMedia]
    public let subCount, totalViews, joined: Double
    public let autoGenerated, isFamilyFriendly: Bool
    public let channelDescription, descriptionHTML: String
    public let allowedRegions: [String]
    public let latestVideos: [InvChannelVideo]
    public let relatedChannels: [InvRelatedChannel]

    public enum CodingKeys: String, CodingKey {
        case author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case authorBanners, authorThumbnails, subCount, totalViews, joined, autoGenerated, isFamilyFriendly
        case channelDescription = "description"
        case descriptionHTML = "descriptionHtml"
        case allowedRegions, latestVideos, relatedChannels
    }
}

// MARK: - InvRelatedChannel
public struct InvRelatedChannel: Codable, Identifiable {
    public var id: String { authorID }
    public let author, authorID, authorURL: String
    public let authorThumbnails: [InvAuthorThumbnail]

    public enum CodingKeys: String, CodingKey {
        case author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case authorThumbnails
    }
}

// MARK: - InvAuthorThumbnail
public struct InvAuthorThumbnail: Codable {
    public let url: String
    public let width, height: Int
}

// MARK: - InvSearchElement
public struct InvSearchResult: Codable, Identifiable {
    public var id: String { videoID ?? playlistID ?? authorID }
    public let type: String
    public let author, authorID, authorURL: String
    public let authorThumbnails: [InvAuthorThumbnail]?
    public let autoGenerated: Bool?
    public let subCount, videoCount: Double?
    public let searchDescription, descriptionHTML, title, videoID: String?
    public let videoThumbnails: [InvVideoThumbnail]?
    public let viewCount: Double?
    public let published: Int?
    public let publishedText: String?
    public let lengthSeconds: Int?
    public let liveNow, premium, isUpcoming: Bool?
    public let playlistID: String?
    public let playlistThumbnail: String?
    public let videos: [InvSearchVideo]?

    public enum CodingKeys: String, CodingKey {
        case type, author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case authorThumbnails, autoGenerated, subCount, videoCount
        case searchDescription = "description"
        case descriptionHTML = "descriptionHtml"
        case title
        case videoID = "videoId"
        case videoThumbnails, viewCount, published, publishedText, lengthSeconds, liveNow, premium, isUpcoming
        case playlistID = "playlistId"
        case playlistThumbnail, videos
    }
}

// MARK: - InvSearchVideo
public struct InvSearchVideo: Codable, Identifiable {
    public var id: String { videoID }
    public let title, videoID: String
    public let lengthSeconds: Int
    public let videoThumbnails: [InvVideoThumbnail]

    public enum CodingKeys: String, CodingKey {
        case title
        case videoID = "videoId"
        case lengthSeconds, videoThumbnails
    }
}

public typealias InvChannelVideos = [InvChannelVideo]
public typealias InvPopular = [InvPopularVideo]
public typealias InvTrending = [InvTrendingVideo]
public typealias InvSearch = [InvSearchResult]

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    public let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

public class JSONAny: Codable {

    public let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
