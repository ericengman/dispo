import UIKit

struct APIListResponse: Codable {
    var data: [GifObject]
}

struct GifObject: Codable {
    var id: String
    var title: String
    var source_tld: String
    var rating: String
    /// Giphy URL (not gif url to be displayed)
    var url: URL
    var images: Images
    
    struct Images: Codable {
        var fixed_height: Image
        
        struct Image: Codable {
            var url: URL
            var width: String
            var height: String
            
            private enum CodingKeys: CodingKey {
                case url, width, height
            }
        }
    }
    
    func searchFromObject() -> SearchResult {
        return SearchResult(id: self.id, gifUrl: self.url, title: self.title)
    }
}
