import Foundation
enum Constants {}

extension Constants {
    // Get an API key from https://developers.giphy.com/dashboard/
    static let giphyApiKey = "t0SXxRMabXDstBoLZDdppdMa6yvsEbvF"
    
    static func getTrendingURL(limit: Int = 25) -> URL? {
        return URL(string: "https://api.giphy.com/v1/gifs/trending?api_key=\(giphyApiKey)&limit=\(limit)&rating=pg")
    }
    
    static func searchByKeyURL(_ search: String, count: Int = 25, offset: Int = 0) -> URL? {
        return URL(string: "https://api.giphy.com/v1/gifs/search?api_key=\(giphyApiKey)&q=\(search)&limit=\(count)&offset=\(offset)&rating=pg&lang=en")
    }
    
    static func searchByGifURL(_ id: String, count: Int = 25) -> URL? {
        return URL(string: "https://api.giphy.com/v1/gifs\("/\(id)")?api_key=\(giphyApiKey)")
    }
}
