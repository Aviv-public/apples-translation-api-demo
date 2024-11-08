import SwiftUI
import Translation

struct LegalDisclaimerDemoView: View {
    let legalTextTitle = "Nutzungsbedingungen"
    let legalText = """
    Diese App dient ausschließlich zu Informationszwecken und ersetzt keine professionelle Immobilienberatung, finanzielle Beratung oder juristische Dienstleistungen. Obwohl wir uns bemühen, genaue und aktuelle Informationen bereitzustellen, übernehmen wir keine Gewähr für die Vollständigkeit, Zuverlässigkeit oder Eignung von Immobilienangeboten, Marktdaten oder anderen Inhalten, die in dieser App verfügbar sind. Benutzer sollten alle Informationen unabhängig überprüfen, bevor sie Entscheidungen in Bezug auf Immobilien treffen.

    Durch die Nutzung dieser App erklären Sie sich damit einverstanden, dass wir nicht für Entscheidungen verantwortlich sind, die Sie auf der Grundlage der hier verfügbaren Informationen treffen. Dies umfasst unter anderem finanzielle Verluste, vertragliche Streitigkeiten oder andere Haftungen, die sich aus Ihrem Vertrauen in unsere Inhalte oder der Interaktion mit Dritten ergeben, die über die App verbunden sind. Alle Immobilienangebote, Schätzungen und andere Daten dienen nur als Referenz und spiegeln möglicherweise nicht die aktuellsten Marktbedingungen oder -werte wider.

    Bitte beachten Sie, dass wir keine bestimmten Immobilien, Makler oder Dienstleister empfehlen oder unterstützen. Links zu Websites oder Ressourcen von Drittanbietern dienen lediglich zur Benutzerfreundlichkeit und implizieren keine Unterstützung unsererseits. Sie erklären sich damit einverstanden, dass die Nutzung der App auf eigenes Risiko erfolgt und Sie allein für alle Interaktionen oder Transaktionen verantwortlich sind, die sich aus der Nutzung der App ergeben.
    """

    var textToBeTranslated: String {
        legalTextTitle + "\n" + legalText
    }

    @State var isTranslationOverlayPresented = false

    var body: some View {
        List {
            Section {
                Label {
                    Text(
                        "Due to local regulations, below disclaimer has to be shown in local language."
                    )
                } icon: {
                    Image(systemName: "info.square")
                }
                .foregroundStyle(.orange)
            } footer: {
                Text("You can still review the content in your preferred language by tapping on the little translate icon right upper corner.")
            }

            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Text(legalTextTitle)
                        .bold()

                    Text(verbatim: legalText)
                        .translationPresentation(
                            isPresented: $isTranslationOverlayPresented,
                            text: textToBeTranslated
                        )
                }
                .overlay(alignment: .topTrailing) {
                    Button {
                        // Show translate overlay
                        isTranslationOverlayPresented = true
                    } label: {
                        Image(systemName: "translate")
                    }
                }
            }
        }
        .navigationTitle("Legal Disclaimer")
    }
}

#Preview {
    LegalDisclaimerDemoView()
}
