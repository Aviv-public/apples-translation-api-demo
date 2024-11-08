import SwiftUI

struct MainView: View {
    @State private var replaceTranslationViewModel = PropertyDetailDemoViewModel(property: .mock)
    @State private var languageAvailabilityViewModel = LanguageAvailabilityViewModel()

    var body: some View {
        TabView {
            Tab {
                NavigationStack {
                    List {
                        Section {
                            NavigationLink {
                                LegalDisclaimerDemoView()
                            } label: {
                                RowView(
                                    title: "Overlay Translation",
                                    subtitle: "Translate a single String",
                                    imageName: "arrow.up.arrow.down"
                                )
                            }

                            NavigationLink {
                                PropertyDetailDemoView()
                                    .environment(replaceTranslationViewModel)
                            } label: {
                                RowView(
                                    title: "Replace Translation",
                                    subtitle: "Translate and replace a single String",
                                    imageName: "arrow.circlepath"
                                )
                            }
                        } footer: {
                            Text("These translations are provided with an overlay on top of the app in a sheet")
                        }
                    }
                    .navigationTitle("System UI")
                }
            } label: {
                Image(systemName: "apple.logo")
            }

            Tab {
                NavigationStack {
                    List {
                        Section {
                            NavigationLink {
                                ContactSellerView()
                            } label: {
                                RowView(
                                    title: "Single String",
                                    subtitle: "Translate a single String with a custom overlay",
                                    imageName: "arrow.left.arrow.right"
                                )
                            }

                            NavigationLink {
                                SurveyPageView()
                            } label: {
                                RowView(
                                    title: "Batch of Strings",
                                    subtitle: "Translate a single String with a custom overlay",
                                    imageName: "line.3.horizontal"
                                )
                            }

                            NavigationLink {
                                RealEstateAgentProfileView()
                            } label: {
                                RowView(
                                    title: "Batch as a Sequence",
                                    subtitle: "Translate a single String with a custom overlay",
                                    imageName: "line.3.horizontal.decrease"
                                )
                            }
                        }footer: {
                            Text("These translations are provided by system and we have more freedom over the results")
                        }
                    }
                    .navigationTitle("Custom UI")
                }
            } label: {
                Image(systemName: "applepencil.and.scribble")
            }

            Tab {
                NavigationStack {
                    List {
                        Section {
                            NavigationLink {
                                LanguageAvailabilityView()
                                    .environment(languageAvailabilityViewModel)
                            } label: {
                                RowView(title: "Language Availability",
                                        subtitle: "Check whether a translation can occur.",
                                        imageName: "lightswitch.on")
                            }

                            NavigationLink {
                                PrepareTranslationView()
                            } label: {
                                RowView(
                                    title: "Prepare for Translation",
                                    subtitle: "Initiate a language download.",
                                    imageName: "arrow.down.circle"
                                )
                            }
                        } footer: {
                            Text("Check if a language is available and prepare for translation")
                        }
                    }
                    .navigationTitle("Availability")
                }
            } label: {
                Image(systemName: "gear")
            }
        }
        .navigationTitle("Translation Demos")
    }
}

#Preview {
    MainView()
}
