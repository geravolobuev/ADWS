import UIKit
import PlaygroundSupport

extension URL {
    func withQueries(_ queries: [String:String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {
            URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true

struct StoreItem: Codable {
    var artist: String
    var genre: String
    var album: String
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case genre = "primaryGenreName"
        case album = "collectionName"
        case price = "collectionPrice"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.artist = try valueContainer.decode(String.self, forKey: CodingKeys.artist)
        self.genre = try valueContainer.decode(String.self, forKey: CodingKeys.genre)
        self.album = try valueContainer.decode(String.self, forKey: CodingKeys.album)
        self.price = try valueContainer.decode(Double.self, forKey: CodingKeys.price)
    }
}

struct StoreItems: Codable {
    var results: [StoreItem]
}


let query:[String:String] = [
    "term":"kanye+west",
    "country":"us",
    "media":"music",
    "limit":"1"
]

func fetchStoreItem(completion: @escaping ([StoreItem]?) -> Void) {
    let baseURL = URL(string: "https://itunes.apple.com/search?")!

    let searchURL = baseURL.withQueries(query)!
    
    let task = URLSession.shared.dataTask(with: searchURL) { (data, response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
            let storeItems = try? jsonDecoder.decode(StoreItems.self, from: data) {
            completion(storeItems.results)
//            PlaygroundPage.current.finishExecution()
        } else {
            completion(nil)
        }
    }
    task.resume()
}

fetchStoreItem { (fetchItem) in
    print(fetchItem)
}

