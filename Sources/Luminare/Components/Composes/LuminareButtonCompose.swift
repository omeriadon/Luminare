//
//  LuminareButtonCompose.swift
//  Luminare
//
//  Created by Adon Omeri on 23/3/2026.
//

import SwiftUI

@resultBuilder
public struct LuminareButtonBuilder {
    public static func buildBlock(_ components: any View...) -> [any View] {
        components
    }
}

public enum PositionInList {
    case top, middle, bottom, unknown
}

public struct LuminareButtonCompose: View {
    @Environment(\.luminareButtonComposeSpacing) private var spacing
    
    private let buttons: [any View]
    private let positionInList: PositionInList
    
    public init(
        _ positionInList: PositionInList = .unknown,
        @LuminareButtonBuilder _ buttons: () -> [any View]
    ) {
        self.positionInList = positionInList
        self.buttons = buttons()
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(Array(buttons.enumerated()), id: \.offset) { index, button in
                let isFirst = index == 0
                let isLast = index == buttons.count - 1
                
                AnyView(
                    button
                        .luminareRoundingBehavior(
                            topLeading:     positionInList == .middle || positionInList == .bottom ? false :
                                positionInList == .unknown                             ? true :
                                isFirst ? true : false,
                            topTrailing:    positionInList == .middle || positionInList == .bottom ? false :
                                positionInList == .unknown                             ? true :
                                isLast  ? true : false,
                            bottomLeading:  positionInList == .middle || positionInList == .top    ? false :
                                positionInList == .unknown                             ? true :
                                isFirst ? true : false,
                            bottomTrailing: positionInList == .middle || positionInList == .top    ? false :
                                positionInList == .unknown                             ? true :
                                isLast  ? true : false
                        )
                )
            }
        }
        .buttonStyle(.luminare)
    }
}

@available(macOS 15.0, *)
#Preview(
    "LuminareButton",
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
