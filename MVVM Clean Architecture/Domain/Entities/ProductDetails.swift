import Foundation

/// Bir finansal ürünü veya varlığı temsil eden model.
/// - `Identifiable`: SwiftUI ile kolay kullanım için benzersiz bir kimlik (`id`) sağlar.
/// - `Codable`: JSON dönüşümünü destekler, böylece API'den gelen veriler çözümlenebilir.
struct Product: Identifiable, Codable {
    
    /// Ürünün benzersiz kimliği.
    let id: String
    
    /// Ürünün adı (örneğin: "Apple", "Bitcoin", "Tesla").
    let name: String
    
    /// Ürünün türü (örneğin: "Stock", "Crypto", "Commodity").
    let type: String
    
    /// Ürünün güncel piyasa değeri.
    let currentValue: Double
    
    /// Ürünün değer değişim yüzdesi (örneğin: +2.5% veya -1.3%).
    let percentageChange: Double
    
    /// Ürünün sembolü (örneğin: "AAPL" için Apple, "BTC" için Bitcoin).
    let symbol: String
    
    /// Son güncelleme zaman damgası (ISO 8601 formatında olabilir).
    let timestamp: String
    
    /// Ürünün görselinin URL'si veya dosya yolu.
    let image: String
}
