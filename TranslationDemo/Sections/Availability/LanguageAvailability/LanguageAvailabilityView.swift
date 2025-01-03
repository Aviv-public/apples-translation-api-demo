import SwiftUI
import Translation

// Define a view that displays the availability of a language pairing.
struct LanguageAvailabilityView: View {
    @Environment(LanguageAvailabilityViewModel.self) var viewModel

    // Define two bindings that represent the language pairing to check.
    @State private var selectedFrom: Locale.Language?
    @State private var selectedTo: Locale.Language?

    var selectedLanguagePair: LanguagePair {
        LanguagePair(selectedFrom: selectedFrom, selectedTo: selectedTo)
    }

    var body: some View {
        VStack(spacing: 20) {
            List {
                Section {
                    Text("Select a source and a target language to see whether a language pairing is supported:")
                }

                Picker("Source", selection: $selectedFrom) {
                    ForEach(viewModel.availableLanguages) { language in
                        Text(language.localizedName())
                            .tag(Optional(language.locale))
                    }
                }

                Picker("Target ", selection: $selectedTo) {
                    ForEach(viewModel.availableLanguages) { language in
                        Text(language.localizedName())
                            .tag(Optional(language.locale))
                    }
                }

                HStack {
                    Spacer()
                    // Update the interface when the observed view model changes.
                    if let isSupported = viewModel.isTranslationSupported {
                        Text(isSupported ? "✅" : "❌")
                            .font(.largeTitle)
                        if !isSupported {
                            Text("Translation to and from the same language isn't supported.")
                        }
                    } else {
                        Text("🤔")
                            .font(.largeTitle)
                    }
                    Spacer()
                }
            }
        }
        .onChange(of: selectedLanguagePair) {
            Task {
                // Perform a check when the selection changes.
                await performCheck()
            }
        }
        .onDisappear() {
            viewModel.reset()
        }
    }

    private func performCheck() async {
        guard let selectedFrom = selectedFrom else { return }
        guard let selectedTo = selectedTo else { return }

        // Perform the check in the view model for the given pairing.
        await viewModel.checkLanguageSupport(from: selectedFrom, to: selectedTo)
    }
}

struct LanguagePair: Equatable {
    @State var selectedFrom: Locale.Language?
    @State var selectedTo: Locale.Language?

    static func == (lhs: LanguagePair, rhs: LanguagePair) -> Bool {
        return lhs.selectedFrom == rhs.selectedFrom &&
        lhs.selectedTo == rhs.selectedTo
    }
}

#Preview {
    LanguageAvailabilityView()
        .environment(LanguageAvailabilityViewModel())

}
