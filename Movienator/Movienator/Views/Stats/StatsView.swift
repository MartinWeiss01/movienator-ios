//
//  StatsView.swift
//  Movienator
//
//  Created by Martin Weiss on 15.06.2023.
//

import SwiftUI
import SwiftUICharts

struct LibraryTypeChartObject {
    let name: String
    let count: Double
}

struct StatsView: View {
    @StateObject var movieViewModel: MovieViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    let typeData = getLibraryItemTypeData()
                    PieChartView(
                        data: typeData.map { $0.count },
                        title: "Movies vs TV Shows",
                        legend: getLibraryItemTypeLegend(typeData: typeData),
                        style: Styles.barChartMidnightGreenDark,
                        form: ChartForm.large
                    )
                }
            }
            .navigationTitle("Your Statistics")
        }
    }
    
    private func getLibraryItemTypeData() -> [LibraryTypeChartObject] {
        let movieCount = Double(movieViewModel.movieItems.count)
        let tvShowCount = Double(movieViewModel.movieItems.filter { $0.type == .TV }.count)
        
        let movieObject = LibraryTypeChartObject(name: "Movies", count: movieCount-tvShowCount)
        let tvShowObject = LibraryTypeChartObject(name: "TV Shows", count: tvShowCount)
        
        return [movieObject, tvShowObject]
    }
    
    private func getLibraryItemTypeLegend(typeData: [LibraryTypeChartObject]) -> String {
        let legend = typeData.map { "\($0.name): \(Int($0.count))" }.joined(separator: "\n")
        return legend
    }
}
