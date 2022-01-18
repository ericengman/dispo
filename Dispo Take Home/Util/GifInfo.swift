import UIKit

struct APIGifInfoResponse: Codable {
    let data: GifInfo
}

struct GifInfo: Codable {
    var id: String
    var title: String
    var url: URL
    var source_tld: String
    var rating: String
    
    let images: Images
    
    struct Images: Codable {
        let downsized_large: GifData
        struct GifData: Codable {
            let url: URL
            let height: String
        }
    }
}
