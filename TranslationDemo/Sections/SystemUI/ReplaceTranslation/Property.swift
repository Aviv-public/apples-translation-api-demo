import Foundation

struct Property {
    let imageUrl: URL?
    let title: String
    let location: String
    let state: String
    let price: Double
    let bedrooms: Int
    let bathrooms: Int
    let squareFootage: Int
    let description: String
}

extension Property {
    static var mock: Self {
        .init(
            imageUrl: URL(string: "https://picsum.photos/200/300"),
            title: "Spacious Family Home in Paris",
            location: "Paris",
            state: "FR",
            price: 850000,
            bedrooms: 4,
            bathrooms: 3,
            squareFootage: 250,
            description: """
            Cette spacieuse maison familiale située à Paris combine charme et modernité. Nichée dans un quartier prisé et calme, elle se trouve à proximité de toutes les commodités : écoles, parcs, et centres commerciaux sont facilement accessibles à pied. Avec ses quatre chambres généreuses et ses trois salles de bain, cette demeure est idéale pour les familles cherchant un espace de vie confortable et fonctionnel. La cuisine, récemment rénovée, est équipée d'appareils modernes et offre un accès direct à la terrasse, parfaite pour des repas en plein air.
            
            L'extérieur est tout aussi attrayant avec un grand jardin privé, offrant un espace de jeu pour les enfants et un havre de paix pour les adultes. Le salon spacieux et lumineux invite à la détente, tandis que l’agencement de la maison permet une belle circulation entre les espaces de vie. C’est un lieu où l'on peut facilement se sentir chez soi, entre confort et élégance, dans l'une des villes les plus prisées du monde.
            """
        )
    }
}
