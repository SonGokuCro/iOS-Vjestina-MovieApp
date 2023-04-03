import Foundation
import UIKit
import PureLayout

class MovieListCell : UICollectionViewCell {
    
    var nameLabel : UILabel!
    var summaryLabel : UILabel!
    var coverImage : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    public func setData(name: String, summary: String, imageURL: String) {
        nameLabel.text = name
        summaryLabel.text = summary
        Task {
            await loadImage(imageURL: imageURL, imageView: coverImage)
        }
    }
    
    func createViews() {
        nameLabel = UILabel()
        contentView.addSubview(nameLabel)
        
        summaryLabel = UILabel()
        contentView.addSubview(summaryLabel)
        
        coverImage = UIImageView()
        contentView.addSubview(coverImage)
    }
    
    func styleViews() {
        backgroundColor = .white
        
        contentView.layer.masksToBounds = false
        contentView.layer.cornerRadius = 20
        
        contentView.backgroundColor = .white
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowColor = UIColor.darkGray.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 4, height: 8)
        contentView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        
        coverImage.contentMode = .scaleAspectFit
        coverImage.layer.cornerRadius = 20
        coverImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        coverImage.clipsToBounds = true
        
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.numberOfLines = 0
        nameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        summaryLabel.textColor = UIColor.systemGray
        summaryLabel.font = .systemFont(ofSize: 14)
        summaryLabel.numberOfLines = 5
        summaryLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    func defineLayout() {
        coverImage.autoPinEdge(toSuperviewEdge: .top)
        coverImage.autoPinEdge(toSuperviewEdge: .bottom)
        coverImage.autoPinEdge(toSuperviewEdge: .leading)
        coverImage.autoSetDimension(.width, toSize: 90)
        
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        nameLabel.autoPinEdge(.leading, to: .trailing, of: coverImage, withOffset: 16)
        
        summaryLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 8)
        summaryLabel.autoPinEdge(.leading, to: .trailing, of: coverImage, withOffset: 16)
        summaryLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
        
    }
    
    func loadImage(imageURL: String, imageView: UIImageView) async {
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

