import Foundation
import Translation

@Observable
class LanguageAvailabilityViewModel {
    var isTranslationSupported: Bool?
    var availableLanguages: [AvailableLanguage] = []

    init() {
        prepareSupportedLanguages()
    }

    func prepareSupportedLanguages() {
        Task { @MainActor in
            let supportedLanguages = await LanguageAvailability().supportedLanguages
            availableLanguages = supportedLanguages.map {
                AvailableLanguage(locale: $0)
            }.sorted()
        }
    }

    func reset() {
        isTranslationSupported = nil
    }

    func checkLanguageSupport(from source: Locale.Language, to target: Locale.Language) async {
        let availability = LanguageAvailability()
        let status = await availability.status(from: source, to: target)

        switch status {
        case .installed, .supported:
            isTranslationSupported = true
        case .unsupported:
            isTranslationSupported = false
        @unknown default:
            print("Not supported")
        }
    }
}

struct AvailableLanguage: Identifiable, Hashable, Comparable {
    var id: Self { self }
    let locale: Locale.Language

    func localizedName() -> String {
        let locale = Locale.current
        let shortName = shortName()

        guard let localizedName = locale.localizedString(forLanguageCode: shortName) else {
            return "Unknown language code"
        }

        return "\(localizedName) (\(shortName))"
    }

    private func shortName() -> String {
        "\(locale.languageCode ?? "")-\(locale.region ?? "")"
    }

    static func <(lhs: AvailableLanguage, rhs: AvailableLanguage) -> Bool {
        return lhs.localizedName() < rhs.localizedName()
    }
}


