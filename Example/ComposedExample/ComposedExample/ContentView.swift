//
//  ContentView.swift
//  ComposedExample
//
//  Created by Zoe Van Brunt on 1/9/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            UIViewControllerPreview { ComposedExampleVC() }
            .tabItem {
                Image(systemName: "1.square.fill")
                Text("Composed")
            }
            UIViewControllerPreview { CGGeometryExampleVC() }
            .tabItem {
                Image(systemName: "2.square.fill")
                Text("Composed")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
