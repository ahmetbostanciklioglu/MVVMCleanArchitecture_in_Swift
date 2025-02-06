import Foundation

/// Bir şirketi temsil eden model.
/// - `Identifiable`: SwiftUI ile kolay kullanım için benzersiz bir kimlik (`id`) sağlar.
/// - `Codable`: JSON dönüşümünü destekler, böylece API'den gelen veriler çözümlenebilir.
struct Company: Identifiable, Codable {
    /// Şirketin benzersiz kimliği.
    let id: String
    
    /// Şirketin adı.
    let name: String
    
    /// Şirketin logo URL'si veya dosya yolu.
    let logo: String
    
    /// Şirketin sunduğu ürünlerin listesi.
    let products: [Product]
}
