////
////  APGWorkMacWelcome.swift
////  MacDocSpike
////
////  Created by Steve Sheets on 8/19/25.
////
////  Custom iWork-style Welcome box
////
//
//// MARK: - Class
//
//import AppKit
//
//// MARK: - Class
//
//public final class APGWorkMacWelcome {
//
//    // MARK: - Stored Data
//
//    private var subTitle = String()
//    private var agreementRef: String? = nil
//    private var imageNames: [String] = []
//    private var features: [APGWorkFeatureItem] = []
//
//    // MARK: - Init
//
//    private init() {}
//
//    // MARK: - Preference Key
//
//    public static var shouldShowWelcome: Bool {
//        !UserDefaults.standard.bool(forKey: APGStrings.default_welcome_screen)
//    }
//
//    public static func reset() {
//        UserDefaults.standard.removeObject(forKey: APGStrings.default_welcome_screen)
//    }
//
//    public static func dismiss() {
//        UserDefaults.standard.set(true, forKey: APGStrings.default_welcome_screen)
//        NSApp.windows.first(where: { $0.identifier?.rawValue == APGStrings.window_welcome })?.close()
//    }
//
//    // MARK: - Show Window
//
//    public func show() {
//        APGWindowTool.makeWindow(
//            title: kEmptyString,
//            ident: APGStrings.window_welcome,
//            size: CGSize(width: 900, height: 600)
//        ) {
//            APGWorkMacWelcomeView(
//                subTitle: self.subTitle,
//                agreementRef: self.agreementRef,
//                imageNames: self.imageNames,
//                features: self.features
//            )
//        }
//    }
//}
//
//// MARK: - SwiftUI View
//
//private struct APGWorkMacWelcomeView: View {
//    let subTitle: String
//    let agreementRef: String?
//    let imageNames: [String]
//    let features: [APGWorkFeatureItem]
//
//    @State private var showingGetStarted = false
//
//    var body: some View {
//        VStack(spacing: 0) {
//            if showingGetStarted {
//                getStartedView
//                    .transition(.move(edge: .leading))
//            } else {
//                welcomeView
//                    .transition(.move(edge: .trailing))
//            }
//        }
//        .frame(width: 900, height: 600)
//        .background(Color.white)
//    }
//
//    var welcomeView: some View {
//        VStack(spacing: 0) {
//            Spacer().frame(height: 40)
//
//            Text(kAPGString.hr_welcome_to + kSpaceString + APGStrings.appName)
//                .font(.custom(APGStrings.font_geneva, size: 36))
//                .padding(.bottom, 8)
//
//            Rectangle()
//                .fill(Color.gray.opacity(0.3))
//                .frame(height: 1)
//                .padding(.horizontal, 100)
//
//            if !subTitle.isEmpty {
//                Text(subTitle)
//                    .font(.title3)
//                    .multilineTextAlignment(.center)
//                    .padding(.top, 12)
//                    .padding(.horizontal, 60)
//            }
//
//            Spacer()
//
//            APGStackedImageView(imageNames: Array(imageNames.prefix(5)))
//
//            Spacer()
//
//            HStack {
//                Spacer()
//                APGLargeButton(title: kAPGString.hr_continue, isDefault: true) {
//                    withAnimation {
//                        showingGetStarted = true
//                    }
//                }
//                Spacer()
//            }
//            .padding(.vertical)
//            .frame(height: 60)
//            .background(Color(NSColor.windowBackgroundColor).opacity(0.9))
//        }
//    }
//
//    var getStartedView: some View {
//        VStack(spacing: 0) {
//            Spacer().frame(height: 30)
//
//            Text(kAPGString.hr_get_started)
//                .font(.custom(APGStrings.font_geneva, size: 36))
//                .padding(.bottom, 4)
//
//            Rectangle()
//                .fill(Color.gray.opacity(0.3))
//                .frame(height: 1)
//                .padding(.horizontal, 100)
//
//            ScrollView {
//                VStack(alignment: .leading, spacing: 28) {
//                    ForEach(Array(features.prefix(6)), id: \.id) { feature in
//                        HStack(alignment: .top, spacing: 20) {
//                            if let image = feature.imageName?.loadNSImage {
//                                Image(nsImage: image)
//                                    .renderingMode(.original)
//                                    .interpolation(.high)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 60, height: 60)
//                            }
//
//                            VStack(alignment: .leading, spacing: 8) {
//                                Text(feature.title)
//                                    .font(.title2)
//                                    .bold()
//                                Text(feature.description)
//                                    .font(.system(size: 18))
//                                    .fixedSize(horizontal: false, vertical: true)
//                            }
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 160)
//                    }
//                }
//                .padding(.top, 32)
//            }
//
//            HStack(spacing: 40) {
//                APGLargeButton(title: kAPGString.hr_view_my + kSpaceString +  APGStrings.documentTypePluralName) {
//                    NSDocumentController.shared.openDocument(nil)
//                    APGWelcomeWindow.dismiss()
//                }
//
//                APGLargeButton(title: kAPGString.hr_create + kSpaceString + APGStrings.documentTypeName, isDefault: true) {
//                    NSDocumentController.shared.newDocument(nil)
//                    APGWelcomeWindow.dismiss()
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .padding(.vertical)
//            .frame(height: 60)
//            .background(Color(NSColor.windowBackgroundColor).opacity(0.9))
//        }
//    }
//}
