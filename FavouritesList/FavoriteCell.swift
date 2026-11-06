import UIKit

final class FavoriteCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var starImageViews: [UIImageView]!
    
    func configure(with item: FavoriteItem) {
        photoImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        descriptionLabel.text = item.subtitle

        let stars = starImageViews.sorted { $0.tag < $1.tag }
        for (index, star) in stars.enumerated() {
            star.image = UIImage(systemName: index < item.rating ? "star.fill" : "star")
        }
    }
}
