//
//  Invidious Structures.swift
//  Invidious-Swift
//
//  Created by llsc12 on 10/04/2022.
//

import Foundation

// MARK: - Stats
struct Stats: Codable {
    let version: String
    let software: Software
    let openRegistrations: Bool
    let usage: Usage
    let metadata: Metadata
}

// MARK: - Metadata
struct Metadata: Codable {
    let updatedAt, lastChannelRefreshedAt: Int
}

// MARK: - Software
struct Software: Codable {
    let name, version, branch: String
}

// MARK: - Usage
struct Usage: Codable {
    let users: Users
}

// MARK: - Users
struct Users: Codable {
    let total, activeHalfyear, activeMonth: Int
}

// MARK: - PopularElement
struct PopularElement: Codable {
    let type: PopularType
    let title, videoID: String
    let videoThumbnails: [Thumbnail]
    let lengthSeconds: Int
    let author, authorID, authorURL: String
    let published: Int
    let publishedText: String
    let viewCount: Int

    enum CodingKeys: String, CodingKey {
        case type, title
        case videoID = "videoId"
        case videoThumbnails, lengthSeconds, author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case published, publishedText, viewCount
    }
}

enum PopularType: String, Codable {
    case shortVideo = "shortVideo"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let quality: Quality?
    let url: String
    let width, height: Int
}

enum Quality: String, Codable {
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

// MARK: - Video
struct Video: Codable {
    let type: VideoType
    let title, videoID: String
    let videoThumbnails: [Thumbnail]
    let storyboards: [Storyboard]
    let videoDescription, descriptionHTML: String
    let published: Int
    let publishedText: String
    let keywords: [String]
    let viewCount, likeCount, dislikeCount: Int
    let paid, premium, isFamilyFriendly: Bool
    let allowedRegions: [String]
    let genre: String
    let genreURL: JSONNull?
    let author: Author
    let authorID: AuthorID
    let authorURL: AuthorURL
    let authorThumbnails: [Thumbnail]
    let subCountText: String
    let lengthSeconds: Int
    let allowRatings: Bool
    let rating: Int
    let isListed, liveNow, isUpcoming: Bool
    let dashURL: String
    let adaptiveFormats: [AdaptiveFormat]
    let formatStreams: [FormatStream]
    let captions: [VideoCaption]
    let recommendedVideos: [RecommendedVideo]

    enum CodingKeys: String, CodingKey {
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
        case authorThumbnails, subCountText, lengthSeconds, allowRatings, rating, isListed, liveNow, isUpcoming
        case dashURL = "dashUrl"
        case adaptiveFormats, formatStreams, captions, recommendedVideos
    }
}

// MARK: - AdaptiveFormat
struct AdaptiveFormat: Codable {
    let index, bitrate, adaptiveFormatInit: String
    let url: String
    let itag, type, clen, lmt: String
    let projectionType: ProjectionType
    let fps: Int?
    let container: Container?
    let encoding, resolution, qualityLabel: String?

    enum CodingKeys: String, CodingKey {
        case index, bitrate
        case adaptiveFormatInit = "init"
        case url, itag, type, clen, lmt, projectionType, fps, container, encoding, resolution, qualityLabel
    }
}

enum Container: String, Codable {
    case m4A = "m4a"
    case mp4 = "mp4"
    case webm = "webm"
}

enum ProjectionType: String, Codable {
    case rectangular = "RECTANGULAR"
}

enum Author: String, Codable {
    case kurzgesagtÂInANutshell = "Kurzgesagt â€“ In a Nutshell"
    case zachStar = "Zach Star"
}

enum AuthorID: String, Codable {
    case uCSXVk37BltHxD1RDPwtNM8Q = "UCsXVk37bltHxD1rDPwtNM8Q"
    case uCpCSAcbqsSjEVfkHMFY9W = "UCpCSAcbqs-sjEVfk_hMfY9w"
}

enum AuthorURL: String, Codable {
    case channelUCSXVk37BltHxD1RDPwtNM8Q = "/channel/UCsXVk37bltHxD1rDPwtNM8Q"
    case channelUCpCSAcbqsSjEVfkHMFY9W = "/channel/UCpCSAcbqs-sjEVfk_hMfY9w"
}

// MARK: - VideoCaption
struct VideoCaption: Codable {
    let label, languageCode, url: String

