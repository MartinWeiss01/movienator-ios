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
                    HStack {
                        let typeData = getLibraryItemTypeData()
                        PieChartView(
                            data: typeData.map { $0.count },
                            title: "Library Items",
                            legend: getLibraryItemTypeLegend(typeData: typeData),
                            style: Styles.barChartMidnightGreenDark,
                            form: ChartForm.medium
                        )
                        
                        let watchStateData = getWatchStateData()
                        PieChartView(
                            data: watchStateData.map { $0.count },
                            title: "Watch State",
                            legend: getWatchStateLegend(watchStateData: watchStateData),
                            style: Styles.barChartStyleNeonBlueDark,
                            form: ChartForm.medium
                        )
                    }
                    
                    Spacer()
                    
                    let ratingData = getRatingData()
                    
                    HStack {
                        BarChartView(
                            data: ChartData(values: ratingData),
                            title: "Ratings",
                            style: Styles.barChartStyleNeonBlueLight,
                            form: ChartForm.extraLarge,
                            dropShadow: false,
                            cornerImage: Image(systemName: "star.fill"),
                            valueSpecifier: "%.0f× in your library"
                        )
                    }
                    .padding(.vertical, 12)
                }
                .padding(.vertical, 12)
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
        let legend = typeData.map { "\($0.name): \(Int($0.count))×" }.joined(separator: "\n")
        return legend
    }
    
    private func getWatchStateData() -> [LibraryTypeChartObject] {
        let wantToWatchCount = Double(movieViewModel.movieItems.filter { $0.watchState == .WantToWatch }.count)
        let watchedCount = Double(movieViewModel.movieItems.filter { $0.watchState == .Watched }.count)

        let wantToWatchObject = LibraryTypeChartObject(name: "Watchlist", count: wantToWatchCount)
        let watchedObject = LibraryTypeChartObject(name: "Watched list", count: watchedCount)

        return [wantToWatchObject, watchedObject]
    }

    private func getWatchStateLegend(watchStateData: [LibraryTypeChartObject]) -> String {
        let legend = watchStateData.map { "\($0.name): \(Int($0.count))×" }.joined(separator: "\n")
        return legend
    }
    
    private func getRatingData() -> [(String, Int)] {
        let data = (0...10).map { rating in
            let count = movieViewModel.movieItems.reduce(0) { result, movieItem in
                let roundedRating = movieItem.rating.rounded(.down)
                return result + (roundedRating == Double(rating) ? 1 : 0)
            }
            return ("\(rating)/10", count)
        }
        return data
    }
}
