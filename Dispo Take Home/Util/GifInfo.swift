import UIKit

struct APIGifInfoResponse: Codable {
    let data: GifInfo
}

struct GifInfo: Codable {
  var id: String
  var url: URL
  var source_tld: String
  var rating: String
}
