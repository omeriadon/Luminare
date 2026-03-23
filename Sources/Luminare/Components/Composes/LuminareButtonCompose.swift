//
//  LuminareButtonCompose.swift
//  Luminare
//
//  Created by Adon Omeri on 23/3/2026.
//

import SwiftUI
import VariadicViews

public enum LuminareButtonComposePosition: Equatable {
    case top, middle, bottom, unknown
}

public struct LuminareButtonCompose<Content: View>: View {
    @Environment(\.luminareButtonComposeSpacing) private var spacing

    private let positionInList: LuminareButtonComposePosition
    private let content: () -> Content

    public init(
        _ positionInList: LuminareButtonComposePosition = .unknown,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.positionInList = positionInList
        self.content = content
    }

    public var body: some View {
        UnaryVariadicView(content()) { children in
            LuminareButtonComposeLayout(
                children: children,
                spacing: spacing,
                positionInList: positionInList
            )
        }
        .buttonStyle(.luminare)
    }
}

// MARK: - Layout

struct LuminareButtonComposeLayout: View {
    let children: VariadicViewChildren
    let spacing: CGFloat
    let positionInList: LuminareButtonComposePosition

    var body: some View {
        let first = children.first?.id
        let last = children.last?.id

        let roundTop = positionInList == .unknown || positionInList == .top
        let roundBottom = positionInList == .unknown || positionInList == .bottom

        HStack(spacing: spacing) {
            ForEach(children) { child in
                let isFirst = child.id == first
                let isLast = child.id == last

                child
                    .luminareRoundingBehavior(
                        topLeading: roundTop && isFirst,
                        topTrailing: roundTop && isLast,
                        bottomLeading: roundBottom && isFirst,
                        bottomTrailing: roundBottom && isLast
                    )
            }
        }
    }
}

// MARK: - Preview

@available(macOS 15.0, *)
#Preview(
    "LuminareButtonCompose",
    traits: .sizeThatFitsLayout
) {
    LuminarePane {
        LuminareSection {
            Text("LuminareButtonCompose")

            LuminareButtonCompose(.bottom) {
                Button {
                    print(1)
                } label: {
                    Text("Button 1")
                }

                Button {
                    print(1)
                } label: {
                    Text("Button 1")
                }

                Button {
                    print(2)
                } label: {
                    Text("Button 2")
                }
            }
        }
    }
}
