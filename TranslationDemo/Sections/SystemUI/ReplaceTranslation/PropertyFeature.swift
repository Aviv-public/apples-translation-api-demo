import SwiftUI

struct PropertyFeature: View {
    let iconName: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.blue)
            Text(value)
                .font(.subheadline)
        }
    }
}
