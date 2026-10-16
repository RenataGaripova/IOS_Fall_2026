//
//  ViewController.swift
//  BestTVShows
//
//  Created by Рената Гарипова on 16.10.2026.
//

import UIKit

struct Show {
    let title: String
    let description: String
    let releaseYears: String
    let imageName: String
}

class ViewController: UIViewController {
    
    private let favouriteShows: [Show] = [
        Show(title: "The Crown", description: "Follows the political rivalries and romances of Queen Elizabeth II's reign and the events that shaped Britain for the second half of the 20th century.", releaseYears: "2016-2023", imageName: "crown"),
        Show(title: "Grey's Anatomy", description: "Grey's Anatomy is an American medical drama television series focusing on the personal and professional lives of surgical interns, residents, and attendings at the fictional Seattle Grace Hospital.", releaseYears: "2005-2026", imageName: "greys"),
        Show(title: "Pretty Little Liars", description: "Set in the fictional Rosewood, Pennsylvania, the plot follows five best friends whose secrets are consistently threatened by the anonymous 'A'.", releaseYears: "2010-2017", imageName: "pll"),
        Show(title: "Stranger Things", description: "In 1980s Indiana, a group of young friends witness supernatural forces and secret government exploits. As they search for answers, the children unravel a series of extraordinary mysteries.", releaseYears: "2016-2025", imageName: "stranger"),
        Show(title: "The Queen's Gambit", description: "Orphaned at the tender age of nine, prodigious introvert Beth Harmon discovers and masters the game of chess in 1960s USA. But child stardom comes at a price.", releaseYears: "2020", imageName: "gambit"),
        Show(title: "Dr. House", description: "Using a crack team of doctors and his wits, an antisocial maverick doctor specializing in diagnostic medicine does whatever it takes to solve puzzling cases that come his way.", releaseYears: "2004-2012", imageName: "house"),
        Show(title: "The Good Doctor", description: "Shaun Murphy, a young surgeon with autism and Savant Syndrome, is recruited into the surgical unit of a prestigious hospital.", releaseYears: "2017-2024", imageName: "good_dr"),
        Show(title: "Harry Potter", description: "An orphan boy, mistreated by his relatives, discovers he's a wizard. He receives a letter to attend Hogwarts School, where he finds friendship, magic, and adventure.", releaseYears: "2001 - 2011", imageName: "harry_potter"),
        Show(title: "Money Heist", description: "An unusual group of robbers attempts to carry out the most perfect robbery in Spanish history: stealing 2.4 billion euros from the Royal Mint of Spain.", releaseYears: "2017 - 2011", imageName: "money_heist")
        
    ]
    private var currentIndex: Int?
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        demonstrateShow(at: 0)
    }
    
    @IBAction func randomChoice(_ button: UIButton) {
        let available = favouriteShows.indices.filter { $0 != currentIndex }
        guard let newIndex = available.randomElement() else { return }
        demonstrateShow(at: newIndex)
    }
    
    private func demonstrateShow(at index: Int) {
        let show = favouriteShows[index]
        coverImageView.image = UIImage(named: show.imageName)
        titleLabel.text = show.title
        descriptionLabel.text = show.description
        yearsLabel.text = show.releaseYears
        currentIndex = index
    }


}

