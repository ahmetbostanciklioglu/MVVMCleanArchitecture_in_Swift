import Foundation
import Combine

/// Ağ istekleri sırasında oluşabilecek hata türlerini temsil eden `NetworkError` enum'u.
/// - `decodingError(DecodingError.Context)`: JSON çözme hatası.
/// - `urlError(URLError)`: URL ile ilgili hata (örn: sunucuya ulaşılamaması).
enum NetworkError: Error {
    case decodingError(DecodingError.Context)
    case urlError(URLError)
}

/// `NetworkService`, ağ isteklerini yönetmek için kullanılan bir servis sınıfıdır.
/// Combine framework'ü kullanılarak asenkron veri akışı sağlanır.
class NetworkService {
    
    /// Belirtilen URL'den veri çeker ve verilen türde (`T: Decodable`) decode eder.
    /// - Parameter url: Veri çekilecek `URL` adresi.
    /// - Returns: `AnyPublisher<T, Error>` olarak veri yayını döndürür.
    /// - T: Decode edilebilir (`Decodable`) bir model türü olmalıdır.
    func request<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        
        return URLSession.shared.dataTaskPublisher(for: url)
            /// İşlemi arka planda (`background thread`) çalıştırarak performansı artırır.
            .subscribe(on: DispatchQueue.global(qos: .background))
            
            /// Sunucudan gelen veriyi kontrol eder ve HTTP durum kodunu doğrular.
            .tryMap { data, response in
                /// Yanıtın HTTP protokolüne uygun olup olmadığını kontrol eder.
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)  // Geçersiz yanıt hatası fırlatır.
                }
                return data
            }
            
            /// Veriyi ana iş parçacığında (`main thread`) işler, böylece UI güncellemeleri sorunsuz çalışır.
            .receive(on: DispatchQueue.main)
            
            /// JSON verisini `T` türüne çözümler (`decode` eder).
            .decode(type: T.self, decoder: JSONDecoder())
            
            /// Publisher türünü `AnyPublisher` olarak soyutlar.
            .eraseToAnyPublisher()
    }
}
