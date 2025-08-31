//
//  APGWorkFAQ.swift
//  APGWorkKit
//
//  Created by Steve Sheets on 8/19/25.
//

// MARK: Imports

import Foundation
import APGCantripKit
import APGWidgetKit
import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

// MARK: - Structure

/// Single Quest & Answer for FAQ
public struct APGWorkFAQEntry: Decodable, Identifiable, Hashable {
    public let id: UUID
    public let question: String
    public let answer: String

    public init(question: String, answer: String) {
        self.id = UUID()
        self.question = question
        self.answer = answer
    }
}

/// List of Entry with topic title
public struct APGWorkFAQTopic: Decodable, Identifiable, Hashable {
    public let id: UUID
    public let title: String
    public var entries: [APGWorkFAQEntry]

    public init(title: String, entries: [APGWorkFAQEntry]) {
        self.id = UUID()
        self.title = title
        self.entries = entries
    }
}

/// Reference (doc or html) to display Title, and open Ref
public struct APGWorkFAQReference: Decodable, Identifiable, Hashable {
    public let id: UUID
    public let title: String
    public let ref: String

    public init(title: String, ref: String) {
        self.id = UUID()
        self.title = title
        self.ref = ref
    }
}

// MARK: - Class

/// Static manager for the FAQ window..
@MainActor
public final class APGWorkFAQ {
    private init() {}

    public static func show() {
        APGWidgetWindow.makeWindow(
            title: APGWorkShared.faqForAppName,
            ident: APGWorkShared.identifierFAQWindow,
            size: CGSize(width: 500, height: 600)
        ) {
            APGWorkMacFAQView(
                topics: APGWorkAppSpecs.shared.faqTopics ?? [],
                references: APGWorkAppSpecs.shared.faqReferences ?? []
            )
        }
    }
}

// MARK: - SwiftUI View

private struct APGWorkMacFAQView: View {
    let topics: [APGWorkFAQTopic]
    let references: [APGWorkFAQReference]

    @State private var expandedIDs = Set<UUID>()

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(topics) { topic in
                        APGWorkFAQTopicView(topic: topic, expandedIDs: $expandedIDs)
                    }
                }
                .padding(.vertical)
            }

            Divider()

            APGWorkFAQReferenceBar(references: references)
        }
    }
}

private struct APGWorkFAQTopicView: View {
    let topic: APGWorkFAQTopic
    @Binding var expandedIDs: Set<UUID>

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(topic.title)
                .font(.title2)
                .bold()

            ForEach(topic.entries) { entry in
                APGWorkFAQEntryView(entry: entry, expandedIDs: $expandedIDs)
            }
        }
        .padding(.horizontal)
    }
}

private struct APGWorkFAQEntryView: View {
    let entry: APGWorkFAQEntry
    @Binding var expandedIDs: Set<UUID>

    var body: some View {
        DisclosureGroup(
            isExpanded: Binding(
                get: { expandedIDs.contains(entry.id) },
                set: { newValue in
                    if newValue {
                        expandedIDs.insert(entry.id)
                    } else {
                        expandedIDs.remove(entry.id)
                    }
                }
            )
        ) {
            Text("A: \(entry.answer)")
                .padding(.leading, 10)
                .padding(.top, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
        } label: {
            Text("Q: \(entry.question)")
                .bold()
        }
        .buttonStyle(.plain)
    }
}

private struct APGWorkFAQReferenceBar: View {
    let references: [APGWorkFAQReference]

    var body: some View {
        HStack {
            Spacer()
            ForEach(references) { ref in
                Button(ref.title) {
                    APGCantrip.openRef(ref.ref)
                }
            }
        }
        .padding(8)
        .background(Color.gray.opacity(0.15))
    }
}

