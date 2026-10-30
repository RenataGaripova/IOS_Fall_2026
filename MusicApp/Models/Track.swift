struct Track {
    let title: String
    let artist: String
    let fileName: String
    let coverImageName: String
}

struct TrackLibrary {
    private(set) var tracks: [Track] = []
    
    static let defaultTracks: [Track] = [
        Track(title: "Golden", artist: "Neon Nite Club", fileName: "golden", coverImageName: "cover1"),
        Track(title: "Breathing In", artist: "Turxmusic", fileName: "breathingin", coverImageName: "cover1"),
        Track(title: "Fear", artist: "PeterPote", fileName: "fear", coverImageName: "cover2"),
        Track(title: "Fight in me", artist: "NDA", fileName: "figthinme", coverImageName: "cover3"),
        Track(title: "Hush", artist: "themasonaffair", fileName: "hush", coverImageName: "cover4"),
        Track(title: "Strings", artist: "anotherday", fileName: "strings", coverImageName: "cover5"),
        Track(title: "The Reason", artist: "fredriksn", fileName: "thereason", coverImageName: "cover6"),
        Track(title: "Where are you now", artist: "PNFA", fileName: "whereareyounow", coverImageName: "cover7"),
        Track(title: "Winter Wandering", artist: "roelandruijsch", fileName: "winter", coverImageName: "cover8"),
    ]
    
    init(tracks: [Track] = TrackLibrary.defaultTracks) {
        self.tracks = tracks
    }
}
