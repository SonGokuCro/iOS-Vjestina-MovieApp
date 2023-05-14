import PureLayout
import MovieAppData

class MovieDataViewController : ViewController, UICollectionViewDelegate {
    let favouriteBgColor = UIColor(red: 71, green: 70, blue: 70, alpha: 1)
    let favourited = UIColor(red: 103/255, green: 177/255, blue: 219/255, alpha: 1)
    
    let details = MovieUseCase().getDetails(id: 111161)
    var movieCover: UIImageView!
    var ratingLabel: UILabel!
    var userScoreLabel: UILabel!
    var nameLabel: UILabel!
    var dateLabel: UILabel!
    var yearLabel: UILabel!
    var genreLabel: UILabel!
    var durationLabel: UILabel!
    var favouriteButton: UIButton!
    var overviewLabel: UILabel!
    var summary: UITextView!
    var flowlayout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViews()
    }
    
    func buildViews(){
        initViews()
        styleViews()
        defineLayout()
    }
    
    func initViews() {
        movieCover = UIImageView()
        view.addSubview(movieCover)
                        
        ratingLabel = UILabel()
        view.addSubview(ratingLabel)
        
        userScoreLabel = UILabel()
        view.addSubview(userScoreLabel)
        
        nameLabel = UILabel()
        view.addSubview(nameLabel)
        
        dateLabel = UILabel()
        view.addSubview(dateLabel)
        
        yearLabel = UILabel()
        view.addSubview(yearLabel)
        
        genreLabel = UILabel()
        view.addSubview(genreLabel)
        
        durationLabel =  UILabel()
        view.addSubview(durationLabel)
        
        favouriteButton = UIButton()
        view.addSubview(favouriteButton)
        
        overviewLabel = UILabel()
        view.addSubview(overviewLabel)
        
        summary = UITextView()
        view.addSubview(summary)

        flowlayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout )
        view.addSubview(collectionView)
    }
    
    func styleViews() {
        let url = details?.imageUrl ?? nil
        movieCover.loadFrom(URLAddress: url!)

        ratingLabel.text = String(details!.rating)
        
        nameLabel.text = String(details!.name)
        yearLabel.text = " (" + String(details!.year) + ")"
        
        summary.text = String(details!.summary)

        var string = ""
        let categories = details!.categories
        
        for category in categories {
            if(string == "") {
                string = String(describing: category).localizedCapitalized
            } else {
                string = ", " + String(describing: category).localizedCapitalized
            }
        }
        genreLabel.text = string
        
        let minutes = details!.duration
        let duration = String(format: "%2dh %2dm", minutes / 60, minutes % 60)
        string = string.trimmingCharacters(in: [" ", ","])
        string.append(" " + duration)
        durationLabel.text = duration;
        
        let stringDate = details!.releaseDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: stringDate) {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let formattedDate = dateFormatter.string(from: date)
            dateLabel.text = formattedDate + " (US)"
        }
        
        movieCover.contentMode = .scaleAspectFill
        movieCover.clipsToBounds = true
        
        ratingLabel.textColor = .white
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        userScoreLabel.textColor = .white
        userScoreLabel.text = "User score"
        userScoreLabel.font = UIFont.systemFont(ofSize: 14)
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        yearLabel.textColor = .white
        yearLabel.font = UIFont.systemFont(ofSize: 18)

        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .white

        genreLabel.textColor = .white
        genreLabel.font = UIFont.systemFont(ofSize: 14)
        
        durationLabel.textColor = .white
        durationLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        favouriteButton.backgroundColor = favouriteBgColor
        favouriteButton.frame.size = CGSize(width: 34, height: 34)
        favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favouriteButton.layer.cornerRadius = favouriteButton.bounds.width / 2
        favouriteButton.autoSetDimensions(to: favouriteButton.frame.size)
        favouriteButton.clipsToBounds = true
        favouriteButton.alpha = 0.6
        favouriteButton.addTarget(self, action: #selector(self.favouriteButtonTapped), for: .touchUpInside)
 
        overviewLabel.textColor = .black
        overviewLabel.text = "Overview"
        overviewLabel.font = UIFont.boldSystemFont(ofSize: 20)
      
        summary.textColor = .black
        summary.font = UIFont.systemFont(ofSize: 14)
        
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumInteritemSpacing = CGFloat(16)
        flowlayout.minimumLineSpacing = CGFloat(16)
        
        collectionView.register(MembersCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func defineLayout() {
        movieCover.autoPinEdge(toSuperviewEdge: .leading)
        movieCover.autoPinEdge(toSuperviewEdge: .trailing)
        movieCover.autoPinEdge(toSuperviewEdge: .top)
        movieCover.autoSetDimension(.height, toSize: 327)
        
        ratingLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        ratingLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 130)
        
        userScoreLabel.autoPinEdge(.leading, to: .trailing, of: ratingLabel, withOffset:8)
        userScoreLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 135)
        
        nameLabel.autoPinEdge(.top, to: .bottom, of: userScoreLabel, withOffset: 15)
        nameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        yearLabel.autoPinEdge(.top, to: .bottom, of: ratingLabel, withOffset: 14)
        yearLabel.autoPinEdge(.leading, to: .trailing, of: nameLabel, withOffset: 3)
        
        dateLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 16)
        dateLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        genreLabel.autoPinEdge(.top, to: .bottom, of: dateLabel)
        genreLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        durationLabel.autoPinEdge(.leading, to: .trailing, of: genreLabel, withOffset: 15)
        durationLabel.autoPinEdge(.top, to: .bottom, of: dateLabel)
        
        favouriteButton.autoPinEdge(.top, to: .bottom, of: genreLabel, withOffset: 16)
        favouriteButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        overviewLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        overviewLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 350)
        
        summary.autoPinEdge(toSuperviewSafeArea: .leading,withInset: 10)
        summary.autoPinEdge(.top, to: .bottom, of: overviewLabel,withOffset: 8)
        summary.autoPinEdge(toSuperviewSafeArea: .trailing,withInset: 10)
        summary.autoPinEdge(toSuperviewEdge: .bottom,withInset: 400)
        
        collectionView.autoPinEdge(toSuperviewEdge: .top, withInset: 480)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoSetDimension(.height, toSize: 105)
    
    }

    @objc
        private func favouriteButtonTapped(){
            favouriteButton.backgroundColor = favourited
        }
    }

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }

        DispatchQueue.global(qos: .background).async {
            if let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async { [weak self] in
                    if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                    }
                }
            }
        }
    }
}

extension MovieDataViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details?.crewMembers.count ?? 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MembersCell
        let data = details?.crewMembers[indexPath.item]
        cell.titleLabel.text = data?.name
        cell.subtitleLabel.text = data?.role
        return cell
    }
}

extension MovieDataViewController: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 15
        let width = (collectionView.bounds.width - 4 * spacing) / 3
        return CGSize(width: width, height: 40)
    }
}


