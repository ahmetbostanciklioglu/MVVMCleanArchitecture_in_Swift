import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel : HomeViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.title)
            List(viewModel.companies) { company in
                Text(company.name)
            }
        }
        .onAppear {
            viewModel.fetchCompanies()
        }
    }
}

