import UIKit

class DetailViewController: UIViewController {
    var show: FavoriteShow?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starImageView: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let show = show else { return }
        
        title = show.title
        imageView.image = UIImage(named: show.image)
        titleLabel.text = show.title
        yearLabel.text = String(show.year)
        descriptionLabel.text = show.description
        var text = ""
        for author in show.authors {
            text += "• \(author)\n"
        }
        authorsLabel.text = text
        for star in starImageView.sorted(by: { $0.tag < $1.tag }) {
            star.image = UIImage(systemName: star.tag <= show.rating ? "star.fill" : "star")
        }
    }
}
