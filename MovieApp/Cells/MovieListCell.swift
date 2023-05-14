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
        backgroundColor = .systemBackground
        layer.masksToBounds = false
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 4, height: 8)
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
                
        coverImage.contentMode = .scaleAspectFit
        coverImage.layer.cornerRadius = 20
        coverImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        coverImage.clipsToBounds = true
            
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.numberOfLines = 0
        nameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            
        summaryLabel.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        summaryLabel.font = .systemFont(ofSize: 12)
        summaryLabel.numberOfLines = 0
        summaryLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    func defineLayout() {
        coverImage.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .trailing)
        coverImage.autoSetDimensions(to: CGSize(width: 97, height: 142))
        coverImage.autoPinEdge(toSuperviewEdge: .leading)
        coverImage.autoPinEdge(toSuperviewEdge: .top)
        
        
        nameLabel.autoSetDimension(.width, toSize: 250)
        nameLabel.autoSetDimension(.height, toSize: 40)
        nameLabel.autoPinEdge(.leading, to: .trailing, of: coverImage, withOffset: 16)
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4)
        nameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12, relation: .greaterThanOrEqual)
        
          summaryLabel.autoSetDimension(.width, toSize: 233)
          summaryLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 8)
          summaryLabel.autoPinEdge(.leading, to: .trailing, of: coverImage, withOffset: 16)
          summaryLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
          summaryLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12, relation: .greaterThanOrEqual)
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

