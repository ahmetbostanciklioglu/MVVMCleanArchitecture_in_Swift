import Foundation
import Combine

/// Ürün verilerini yöneten repository protokolü.
/// Bağımlılık Enjeksiyonu (Dependency Injection) sayesinde,
/// farklı veri kaynaklarıyla (API, veritabanı vb.) çalışmaya olanak tanır.
protocol ProductsRepository {
    /// Tüm ürünleri çeker.
    /// - Returns: `[Company]` dizisini içeren bir `AnyPublisher`, hata durumunda `Error` döndürür.
    func fetchAllProducts() -> AnyPublisher<[Company], Error>
}

/// `ProductsRepositoryImpl`, `ProductsRepository` protokolünü uygulayan bir repository sınıfıdır.
/// `ProductsService` ile haberleşerek ürün verilerini çeker.
class ProductsRepositoryImpl: ProductsRepository {
    
    /// Ürün verilerini almak için kullanılan servis.
    private let productsService: ProductsService
    
    /// `ProductsRepositoryImpl` için başlatıcı (initializer).
    /// - Parameter productsService: API çağrılarını yöneten `ProductsService` nesnesi.
    init(productsService: ProductsService) {
        self.productsService = productsService
    }
    
    /// API'den tüm ürünleri çeker.
    /// - Returns: `[Company]` dizisini içeren bir `AnyPublisher`, hata durumunda `Error` döndürür.
    func fetchAllProducts() -> AnyPublisher<[Company], Error> {
        return productsService.fetchCompanies()
    }
}