    enum CodingKeys: String, CodingKey {
        case label
        case languageCode = "language_code"
        case url
    }
}

// MARK: - FormatStream
struct FormatStream: Codable {
    let url: String
    let itag, type, quality: String
    let fps: Int
    let container, encoding, resolution, qualityLabel: String
    let size: String
}

// MARK: - RecommendedVideo
struct RecommendedVideo: Codable {
    let videoID, title: String
    let videoThumbnails: [Thumbnail]
    let author: Author
    let authorURL: AuthorURL
    let authorID: AuthorID
    let lengthSeconds: Int
    let viewCountText: String
    let viewCount: Int

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case title, videoThumbnails, author
        case authorURL = "authorUrl"
        case authorID = "authorId"
        case lengthSeconds, viewCountText, viewCount
    }
}

// MARK: - Storyboard
struct Storyboard: Codable {
    let url: String
    let templateURL: String
    let width, height, count, interval: Int
    let storyboardWidth, storyboardHeight, storyboardCount: Int

    enum CodingKeys: String, CodingKey {
        case url
        case templateURL = "templateUrl"
        case width, height, count, interval, storyboardWidth, storyboardHeight, storyboardCount
    }
}

enum VideoType: String, Codable {
    case channel = "channel"
    case playlist = "playlist"
    case video = "video"
}

// MARK: - Comments
struct Comments: Codable {
    let commentCount: Int
    let videoID: String
    let comments: [Comment]
    let continuation: String

    enum CodingKeys: String, CodingKey {
        case commentCount
        case videoID = "videoId"
        case comments, continuation
    }
}

// MARK: - Comment
struct Comment: Codable {
    let author: String
    let authorThumbnails: [Thumbnail]
    let authorID, authorURL: String
    let isEdited: Bool
    let content, contentHTML: String
    let published: Int
    let publishedText: String
    let likeCount: Int
    let commentID: String
    let authorIsChannelOwner: Bool
    let replies: Replies?

    enum CodingKeys: String, CodingKey {
        case author, authorThumbnails
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case isEdited, content
        case contentHTML = "contentHtml"
        case published, publishedText, likeCount
        case commentID = "commentId"
        case authorIsChannelOwner, replies
    }
}

// MARK: - Replies
struct Replies: Codable {
    let replyCount: Int
    let continuation: String
}

// MARK: - Captions
struct Captions: Codable {
    let captions: [CaptionsCaption]
}

// MARK: - CaptionsCaption
struct CaptionsCaption: Codable {
    let label, languageCode, url: String
}

// MARK: - TrendingElement
struct TrendingElement: Codable {
    let type: VideoType
    let title, videoID, author, authorID: String
    let authorURL: String
    let videoThumbnails: [Thumbnail]
    let trendingDescription, descriptionHTML: String
    let viewCount, published: Int
    let publishedText: String
    let lengthSeconds: Int
    let liveNow, premium, isUpcoming: Bool

    enum CodingKeys: String, CodingKey {
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

// MARK: - SearchElement
struct SearchElement: Codable {
    let type: VideoType
    let title, videoID: String?
    let author, authorID, authorURL: String
    let videoThumbnails: [Thumbnail]?
    let searchDescription, descriptionHTML: String?
    let viewCount, published: Int?
    let publishedText: String?
    let lengthSeconds: Int?
    let liveNow, premium, isUpcoming: Bool?
    let playlistID: String?
    let playlistThumbnail: String?
    let videoCount: Int?
    let videos: [VideoElement]?
    let authorThumbnails: [Thumbnail]?
    let autoGenerated: Bool?
    let subCount: Int?

    enum CodingKeys: String, CodingKey {
        case type, title
        case videoID = "videoId"
        case author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case videoThumbnails
        case searchDescription = "description"
        case descriptionHTML = "descriptionHtml"
        case viewCount, published, publishedText, lengthSeconds, liveNow, premium, isUpcoming
        case playlistID = "playlistId"
        case playlistThumbnail, videoCount, videos, authorThumbnails, autoGenerated, subCount
    }
}

// MARK: - VideoElement
struct VideoElement: Codable {
    let title, videoID: String
    let lengthSeconds: Int
    let videoThumbnails: [Thumbnail]

    enum CodingKeys: String, CodingKey {
        case title
        case videoID = "videoId"
        case lengthSeconds, videoThumbnails
    }
}

typealias Popular = [PopularElement]
typealias Trending = [TrendingElement]
typealias Search = [SearchElement]

// MARK: - Encode/decode helpers

fileprivate class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
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
