import Foundation


struct Product: Identifiable, Codable {
    let id: String
    let name: String
    let type: String
    let currentValue: Double
    let percentageChange: Double
    let symbol: String
    let timestamp: String
    let image: String
}
