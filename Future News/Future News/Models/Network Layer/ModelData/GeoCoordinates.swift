
import Foundation

struct GeoCoordinates: Codable {
    let latitude: Double
    let longitude: Double
    let city: String

    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case city = "city"
    }
}
