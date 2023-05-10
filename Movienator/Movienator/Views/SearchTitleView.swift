//
//  SearchTitleView.swift
//  Movienator
//
//  Created by Martin Weiss on 10.05.2023.
//

import SwiftUI

struct SearchTitleView: View {
    @State var title: String
    var body: some View {
        Text("\(title)")
    }
}

struct SearchTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTitleView(title: "Fast and Furious")
    }
}
