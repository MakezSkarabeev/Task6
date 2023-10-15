//
//  ContentView.swift
//  iOSCourse
//
//  Created by Sivenkov maxim  on 01.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isPressed = false

    private var layout: any Layout {
        isPressed ? DiagonalLayout() : HStackLayout()
    }

    var body: some View {
        VStack(alignment: .center) {
            AnyLayout(layout) {
                GridRow {
                    ForEach(0..<10) { _ in
                        Rectangle()
                            .fill(.blue)
                            .scaledToFit()
                            .onTapGesture {
                                isPressed.toggle()
                            }
                            .animation(.linear, value: isPressed)
                    }
                }
            }
        }
    }
}

struct DiagonalLayout: Layout {
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        CGSize(width: proposal.width ?? 0, height: proposal.height ?? 0)
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        for (index, subview) in subviews.enumerated() {
            let screenHeight = bounds.size.height
            let size = screenHeight / Double(subviews.count)

            let x = Double(index) * (bounds.size.width - size) / Double(subviews.count - 1)
            let y = screenHeight - size - Double(index) * screenHeight / Double(subviews.count) + bounds.origin.y

            subview.place(
                at: CGPoint(x: x, y: y),
                proposal: ProposedViewSize(CGSize(width: size, height: size))
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
