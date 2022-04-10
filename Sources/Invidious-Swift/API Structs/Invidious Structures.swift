//
//  Invidious Structures.swift
//  Invidious-Swift
//
//  Created by llsc12 on 10/04/2022.
//
//  Structures generated with quicktype but patched manually

import Foundation

// MARK: - Stats
public struct Stats: Codable {
    public let version: String
    public let software: Software
    public let openRegistrations: Bool
    public let usage: Usage
    public let metadata: Metadata
}

// MARK: - Suggestions
public struct Suggestions: Codable {
    public let query: String
    public let suggestions: [String]
}

// MARK: - Playlist
public struct Playlist: Codable {
    public let type: VideoType
    public let title, playlistID: String
    public let playlistThumbnail: String
    public let author, authorID, authorURL: String
    public let authorThumbnails: [AuthorMedia]
    public let playlistDescription, descriptionHTML: String
    public let videoCount, viewCount, updated: Int
    public let isListed: Bool
    public let videos: [PlaylistVideo]

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

// MARK: - PlaylistVideo
public struct PlaylistVideo: Codable {
    public let title, videoID, author, authorID: String
    public let authorURL: String
    public let videoThumbnails: [AuthorMedia]
    public let index: Int?
    public let lengthSeconds: Int
    public let viewCountText: String?
    public let viewCount: Int?

    public enum CodingKeys: String, CodingKey {
        case title
        case videoID = "videoId"
        case author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case videoThumbnails, index, lengthSeconds, viewCountText, viewCount
    }
}

// MARK: - Channel
public struct Channel: Codable {
    public let author: String
    public let authorID: String
    public let authorURL: String
    public let authorBanners, authorThumbnails: [AuthorMedia]
    public let subCount, totalViews, joined: Int
    public let autoGenerated, isFamilyFriendly: Bool
    public let channelDescription, descriptionHTML: String
    public let allowedRegions: [String]
    public let latestVideos: [TrendingElement]
    public let relatedChannels: [RelatedChannel]

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

// MARK: - RelatedChannel
public struct RelatedChannel: Codable {
    public let author, authorID, authorURL: String
    public let authorThumbnails: [AuthorMedia]

    public enum CodingKeys: String, CodingKey {
        case author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case authorThumbnails
    }
}

// MARK: - AuthorMedia
public struct AuthorMedia: Codable {
    public let url: String
    public let width, height: Int
    public let quality: Quality?
}

// MARK: - Metadata
public struct Metadata: Codable {
    public let updatedAt, lastChannelRefreshedAt: Int
}

// MARK: - Software
public struct Software: Codable {
    public let name, version, branch: String
}

// MARK: - Usage
public struct Usage: Codable {
    public let users: Users
}

// MARK: - Users
public struct Users: Codable {
    public let total, activeHalfyear, activeMonth: Int
}

// MARK: - PopularElement
public struct PopularElement: Codable {
    public let type: PopularType
    public let title, videoID: String
    public let videoThumbnails: [Thumbnail]
    public let lengthSeconds: Int
    public let author, authorID, authorURL: String
    public let published: Int
    public let publishedText: String
    public let viewCount: Int

    public enum CodingKeys: String, CodingKey {
        case type, title
        case videoID = "videoId"
        case videoThumbnails, lengthSeconds, author
        case authorID = "authorId"
        case authorURL = "authorUrl"
        case published, publishedText, viewCount
    }
}

public enum PopularType: String, Codable {
    case shortVideo = "shortVideo"
}

// MARK: - Thumbnail
public struct Thumbnail: Codable {
    public let quality: Quality?
    public let url: String
    public let width, height: Int
}

public enum Quality: String, Codable {
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
public struct Video: Codable {
    public let type: VideoType
    public let title, videoID: String
    public let videoThumbnails: [Thumbnail]
    public let storyboards: [Storyboard]
    public let videoDescription, descriptionHTML: String
    public let published: Double
    public let publishedText: String
    public let keywords: [String]
    public let viewCount, likeCount, dislikeCount: Double
    public let paid, premium, isFamilyFriendly: Bool
    public let allowedRegions: [String]
    public let genre: String
    public let genreURL: JSONNull?
    public let author: String
    public let authorID: String
    public let authorURL: String
    public let authorThumbnails: [Thumbnail]
    public let subCountText: String
    public let lengthSeconds: Int
    public let allowRatings: Bool
    public let rating: Int
    public let isListed, liveNow, isUpcoming: Bool
    public let dashURL: String
    public let adaptiveFormats: [AdaptiveFormat]
    public let formatStreams: [FormatStream]
    public let captions: [VideoCaption]
    public let recommendedVideos: [RecommendedVideo]

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
        case authorThumbnails, subCountText, lengthSeconds, allowRatings, rating, isListed, liveNow, isUpcoming
        case dashURL = "dashUrl"
        case adaptiveFormats, formatStreams, captions, recommendedVideos
    }
}

// MARK: - AdaptiveFormat
public struct AdaptiveFormat: Codable {
    public let index, bitrate, adaptiveFormatInit: String
    public let url: String
    public let itag, type, clen, lmt: String
    public let projectionType: String
    public let fps: Int?
    public let container: Container?
    public let encoding, resolution, qualityLabel: String?

