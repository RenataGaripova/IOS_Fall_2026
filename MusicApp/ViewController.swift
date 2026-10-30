import UIKit
import AVFoundation


class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    private var trackLibrary: TrackLibrary = TrackLibrary()
    private var index: Int = 0
    private var isPlaying: Bool = false
    private var player: AVAudioPlayer?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        loadTrack(at: index)
        updateUI()
    }
    
    @IBAction private func playPauseTapped(_ sender: UIButton) {
        guard let player else { return }
        if isPlaying { player.pause() } else { player.play() }
        isPlaying.toggle()
        updateUI()
    }
    
    @IBAction private func nextTapped(_ sender: UIButton) {
        switchTrack(by: 1)
    }
    
    @IBAction private func previousTapped(_ sender: UIButton) {
        switchTrack(by: -1)
    }
    
    private func switchTrack(by step: Int) {
        let tracksCount: Int = trackLibrary.tracks.count
        index = (index + step + tracksCount) % tracksCount
        loadTrack(at: index)
        if isPlaying {
            player?.play()
        }
        updateUI()
    }
    
    private func loadTrack(at index: Int) {
        player?.stop()
        player = nil
        
        let track: Track = trackLibrary.tracks[index]
        guard let url = Bundle.main.url(forResource: track.fileName, withExtension: "mp3") else {
            print("Error: file \(track.fileName).mp3 was not found.")
            isPlaying = false
            return
        }
        do {
            let newPlayer = try AVAudioPlayer(contentsOf: url)
            newPlayer.delegate = self
            newPlayer.prepareToPlay()
            player = newPlayer
        } catch {
            print("Error: Could not open file \(track.fileName).mp3.")
            isPlaying = false
        }
    }
    
    private func updateUI() {
        let track = trackLibrary.tracks[index]
        titleLabel.text = track.title
        artistLabel.text = track.artist
        coverImageView.image = UIImage(named: track.coverImageName) ?? UIImage(systemName: "music.note")
        playButton.configuration?.image = UIImage(systemName: isPlaying ? "pause.fill" : "play.fill")
    }
}


extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        switchTrack(by: 1)
    }
}
