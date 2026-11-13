import Foundation

struct FavoriteShow {
    let title: String
    let year: Int
    let authors: [String]
    let image: String
    let rating: Int
    let description: String
}

extension FavoriteShow {
    static let defaultShows: [FavoriteShow] = [
            FavoriteShow(
                title: "The Crown",
                year: 2016,
                authors: ["Peter Morgan"],
                image: "crown",
                rating: 5,
                description: "Follows the political rivalries and romances of Queen Elizabeth II's reign and the events that shaped Britain for the second half of the 20th century. The series moves from her wedding and coronation to the modern era. Each season brings a new cast to show the royal family growing older."
            ),
            FavoriteShow(
                title: "Grey's Anatomy",
                year: 2005,
                authors: ["Shonda Rhimes"],
                image: "greys",
                rating: 4,
                description: "An American medical drama focusing on the personal and professional lives of surgical interns, residents, and attendings at the fictional Seattle Grace Hospital. The show follows Meredith Grey from her first day as an intern to her years as a leading surgeon. It is one of the longest-running medical dramas on American television."
            ),
            FavoriteShow(
                title: "Pretty Little Liars",
                year: 2010,
                authors: ["I. Marlene King", "Sara Shepard"],
                image: "pll",
                rating: 4,
                description: "Set in the fictional Rosewood, Pennsylvania, the plot follows five best friends whose secrets are consistently threatened by the anonymous 'A'. Their leader Alison disappeared a year earlier, and soon the girls start receiving threatening messages. Every attempt to uncover A's identity leads to new lies and new dangers."
            ),
            FavoriteShow(
                title: "Stranger Things",
                year: 2016,
                authors: ["Matt Duffer", "Ross Duffer"],
                image: "stranger",
                rating: 5,
                description: "In 1980s Indiana, a group of young friends witness supernatural forces and secret government exploits. As they search for answers, the children unravel a series of extraordinary mysteries. The story mixes science fiction, horror and 1980s nostalgia."
            ),
            FavoriteShow(
                title: "The Queen's Gambit",
                year: 2020,
                authors: ["Scott Frank", "Allan Scott"],
                image: "gambit",
                rating: 5,
                description: "Orphaned at the tender age of nine, prodigious introvert Beth Harmon discovers and masters the game of chess in 1960s USA. But child stardom comes at a price. On her way to the top she struggles with addiction and loneliness."
            ),
            FavoriteShow(
                title: "Dr. House",
                year: 2004,
                authors: ["David Shore"],
                image: "house",
                rating: 5,
                description: "Using a crack team of doctors and his wits, an antisocial maverick doctor specializing in diagnostic medicine does whatever it takes to solve puzzling cases that come his way. Dr. Gregory House is brilliant but rude, and he trusts no one, including his patients. Each episode is a medical mystery that his team must solve before it is too late."
            ),
            FavoriteShow(
                title: "The Good Doctor",
                year: 2017,
                authors: ["David Shore"],
                image: "good_dr",
                rating: 4,
                description: "Shaun Murphy, a young surgeon with autism and Savant Syndrome, is recruited into the surgical unit of a prestigious hospital. Many colleagues doubt that he can work with patients. Shaun proves them wrong with his remarkable memory and his honest view of the world."
            ),
            FavoriteShow(
                title: "Harry Potter",
                year: 2001,
                authors: ["J.K. Rowling", "Chris Columbus", "David Yates"],
                image: "harry_potter",
                rating: 5,
                description: "An orphan boy, mistreated by his relatives, discovers he's a wizard. He receives a letter to attend Hogwarts School, where he finds friendship, magic, and adventure. Over the years he grows up and prepares for the final battle against the dark wizard Voldemort."
            ),
            FavoriteShow(
                title: "Money Heist",
                year: 2017,
                authors: ["Álex Pina"],
                image: "money_heist",
                rating: 4,
                description: "An unusual group of robbers attempts to carry out the most perfect robbery in Spanish history: stealing 2.4 billion euros from the Royal Mint of Spain. The plan is led by a mysterious man known as the Professor. Inside the building, hostages, police and the robbers' own emotions threaten to ruin everything."
            ),
            FavoriteShow(
                title: "The Hunger Games",
                year: 2012,
                authors: ["Suzanne Collins", "Gary Ross", "Francis Lawrence"],
                image: "hunger_games",
                rating: 5,
                description: "In the dystopian nation of Panem, teenagers are forced to fight to the death in a televised competition. Katniss Everdeen volunteers to take her younger sister's place in the Games. Her courage turns her into a symbol of rebellion against the Capitol."
            ),
            FavoriteShow(
                title: "Friends",
                year: 1994,
                authors: ["David Crane", "Marta Kauffman"],
                image: "friends",
                rating: 5,
                description: "Six friends navigate work, love and everyday life in New York City. Most of their time is spent in their apartments and at the Central Perk coffee shop. The show became one of the most beloved sitcoms of all time."
            ),
            FavoriteShow(
                title: "Squid Game",
                year: 2021,
                authors: ["Hwang Dong-hyuk"],
                image: "squid_game",
                rating: 4,
                description: "Hundreds of people deep in debt accept an invitation to play children's games for a huge cash prize. They soon discover that losing a game means losing their life. The series explores how far people will go when they have nothing left to lose."
            ),
            FavoriteShow(
                title: "Sherlock",
                year: 2010,
                authors: ["Steven Moffat", "Mark Gatiss"],
                image: "sherlock",
                rating: 5,
                description: "A modern version of the classic detective stories set in present-day London. Sherlock Holmes solves impossible cases with the help of his loyal friend Dr. John Watson. His greatest challenge is the brilliant criminal mastermind Jim Moriarty."
            ),
            FavoriteShow(
                title: "Peaky Blinders",
                year: 2013,
                authors: ["Steven Knight"],
                image: "peaky_blinders",
                rating: 4,
                description: "In Birmingham after the First World War, the Shelby family leads a dangerous street gang. Ambitious Thomas Shelby wants to turn the family business into a real empire. His rise brings him into conflict with police, rival gangs and politicians."
            ),
            FavoriteShow(
                title: "Dark",
                year: 2017,
                authors: ["Baran bo Odar", "Jantje Friese"],
                image: "dark",
                rating: 5,
                description: "The disappearance of a child in a small German town reveals the secrets of four families. The search leads to a cave that connects different time periods. Past, present and future turn out to be tied together in a complex loop."
            ),
            FavoriteShow(
                title: "Bridgerton",
                year: 2020,
                authors: ["Chris Van Dusen", "Shonda Rhimes"],
                image: "bridgerton",
                rating: 3,
                description: "In Regency-era London, the eight Bridgerton siblings search for love and happiness. Each season focuses on a different member of the family and their romance. An anonymous gossip writer, Lady Whistledown, follows every scandal of high society."
            ),
            FavoriteShow(
                title: "Kitchen",
                year: 2012,
                authors: ["Dmitry Dyachenko", "Zhora Kryzhovnikov", "Anton Fedotov"],
                image: "kitchen",
                rating: 5,
                description: "Young cook Max Lavrov comes to Moscow and gets a job at Claude Monet, one of the city's best restaurants. The kitchen is run by a strict and temperamental head chef, and every shift turns into chaos. The sitcom follows the funny and romantic life of the restaurant team."
            ),
            FavoriteShow(
                title: "Severance",
                year: 2022,
                authors: ["Dan Erickson", "Ben Stiller"],
                image: "severance",
                rating: 5,
                description: "Employees of the mysterious company Lumon undergo a procedure that splits their memories between work and personal life. At the office they know nothing about their life outside, and at home they forget everything about their job. Mark and his colleagues start to wonder what the company is really hiding."
            ),
            FavoriteShow(
                title: "Black Mirror",
                year: 2011,
                authors: ["Charlie Brooker"],
                image: "black_mirror",
                rating: 4,
                description: "An anthology series where every episode tells a separate story with new characters. Each story shows how technology can change people and society in unexpected ways. Many episodes feel like a warning about the near future."
            ),
            FavoriteShow(
                title: "Supernatural",
                year: 2005,
                authors: ["Eric Kripke"],
                image: "supernatural",
                rating: 4,
                description: "Brothers Sam and Dean Winchester travel across America hunting ghosts, demons and other supernatural creatures. They continue the work of their father, who taught them to fight evil since childhood. Over fifteen seasons their battles grow from local monsters to threats against the whole world."
            ),
            FavoriteShow(
                title: "Fisher",
                year: 2023,
                authors: ["Sergey Taramaev", "Lyubov Lvova"],
                image: "fisher",
                rating: 5,
                description: "The series is based on a real criminal case from the Moscow region in the 1980s. A team of investigators spends years hunting a dangerous serial killer known as Fisher. The story is as much about the people chasing him as about the crimes themselves."
            )
        ]
}

