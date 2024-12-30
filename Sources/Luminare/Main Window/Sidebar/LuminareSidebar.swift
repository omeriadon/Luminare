//
//  LuminareSidebar.swift
//  Luminare
//
//  Created by Kai Azim on 2024-09-29.
//

import SwiftUI

public struct LuminareSidebar<Content>: View where Content: View {
    @Environment(\.appearsActive) private var appearsActive

    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        VStack(spacing: 24) {
            content()
        }
        .opacity(appearsActive ? 1 : 0.5)
        .padding(.horizontal, 12)
        .frame(minHeight: 580, maxHeight: .infinity, alignment: .top)
        .luminareBackground()
    }
}
