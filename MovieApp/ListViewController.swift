import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let shows = FavoriteShow.defaultShows
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selected = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selected, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetail",
            let detailVC = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.show = shows[indexPath.row]
    }
}

extension ListViewController: UITableViewDelegate {}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        let show = shows[indexPath.row]
        cell.titleLabel.text = show.title
        cell.imageView!.image = UIImage(named: show.image)
        return cell
    }
}
