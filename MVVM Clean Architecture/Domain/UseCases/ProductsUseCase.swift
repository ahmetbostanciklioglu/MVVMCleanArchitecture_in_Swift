import Foundation
import Combine

/// Şirketlerin (Company) listesini getiren **kullanım senaryosu (Use Case)** protokolü.
/// - Bu protokol, veri kaynağına (repository) bağımlı olmadan tüm şirketleri getiren bir metod tanımlar.
/// - **Dependency Inversion (Bağımlılıkları Tersine Çevirme)** prensibine uygundur.
protocol ProductsUseCase {
    
    /// Tüm şirketleri getirir.
    /// - Returns: `[Company]` dizisini içeren bir `AnyPublisher`. Hata durumunda `Error` döndürür.
    func execute() -> AnyPublisher<[Company], Error>
}

/// `ProductsUseCaseImpl`, `ProductsUseCase` protokolünü uygulayan sınıftır.
/// - **Tek Sorumluluk İlkesi'ne (SRP) uygundur**.
/// - **Açık/Kapalı İlkesi'ni (OCP) destekler**, çünkü `ProductsRepository` bağımlılığı değiştirilebilir.
class ProductsUseCaseImpl: ProductsUseCase {
    
    /// Ürün verilerini almak için kullanılan repository.
    private let repository: ProductsRepository
    
    /// `ProductsUseCaseImpl` için başlatıcı (initializer).
    /// - Parameter repository: Şirket verilerini sağlayan `ProductsRepository` örneği.
    init(repository: ProductsRepository) {
        self.repository = repository
    }
    
    /// **Tüm şirketleri getirir.**
    /// - Repository’den verileri çeker ve **Combine kullanarak asenkron olarak döndürür.**
    /// - Returns: `[Company]` dizisini içeren bir `AnyPublisher`, hata durumunda `Error` döndürür.
    func execute() -> AnyPublisher<[Company], Error> {
        return repository.fetchAllProducts()
    }
}
