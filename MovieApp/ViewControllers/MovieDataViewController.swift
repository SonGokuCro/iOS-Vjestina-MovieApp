import PureLayout
import MovieAppData

class MovieDataViewController : ViewController, UICollectionViewDelegate {
    let favouriteBgColor = UIColor(red: 71, green: 70, blue: 70, alpha: 1)
    let favourited = UIColor(red: 103/255, green: 177/255, blue: 219/255, alpha: 1)
    
    
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
    
    var upperFirst: UILabel!
    var upperSecond: UILabel!
    var upperThird: UILabel!
    var bottomFirst: UILabel!
    var bottomSecond: UILabel!
    var bottomThird: UILabel!
    
    var verticalStackView: UIStackView!
    var horizontalStackView1: UIStackView!
    var horizontalStackView2: UIStackView!
            
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
        
        verticalStackView = UIStackView()
        view.addSubview(verticalStackView)

        horizontalStackView1 = UIStackView()
        view.addSubview(horizontalStackView1)

        horizontalStackView2 = UIStackView()
        view.addSubview(horizontalStackView2)
        
        upperFirst = UILabel()
        view.addSubview(upperFirst)

        upperSecond = UILabel()
        view.addSubview(upperSecond)

        upperThird = UILabel()
        view.addSubview(upperThird)

        bottomFirst = UILabel()
        view.addSubview(bottomFirst)

        bottomSecond = UILabel()
        view.addSubview(bottomSecond)

        bottomThird = UILabel()
        view.addSubview(bottomThird)

        
    }
    
    func styleViews() {
        if let details = MovieUseCase().getDetails(id: 111161) {
            let url = details.imageUrl
            movieCover.loadFrom(URLAddress: url)

            ratingLabel.text = String(details.rating)
            
            nameLabel.text = String(details.name)
            yearLabel.text = " (" + String(details.year) + ")"
            
            summary.text = String(details.summary)

            var string = ""
            let categories = details.categories
            
            for category in categories {
                if(string == "") {
                    string = String(describing: category).localizedCapitalized
                } else {
                    string = ", " + String(describing: category).localizedCapitalized
                }
            }
            genreLabel.text = string
            
            let minutes = details.duration
            let duration = String(format: "%2dh %2dm", minutes / 60, minutes % 60)
            string = string.trimmingCharacters(in: [" ", ","])
            string.append(" " + duration)
            durationLabel.text = duration;
            
            let stringDate = details.releaseDate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: stringDate) {
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let formattedDate = dateFormatter.string(from: date)
                dateLabel.text = formattedDate + " (US)"
            }
            
            let members : [MovieCrewMemberModel] = details.crewMembers
            let size = members.count

            var i = 0
            while i < size  {
                let bolded = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]
                let regular = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                NSAttributedString.Key.foregroundColor: UIColor.black]
                let someText = NSMutableAttributedString()
                let name = NSAttributedString(string: members[i].name + "\n", attributes: bolded)
                let role = NSAttributedString(string: members[i].role, attributes: regular)
                someText.append(name)
                someText.append(role)
             
                switch(i) {
                case 0: do {
                    upperFirst.attributedText = someText;
                    upperFirst.numberOfLines = 0
                    horizontalStackView1.addArrangedSubview(upperFirst)
                }
                case 1: do {
                    upperSecond.attributedText = someText;
                    upperSecond.numberOfLines = 0
                    horizontalStackView1.addArrangedSubview(upperSecond)
                }
                case 2: do {
                    upperThird.attributedText = someText;
                    upperThird.numberOfLines = 0
                    horizontalStackView1.addArrangedSubview(upperThird)
                }
                case 3: do {
                    bottomFirst.attributedText = someText;
                    bottomFirst.numberOfLines = 0
                    horizontalStackView2.addArrangedSubview(bottomFirst)
                }
                case 4: do {
                    bottomSecond.attributedText = someText;
                    bottomSecond.numberOfLines = 0
                    horizontalStackView2.addArrangedSubview(bottomSecond)
                }
                case 5: do {
                    bottomThird.attributedText = someText;
                    bottomThird.numberOfLines = 0
                    horizontalStackView2.addArrangedSubview(bottomThird)
                }
                default: break;
                }
                i += 1;
            }
            
            
            verticalStackView.addArrangedSubview(horizontalStackView1)
            verticalStackView.addArrangedSubview(horizontalStackView2)
        } else {
            print("Invalid details")
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
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 22
        
        horizontalStackView1.axis = .horizontal
        horizontalStackView1.alignment = .fill
        horizontalStackView1.distribution = .fillEqually
        horizontalStackView1.spacing = 16
        
        horizontalStackView2.axis = .horizontal
        horizontalStackView2.alignment = .fill
        horizontalStackView2.distribution = .fillEqually
        horizontalStackView2.spacing = 16
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
        
        verticalStackView.autoPinEdge(.top, to: .bottom, of: summary, withOffset: 20)
        verticalStackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 15)
        verticalStackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 15)
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

