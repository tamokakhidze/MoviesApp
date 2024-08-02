//
//  SearchView.swift
//  MoviesApp
//
//  Created by Tamuna Kakhidze on 04.06.24.
//
import SwiftUI

// MARK: - Search view
struct SearchView: View {
    // MARK: - Properties
    @StateObject var viewModel = SearchViewModel()
    
    var gridColumns: [GridItem] {
        let screenWidth = UIScreen.main.bounds.width
        
        if screenWidth >= 768 {
            return Array(repeating: GridItem(.flexible(minimum: 100, maximum: 200), spacing: 100, alignment: .center), count: 2)

        } else {
            return [
                GridItem(.flexible(minimum: 100, maximum: 200), spacing: 20, alignment: .center)
            ]
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    SearchBarView(viewModel: viewModel)
                }
                
                if viewModel.resultArray.isEmpty {
                    SearchMessages(viewModel: viewModel)
                } else {
                    ScrollView {
                        LazyVGrid(columns: gridColumns) {
                            ForEach(viewModel.resultArray) { result in
                                SearchCard(movie: result)
                            }
                        }
                    }.padding()
                }
            }
            .navigationTitle("Search")
            .background(.customBackground)
        }.environmentObject(viewModel)
    }
}

// MARK: - SearchBarView
struct SearchBarView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        HStack(spacing: 19) {
            // MARK: - Textfield with search icon
            HStack(alignment: .center) {
                TextField("Search movie", text: $viewModel.text)
                    .padding(8)
                    .background(Color(.searchBarBackground))
                    .padding(.horizontal)
                    .frame(height: 42)
                
                Image("search")
                    .renderingMode(.template)
                    .foregroundStyle(.customGray)
                    .padding(.trailing, 30)
            }
            .background(Color(.searchBarBackground), alignment: .center)
            .cornerRadius(16)
            
            // MARK: - Picker for filtering
            Menu {
                Picker(selection: $viewModel.filterCase, label: EmptyView()) {
                    ForEach(Filter.allCases) { option in
                        Text(option.rawValue.capitalized)
                    }
                }
                .pickerStyle(.automatic)
                .accentColor(.primaryText)
                .onChange(of: viewModel.filterCase) {
                    viewModel.onSwitchFilter()
                }
            } label: {
                Image(.menu)
                    .renderingMode(.template)
                    .foregroundStyle(.customGray)
            }
        }.padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
    }
}
// MARK: - SearchMessages
struct SearchMessages: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            if viewModel.text.isEmpty {
                Text("Use the magic search!")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.secondary)
                    .fontWeight(.medium)
                
                Text("I will do my best to search everything relevant, I promise!")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 11))
                    .foregroundStyle(.primaryText)
                    .fontWeight(.regular)
            } else {
                Text("Oops!!")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.secondary)
                    .fontWeight(.medium)
                
                Text("I cannot find any movie with this \(viewModel.filterCase.rawValue.lowercased()).")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 11))
                    .foregroundStyle(.primaryText)
                    .fontWeight(.regular)
            }
        }
        .padding(62)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
