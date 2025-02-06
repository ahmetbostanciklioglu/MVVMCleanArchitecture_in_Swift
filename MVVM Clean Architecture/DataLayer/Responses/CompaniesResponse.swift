import Foundation

/// API'den dönen şirketler listesini temsil eden model.
/// - `Codable` protokolünü uygular, böylece JSON dönüşümü desteklenir.
struct CompaniesResponse: Codable {
    /// Şirketlerin listesini içerir.
    let companies: [Company]
}
