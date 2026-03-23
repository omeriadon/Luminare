//
//  LuminareButtonCompose.swift
//  Luminare
//
//  Created by Adon Omeri on 23/3/2026.
//

import SwiftUI

@resultBuilder
public struct LuminareButtonBuilder {
    public static func buildExpression(_ expression: some View) -> AnyView {
        AnyView(expression)
    }

    public static func buildBlock(_ components: AnyView...) -> [AnyView] {
        components
    }

    public static func buildOptional(_ component: [AnyView]?) -> [AnyView] {
        component ?? []
    }

    public static func buildEither(first component: [AnyView]) -> [AnyView] {
        component
    }

    public static func buildEither(second component: [AnyView]) -> [AnyView] {
        component
    }

    public static func buildArray(_ components: [[AnyView]]) -> [AnyView] {
        components.flatMap(\.self)
    }
}

public struct LuminareButtonCompose: View {
    @Environment(\.luminareButtonComposeSpacing) private var spacing

    private let buttons: [AnyView]
    private let positionInList: PositionInList

    public init(
        _ positionInList: PositionInList = .unknown,
        @LuminareButtonBuilder _ buttons: () -> [AnyView]
    ) {
        self.positionInList = positionInList
        self.buttons = buttons()
    }

    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(buttons.indices, id: \.self) { index in
                let button = buttons[index]

                let isFirst = index == 0
                let isLast = index == buttons.count - 1

                let roundTop = positionInList == .unknown || positionInList == .top
                let roundBottom = positionInList == .unknown || positionInList == .bottom

                button
                    .luminareRoundingBehavior(
                        topLeading: roundTop && isFirst,
                        topTrailing: roundTop && isLast,
                        bottomLeading: roundBottom && isFirst,
                        bottomTrailing: roundBottom && isLast
                    )
            }
        }
        .buttonStyle(.luminare)
    }

    public enum PositionInList {
        case top, middle, bottom, unknown
    }
}

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
