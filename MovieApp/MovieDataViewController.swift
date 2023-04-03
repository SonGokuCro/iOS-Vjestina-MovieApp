//
//  MovieDataViewController.swift
//  MovieApp
//
//  Created by endava-bootcamp on 02.04.2023..
//
import PureLayout
import MovieAppData

class MovieDataViewController : ViewController, UICollectionViewDelegate {
    let favouriteBgColor = UIColor(red: 71, green: 70, blue: 70, alpha: 1)
    let favourited = UIColor(red: 103/255, green: 177/255, blue: 219/255, alpha: 1)
    
    var movieCover = UIImageView()
    var ratingLabel = UILabel()
    var userScoreLabel = UILabel()
    var nameLabel = UILabel()
    var dateLabel = UILabel()
    var genreLabel = UILabel()
    var favouriteButton = UIButton()
    var overviewLabel = UILabel()
    var overviewText = UITextView()
    let details = MovieUseCase().getDetails(id: 111161)

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        buildView()
        collection()
    }
    
    func initViews() {
        view.addSubview(movieCover)
        movieCover.addSubview(ratingLabel)
        movieCover.addSubview(userScoreLabel)
        movieCover.addSubview(nameLabel)
        movieCover.addSubview(dateLabel)
        movieCover.addSubview(genreLabel)
        movieCover.addSubview(favouriteButton)
        view.addSubview(overviewLabel)
        view.addSubview(overviewText)
    }
    
    func buildView(){
        view.backgroundColor = .white
        imageFunc()
        rating()
        userScore()
        name()
        year()
        genre()
        favourite()
        overview()
        overviewScroll()
    }
    
    func imageFunc(){
        guard let url = details?.imageUrl else { return }
        movieCover.loadFrom(URLAddress: url)
        movieCover.autoPinEdge(toSuperviewEdge: .leading)
        movieCover.autoPinEdge(toSuperviewEdge: .trailing)
        movieCover.autoPinEdge(toSuperviewEdge: .top)
        movieCover.autoSetDimension(.height, toSize: 327)
    }
    
    func rating(){
        ratingLabel.autoSetDimensions(to: CGSize(width: 40, height: 30))
        ratingLabel.textColor = .white
        let stringText = String(Double(details?.rating ?? 0.0))
        ratingLabel.text = stringText
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 16)
        ratingLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        ratingLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 130)
    }
    
    func userScore(){
        userScoreLabel.autoSetDimensions(to: CGSize(width: 80, height: 20))
        userScoreLabel.textColor = .white
        userScoreLabel.text = "User score"
        userScoreLabel.font = UIFont.systemFont(ofSize: 12)
        userScoreLabel.autoPinEdge(.leading, to: .trailing, of: ratingLabel, withOffset:8)
        userScoreLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 135)
    }
    
    func name(){
        nameLabel.autoSetDimensions(to: CGSize(width: 350, height: 35))
        nameLabel.textColor = .white
        nameLabel.text = details?.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.autoPinEdge(.top, to: .bottom, of: userScoreLabel, withOffset: 15)
        nameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
    }
    
    func year() {
        dateLabel.autoSetDimensions(to: CGSize(width: 105, height: 20))
        dateLabel.textColor = .white
        guard let stringDate = details?.releaseDate else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: stringDate) {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let formattedDate = dateFormatter.string(from: date)
            dateLabel.text = formattedDate + " (US)"
        }
        
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        
        dateLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 16)
        dateLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
    }
    
    func genre(){
        var string = ""
        let size: Int = details?.categories.count ?? 0
  
        for i in 0..<size {
            if details?.categories[i] == MovieCategoryModel.action {
                string = string + "Action, "
            }
            if details?.categories[i] == MovieCategoryModel.adventure {
                string = string + "Adventure, "
            }
            if details?.categories[i] == MovieCategoryModel.comedy {
                string = string + "Comedy, "
            }
            if details?.categories[i] == MovieCategoryModel.crime {
                string = string + "Crime, "
            }
            if details?.categories[i] == MovieCategoryModel.drama {
                string = string + "Drama, "
            }
            if details?.categories[i] == MovieCategoryModel.fantasy {
                string = string + "Fantasy, "
            }
            if details?.categories[i] == MovieCategoryModel.romance {
                string = string + "Romance, "
            }
            if details?.categories[i] == MovieCategoryModel.scienceFiction {
                string = string + "Science fiction, "
            }
            if details?.categories[i] == MovieCategoryModel.thriller {
                string = string + "Thriller, "
            }
            if details?.categories[i] == MovieCategoryModel.western {
                string = string + "Western, "
            }
        }
        let minutes = details?.duration ?? 0
        let duration = String(format: "%2dh %2dm", minutes / 60, minutes % 60)
        string = string.trimmingCharacters(in: [" ", ","])
        string.append(" " + duration)
        
        genreLabel.text = string
        genreLabel.font = UIFont.systemFont(ofSize: 12)
        genreLabel.textColor = .white
        genreLabel.autoSetDimensions(to: CGSize(width: 270, height: 20))
        
        genreLabel.autoPinEdge(.top, to: .bottom, of: dateLabel)
        genreLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
    }
    
    @objc
        private func favouriteButtonTapped(){
            favouriteButton.layer.backgroundColor = CGColor(red: 103, green: 177, blue: 219, alpha: 0.5)
        }
    
    
    func favourite() {
        favouriteButton.autoSetDimensions(to: CGSize(width: 34, height: 34))
        favouriteButton.alpha = 0.6
        favouriteButton.layer.backgroundColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1).cgColor
        favouriteButton.layer.cornerRadius = 17
        favouriteButton.addTarget(self, action: #selector(self.favouriteButtonTapped), for: .touchUpInside)

        let starSymbol = UIImage(systemName: "star")
        let favContainer = UIImageView(image: starSymbol)
        favContainer.frame = CGRect(x: 10, y: 10, width: 14, height: 14)
        favContainer.tintColor = .white
                
        favouriteButton.addSubview(favContainer)
        favouriteButton.autoPinEdge(.top, to: .bottom, of: genreLabel, withOffset: 16)
        favouriteButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
    }
    
    func overview () {
        overviewLabel.textColor = .black
        overviewLabel.text = "Overview"
        overviewLabel.font = UIFont.boldSystemFont(ofSize: 20)
        overviewLabel.autoSetDimensions(to: CGSize(width: 350, height: 30))
        
        overviewLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        overviewLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 350)
    }
    
    func overviewScroll() {
        overviewText.textColor = .black
        overviewText.text = details?.summary
        overviewText.font = UIFont.systemFont(ofSize: 14)
        overviewText.autoSetDimensions(to: CGSize(width: 360, height: 70))
        
        overviewText.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        overviewText.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 8)
    }
    
    func collection () {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout )
        view.addSubview(collectionView)
        
        let spacing:CGFloat = 16
        flowlayout.minimumInteritemSpacing = CGFloat(spacing)
        flowlayout.minimumLineSpacing = CGFloat(spacing)
        
        collectionView.autoPinEdge(toSuperviewEdge: .top, withInset: 480)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        
        collectionView.autoSetDimension(.height, toSize: 105)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension MovieDataViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details?.crewMembers.count ?? 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        let data = details?.crewMembers[indexPath.item]
        cell.titleLabel.text = data?.name
        cell.subtitleLabel.text = data?.role
        return cell
    }
}
extension MovieDataViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 15
        let width = (collectionView.bounds.width - 4 * spacing) / 3
        return CGSize(width: width, height: 40)
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


class CustomCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .black
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        
        titleLabel.autoPinEdge(toSuperviewEdge: .top)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing)
        
        subtitleLabel.autoPinEdge(toSuperviewEdge: .leading)
        subtitleLabel.autoPinEdge(toSuperviewEdge: .trailing)
        subtitleLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        subtitleLabel.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}
