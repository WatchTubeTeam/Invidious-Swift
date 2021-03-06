//
//  File.swift
//  
//
//  Created by llsc12 on 10/04/2022.
//

import Foundation

//MARK: - Extra captions parsing if people want it
// some stuff comes from here
// https://github.com/WatchTubeTeam/WatchTube/blob/a217908c1674e3f0df68258affb1739aea29a2ca/WatchTube%20WatchKit%20Extension/Scenes/Players/HLS%20Player/playerView.swift#L13

public struct Caption {
    public init(text: String, beginning: Double, end: Double) {
        self.text = text
        self.beginning = beginning
        self.end = end
    }
    
    public var text: String
    public var beginning: Double
    public var end: Double
}

public struct CaptionSet {
    public init(lang: String, label: String, captions: [Caption]) {
        self.captions = captions
        self.label = label
        self.lang = lang
    }
    
    public var lang: String
    public var label: String
    public var captions: [Caption]
}

public extension InvVideoCaption {
    func downloadURL() -> URL! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        let id = self.url.components(separatedBy: "?label=")[0].components(separatedBy: "api/v1/captions/")[1]

        let url = URL(string: instance.appendingPathComponent("api/v1/captions/\(id)?label=\(self.label.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "english")").absoluteString.removingPercentEncoding!)
        return url
    }
    
    
    func createCaptions() async -> CaptionSet! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        let id = self.url.components(separatedBy: "?label=")[0].components(separatedBy: "api/v1/captions/")[1]

        let url = URL(string: instance.appendingPathComponent("api/v1/captions/\(id)?label=\(self.label.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "english")").absoluteString.removingPercentEncoding!)!
        
        let pathToHash = url.pathComponents.joined(separator: "/") + self.label
        let hashFileName: String = pathToHash.hashed
        
        do {
            var data: Data = Data()
            let cached = getData(hashFileName)
            if cached != nil { /// using random as a way to eventually update cached data
                data = cached!
            } else {
                let (res, _) = try await URLSession.shared.data(from: url)
                data = res
                cacheData(res, hashFileName)
            }

            guard let result = String(data: data, encoding: .utf8) else {
                return nil
            }
            
            
            // Parsing
            let label = self.label

            if result.contains("WEBVTT") == false {
                return nil
            }
            var subtitlesData = result.components(separatedBy: "\n\n")
            subtitlesData.removeLast()
            if subtitlesData.count == 0 {
                return nil
            }
            let meta = String(describing: subtitlesData[0])
            let language:String = meta.description.components(separatedBy: "\n")[2].components(separatedBy: ": ")[1].description
            
            var array: [Caption] = []
            subtitlesData = subtitlesData.suffix(subtitlesData.count - 1)

            for subtitleItem in subtitlesData {
                // ok now we start doing more parsing of each subtitle
                let subMeta = subtitleItem.components(separatedBy: "\n")
                let rawTimestamp = subMeta[0]
                let subtext = subMeta.dropFirst().joined(separator: " ")
                
                let timeSplit = rawTimestamp.components(separatedBy: " --> ")
                var total: Double = 0
                //work out first timestamp in seconds
                var broken = timeSplit[0].split(separator: ":")
                total = total + (Double(broken[0]) ?? 0) * 3600 // get the hours and times it by 3600 to get it in seconds :D
                total = total + (Double(broken[1]) ?? 0) * 60 // same as above but for minutes
                total = total + (Double(broken[2]) ?? 0) // already in seconds and in decimal too.
                let beginning: Double = total
                
                total = 0
                broken = timeSplit[1].split(separator: ":")
                total = total + (Double(broken[0]) ?? 0) * 3600 // get the hours and times it by 3600 to get it in seconds :D
                total = total + (Double(broken[1]) ?? 0) * 60 // same as above but for minutes
                total = total + (Double(broken[2]) ?? 0) // already in seconds and in decimal too.
                let end: Double = total
                let finalSub = Caption.init(text: subtext, beginning: beginning, end: end)
                array.append(finalSub)
            }
            let finalised = CaptionSet(lang: language, label: label, captions: array)
            
            return finalised
            
        } catch {
            return nil
        }
    }
}
public extension InvCaption {
    func downloadURL() -> URL! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        let id = self.url.components(separatedBy: "?label=")[0].components(separatedBy: "api/v1/captions/")[1]

        let url = URL(string: instance.appendingPathComponent("api/v1/captions/\(id)?label=\(self.label.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "english")").absoluteString.removingPercentEncoding!)
        return url
    }
    
    
    func createCaptions() async -> CaptionSet! {
        let instanceURLstring = UserDefaults.standard.string(forKey: "InvidiousInstanceURL") ?? "https://invidious.osi.kr/"
        guard let instance = URL(string: instanceURLstring) else {
            return nil
        }
        let id = self.url.components(separatedBy: "?label=")[0].components(separatedBy: "api/v1/captions/")[1]

        let url = URL(string: instance.appendingPathComponent("api/v1/captions/\(id)?label=\(self.label.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "english")").absoluteString.removingPercentEncoding!)!
        
        let pathToHash = url.pathComponents.joined(separator: "/") + self.label
        let hashFileName: String = pathToHash.hashed
        
        do {
            var data: Data = Data()
            let cached = getData(hashFileName)
            if cached != nil { /// using random as a way to eventually update cached data
                data = cached!
            } else {
                let (res, _) = try await URLSession.shared.data(from: url)
                data = res
                cacheData(res, hashFileName)
            }

            guard let result = String(data: data, encoding: .utf8) else {
                return nil
            }
            
            
            // Parsing
            let label = self.label

            if result.contains("WEBVTT") == false {
                return nil
            }
            var subtitlesData = result.components(separatedBy: "\n\n")
            subtitlesData.removeLast()
            if subtitlesData.count == 0 {
                return nil
            }
            let meta = String(describing: subtitlesData[0])
            let language:String = meta.description.components(separatedBy: "\n")[2].components(separatedBy: ": ")[1].description
            
            var array: [Caption] = []
            subtitlesData = subtitlesData.suffix(subtitlesData.count - 1)

            for subtitleItem in subtitlesData {
                // ok now we start doing more parsing of each subtitle
                let subMeta = subtitleItem.components(separatedBy: "\n")
                let rawTimestamp = subMeta[0]
                let subtext = subMeta.dropFirst().joined(separator: " ")
                
                let timeSplit = rawTimestamp.components(separatedBy: " --> ")
                var total: Double = 0
                //work out first timestamp in seconds
                var broken = timeSplit[0].split(separator: ":")
                total = total + (Double(broken[0]) ?? 0) * 3600 // get the hours and times it by 3600 to get it in seconds :D
                total = total + (Double(broken[1]) ?? 0) * 60 // same as above but for minutes
                total = total + (Double(broken[2]) ?? 0) // already in seconds and in decimal too.
                let beginning: Double = total
                
                total = 0
                broken = timeSplit[1].split(separator: ":")
                total = total + (Double(broken[0]) ?? 0) * 3600 // get the hours and times it by 3600 to get it in seconds :D
                total = total + (Double(broken[1]) ?? 0) * 60 // same as above but for minutes
                total = total + (Double(broken[2]) ?? 0) // already in seconds and in decimal too.
                let end: Double = total
                let finalSub = Caption.init(text: subtext, beginning: beginning, end: end)
                array.append(finalSub)
            }
            let finalised = CaptionSet(lang: language, label: label, captions: array)
            
            return finalised
            
        } catch {
            return nil
        }
    }
}
