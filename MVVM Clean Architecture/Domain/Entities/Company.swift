import Foundation


struct Company: Identifiable, Codable {
    let id: String
    let name: String
    let logo: String
    let products: [Product]
}






