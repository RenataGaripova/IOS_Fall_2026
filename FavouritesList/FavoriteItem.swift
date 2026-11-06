struct FavoriteItem {
    let title: String
    let subtitle: String
    let imageName: String
    let rating: Int
}

struct ItemsData {
    private(set) var items: [FavoriteItem] = []
    
    static let defaultItems: [FavoriteItem] = [
        FavoriteItem(title: "Pizza Margherita", subtitle: "Italy · tomatoes, mozzarella and basil", imageName: "pizza", rating: 5),
        FavoriteItem(title: "Plov", subtitle: "Uzbekistan · rice dish made with meat, carrots, onions, and spices", imageName: "plov", rating: 5),
        FavoriteItem(title: "Chak-chak", subtitle: "Tatar · fried dough pieces in honey", imageName: "chak-chak", rating: 5),
        FavoriteItem(title: "Syrniki", subtitle: "Russia · cottage cheese pancakes", imageName: "syrniki", rating: 5),
        FavoriteItem(title: "Pasta Carbonara", subtitle: "Italy · spaghetti, egg, guanciale and pecorino", imageName: "carbonara", rating: 5),
        FavoriteItem(title: "Olivier Salad", subtitle: "Russia · potatoes, eggs, peas and mayonnaise", imageName: "olivier", rating: 3),
        FavoriteItem(title: "Gubadia", subtitle: "Tatar · layered sweet pie with rice and dried fruit", imageName: "gubadia", rating: 4),
        FavoriteItem(title: "Borscht", subtitle: "Ukraine · beet soup with sour cream", imageName: "borscht", rating: 4),
        FavoriteItem(title: "Pelmeni", subtitle: "Russia · dumplings with meat filling", imageName: "pelmeni", rating: 4),
        FavoriteItem(title: "Shashlik", subtitle: "Caucasus · meat skewers grilled over coals", imageName: "shashlik", rating: 5),
        FavoriteItem(title: "Beef Stroganoff", subtitle: "Russia · beef strips in creamy sauce", imageName: "stroganoff", rating: 5),
        FavoriteItem(title: "Tom Yum", subtitle: "Thailand · spicy and sour soup", imageName: "tomyum", rating: 3),
        FavoriteItem(title: "Echpochmak", subtitle: "Tatar · triangle pastry with meat, potato and onion", imageName: "echpochmak", rating: 4),
        FavoriteItem(title: "Shawarma", subtitle: "Middle East · meat and vegetables in flatbread", imageName: "shawarma", rating: 4),
        FavoriteItem(title: "Kystyby", subtitle: "Tatar · flatbread filled with mashed potatoes", imageName: "kystyby", rating: 3),
        FavoriteItem(title: "Croissant", subtitle: "France · flaky butter pastry", imageName: "croissant", rating: 3),
        FavoriteItem(title: "Caesar Salad", subtitle: "Romaine, chicken, croutons and parmesan", imageName: "caesar", rating: 4),
        FavoriteItem(title: "Khinkali", subtitle: "Georgia · juicy dumplings filled with broth", imageName: "khinkali", rating: 5),
        FavoriteItem(title: "Tiramisu", subtitle: "Italy · mascarpone and coffee dessert", imageName: "tiramisu", rating: 5),
        FavoriteItem(title: "Blini", subtitle: "Russia · thin pancakes with sour cream or jam", imageName: "bliny", rating: 2)
    ]
    
    init(items: [FavoriteItem] = ItemsData.defaultItems) {
        self.items = items
    }
}
