import Foundation
import UIKit
import PureLayout

class MovieImageCell : UICollectionViewCell {
    let favouriteBgColor = UIColor(red: 120, green: 140, blue: 120, alpha: 1)
    let favourited = UIColor(red: 103/255, green: 177/255, blue: 219/255, alpha: 1)
    
    var coverImage : UIImageView!
    var favouriteButton : UIButton!
    var favouriteImageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    func setData(imageURL: String) {
        Task {
            await loadImage(imageURL: imageURL, imageView: coverImage)
        }
    }
    
    func createViews() {
        coverImage = UIImageView()
        contentView.addSubview(coverImage)
        
        favouriteButton = UIButton()
        contentView.addSubview(favouriteButton)
        
        favouriteImageView = UIImageView()
        favouriteButton.addSubview(favouriteImageView)
    }
    
    func styleViews() {
        favouriteImageView.image = UIImage(systemName: "heart")
        favouriteButton.backgroundColor = favouriteBgColor
        favouriteButton.frame.size = CGSize(width: 34, height: 34)
        favouriteButton.layer.cornerRadius = favouriteButton.bounds.width / 2
        favouriteButton.clipsToBounds = true
        favouriteButton.alpha = 0.6
        favouriteButton.addTarget(self, action: #selector(self.favouriteButtonTapped), for: .touchUpInside)

        coverImage.contentMode = .scaleAspectFill
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    @objc
        private func favouriteButtonTapped(){
            if(favouriteButton.backgroundColor == favourited) {
                favouriteButton.backgroundColor = favouriteBgColor
            }
            favouriteButton.backgroundColor = favourited
        }
    
    
    func defineLayout() {
        coverImage.autoPinEdgesToSuperviewEdges()
        favouriteImageView.autoCenterInSuperview()
        
        favouriteButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        favouriteButton.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        
        favouriteButton.autoSetDimension(.height, toSize: 32)
        favouriteButton.autoSetDimension(.width, toSize: 32)
    }
    
    private func loadImage(imageURL: String, imageView: UIImageView) async {
        guard let url = URL(string: imageURL) else {
            return
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.coverImage.image = loadedImage
                    }
                }
            }
        }
    }
}