    public enum CodingKeys: String, CodingKey {
        case index, bitrate
        case adaptiveFormatInit = "init"
        case url, itag, type, clen, lmt, projectionType, fps, container, encoding, resolution, qualityLabel
    }
}

public enum Container: String, Codable {
    case m4A = "m4a"
    case mp4 = "mp4"
    case webm = "webm"
}

// MARK: - VideoCaption
public struct VideoCaption: Codable {
    public let label, languageCode, url: String

    public enum CodingKeys: String, CodingKey {
        case label
        case languageCode = "language_code"
        case url
    }
}

// MARK: - FormatStream
public struct FormatStream: Codable {
    public let url: String
    public let itag, type, quality: String
    public let fps: Int
    public let container, encoding, resolution, qualityLabel: String
    public let size: String
}

// MARK: - RecommendedVideo
public struct RecommendedVideo: Codable {
    public let videoID, title: String
    public let videoThumbnails: [Thumbnail]
    public let author: String
    public let authorURL: String
    public let authorID: String
    public let lengthSeconds: Int
    public let viewCountText: String
    public let viewCount: Int

    public enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case title, videoThumbnails, author
        case authorURL = "authorUrl"
        case authorID = "authorId"
        case lengthSeconds, viewCountText, viewCount
    }
}

// MARK: - Storyboard
public struct Storyboard: Codable {
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

public enum VideoType: String, Codable {
    case channel = "channel"
    case playlist = "playlist"
    case video = "video"
}

// MARK: - Comments
public struct Comments: Codable {
    public let commentCount: Int
    public let videoID: String
    public let comments: [Comment]
    public let continuation: String

    public enum CodingKeys: String, CodingKey {
        case commentCount
        case videoID = "videoId"
        case comments, continuation
    }
}

// MARK: - Comment
public struct Comment: Codable {
    public let author: String
    public let authorThumbnails: [Thumbnail]
    public let authorID, authorURL: String
    public let isEdited: Bool
    public let content, contentHTML: String
    public let published: Int
    public let publishedText: String
    public let likeCount: Int
    public let commentID: String
    public let authorIsChannelOwner: Bool
    public let replies: Replies?

    public enum CodingKeys: String, CodingKey {
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
public struct Replies: Codable {
    public let replyCount: Int
    public let continuation: String
}

// MARK: - Captions
public struct Captions: Codable {
    public let captions: [CaptionsCaption]
}

// MARK: - CaptionsCaption
public struct CaptionsCaption: Codable {
    public let label, languageCode, url: String
}

// MARK: - TrendingElement
public struct TrendingElement: Codable {
    public let type: VideoType
    public let title, videoID, author, authorID: String
    public let authorURL: String
    public let videoThumbnails: [Thumbnail]
    public let trendingDescription, descriptionHTML: String
    public let viewCount, published: Int
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

// MARK: - SearchElement
public struct SearchElement: Codable {
    public let type: VideoType
    public let title, videoID: String?
    public let author, authorID, authorURL: String
    public let videoThumbnails: [Thumbnail]?
    public let searchDescription, descriptionHTML: String?
    public let viewCount, published: Int?
    public let publishedText: String?
    public let lengthSeconds: Int?
    public let liveNow, premium, isUpcoming: Bool?
    public let playlistID: String?
    public let playlistThumbnail: String?
    public let videoCount: Int?
    public let videos: [VideoElement]?
    public let authorThumbnails: [Thumbnail]?
    public let autoGenerated: Bool?
    public let subCount: Int?

    public enum CodingKeys: String, CodingKey {
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
public struct VideoElement: Codable {
    public let title, videoID: String
    public let lengthSeconds: Int
    public let videoThumbnails: [Thumbnail]

    public enum CodingKeys: String, CodingKey {
        case title
        case videoID = "videoId"
        case lengthSeconds, videoThumbnails
    }
}

public typealias Popular = [PopularElement]
public typealias Trending = [TrendingElement]
public typealias Search = [SearchElement]

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {

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
