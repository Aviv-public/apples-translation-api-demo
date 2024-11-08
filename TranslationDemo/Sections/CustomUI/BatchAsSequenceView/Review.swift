import Foundation

// Struct to represent a review
struct Review: Identifiable {
    let id = UUID()
    var text: String
    let date: String
    let reviewerName: String
}

extension [Review] {
    static var reviews: Self {
        [
            Review(text: "Jean est un agent incroyable. Il m'a aidé à trouver la maison parfaite pour ma famille.", date: "2024-10-15", reviewerName: "Sophie Martin"),
            Review(text: "Bien que Jean soit compétent, la communication aurait pu être meilleure.", date: "2024-10-14", reviewerName: "Lucas Dupuis"),
            Review(text: "Jean a été très réactif et m'a soutenu tout au long du processus d'achat.", date: "2024-10-13", reviewerName: "Amélie Petit"),
            Review(text: "Je ne suis pas entièrement satisfait de mon expérience. J'attendais plus d'aide.", date: "2024-10-12", reviewerName: "Marc Bernard"),
            Review(text: "Jean est vraiment professionnel. Je le recommande à tous mes amis.", date: "2024-10-11", reviewerName: "Claire Lefèvre"),
            Review(text: "Il a fait un excellent travail pour vendre ma maison rapidement.", date: "2024-10-10", reviewerName: "François Moreau"),
            Review(text: "Je ne me sens pas à l'aise avec le prix que j'ai payé. J'aurais aimé avoir plus de conseils.", date: "2024-10-09", reviewerName: "Isabelle Dubois"),
            Review(text: "Jean est très sympathique et a rendu le processus amusant.", date: "2024-10-08", reviewerName: "Pauline Garnier"),
            Review(text: "Malheureusement, je ne me suis pas senti soutenu pendant la vente.", date: "2024-10-07", reviewerName: "Julien Renaud"),
            Review(text: "Une expérience incroyable! Je n'aurais pas pu demander un meilleur agent.", date: "2024-10-06", reviewerName: "Émilie Fournier"),
            Review(text: "Les choses ont été un peu lentes. J'espérais une meilleure réactivité.", date: "2024-10-05", reviewerName: "Nicolas Lambert"),
            Review(text: "Jean est un agent dévoué qui se soucie vraiment de ses clients.", date: "2024-10-04", reviewerName: "Chloé Girard"),
            Review(text: "Je suis déçu par le manque d'informations sur le marché immobilier.", date: "2024-10-03", reviewerName: "Antoine Charles"),
            Review(text: "Jean a fait un excellent travail en nous guidant dans l'achat de notre première maison.", date: "2024-10-02", reviewerName: "Marie Boucher"),
            Review(text: "Je ne peux pas le recommander. Je ne me suis pas senti écouté.", date: "2024-10-01", reviewerName: "Victor Noel"),
            Review(text: "Une très bonne expérience. Jean a toujours été à l'écoute de mes besoins.", date: "2024-09-30", reviewerName: "Sophie Dupont")
        ]
    }
}
