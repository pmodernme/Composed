//
//  FlowLayout.swift
//  
//
//  Created by Zoe Van Brunt on 5/13/22.
//

#if canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
struct SizeKey: PreferenceKey {
    static let defaultValue: [CGSize] = []
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

@available(iOS 13.0, *)
struct SizeKey2<ID>: PreferenceKey {
    static var defaultValue: [Identified<ID, CGSize>] { [] }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

struct Identified<ID, A> {
    var id: ID
    var value: A
}

extension Identified: Equatable where ID: Equatable, A: Equatable { }

@available(iOS 13.0, *)
func layout(sizes: [CGSize], spacing: CGFloat = 10, containerWidth: CGFloat) -> [Range<Int>] {
    var result: [Range<Int>] = []
    var lineStart = sizes.startIndex
    while lineStart < sizes.endIndex {
        var currentX: CGFloat = 0
        var lineEnd = lineStart
        repeat {
            currentX += sizes[lineEnd].width + spacing
            lineEnd += 1
        } while lineEnd < sizes.endIndex && currentX + sizes[lineEnd].width < containerWidth
        result.append(lineStart..<lineEnd)
        lineStart = lineEnd
    }
    return result
}

@available(iOS 13.0, *)
struct MaxVisibleViewPreference: PreferenceKey {
    static let defaultValue: Int = 0
    static func reduce(value: inout Int, nextValue: () -> Int) {
        value = max(value, nextValue())
    }
}

@available(iOS 13.0, *)
public struct FlowLayout<Element: Identifiable & Equatable, Cell: View>: View {
    public init(items: [Element], cell: @escaping (Element) -> Cell, lastVisibleIndex: Int = 0) {
        self.items = items
        self.cell = cell
        self.lastVisibleIndex = lastVisibleIndex
    }
    
    var items: [Element]
    var cell: (Element) -> Cell
    @State private var sizes: [Int: CGSize] = [:]
    @State private var containerWidth: CGFloat = 0
    
    var measureStart: Int { sizes.keys.sorted().last ?? 0 }
    var measureEnd: Int { min(measureStart + 20, lastVisibleIndex) }
    @State var lastVisibleIndex = 0
    
    var hiddenMeasurements: some View {
        ZStack {
            ForEach(measureStart..<measureEnd, id: \.self) { ix in
                cell(items[ix])
                    .fixedSize()
                    .background(GeometryReader { proxy in
                        Color.clear.preference(key: SizeKey2.self, value: [Identified(id: ix, value: proxy.size)])
                    })
            }
        }.onPreferenceChange(SizeKey2<Int>.self, perform: { value in
            guard !value.isEmpty else { return }
            for pair in value {
                sizes[pair.id] = pair.value
            }
            print(value.first!.id, value.last!.id)
        }).id(measureStart..<measureEnd)
    }
    
    public var body: some View {
        let sizeIndices = self.sizes.keys.sorted()
        if !sizeIndices.isEmpty {
            assert(sizeIndices[0] == 0)
            assert(sizeIndices.last == sizeIndices.count-1)
        }
        let sizes = sizeIndices.map { self.sizes[$0]! }
        var lines = layout(sizes: sizes, containerWidth: containerWidth)
        if lines.isEmpty {
            lines = items.indices.map { ix in
                ix..<ix+1
            }
        } else {
            let lastVisibleIndex = lines.last!.endIndex
            lines.append(contentsOf: (lastVisibleIndex..<items.endIndex).map { ix in
                ix..<ix+1
            })
        }
        return VStack(alignment: .leading, spacing: 0) {
            GeometryReader { proxy in
                Color.clear.preference(key: SizeKey.self, value: [proxy.size])
            }
            .frame(height: 0)
            .onPreferenceChange(SizeKey.self) { value in
                self.containerWidth = value[0].width
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(lines.indices), id: \.self) { lineIndex in
                        
                        let line = lines[lineIndex]
                        HStack {
                            ForEach(Array(zip(line, items[line])), id: \.1.id) { (ix, item) in
                                cell(item)
                                    .fixedSize()
                                    .preference(key: MaxVisibleViewPreference.self, value: ix)
                            }
                        }
                    }
                }
                .onPreferenceChange(MaxVisibleViewPreference.self, perform: { value in
                    if value > lastVisibleIndex {
                        lastVisibleIndex = value
                    }
                    print("New last visible index: \(lastVisibleIndex)")
                })
                .id(containerWidth)
                .overlay(hiddenMeasurements.opacity(0))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#if DEBUG

struct Item: Identifiable, Hashable {
    var id = UUID()
    var value: String
}

@available(iOS 13.0, *)
struct FlowLayout_PreviewContainer: View {
    @State var items: [Item] = (1...25).map { "Item \($0) " + (Bool.random() ? "\n" : "")  + String(repeating: "x", count: Int.random(in: 0...10)) }.map { Item(value: $0) }
    
    var body: some View {
        FlowLayout(items: items, cell: { item in
            Text(item.value)
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.blue))
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

@available(iOS 13.0, *)
struct FlowLayout_Previews: PreviewProvider {
    static var previews: some View {
        FlowLayout_PreviewContainer()
    }
}

#endif
#endif
