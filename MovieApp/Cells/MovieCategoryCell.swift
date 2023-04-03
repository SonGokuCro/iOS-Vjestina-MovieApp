import Foundation
import UIKit
import PureLayout

import MovieAppData

class MovieCategoryCell : UIView {
    
    var categoryCollectionView : UICollectionView!
    var categoryLabel : UILabel!
    var movieList : [MovieModel]!
    var categoryName = ""
    let cellId = "cell"
    
    init(category: String, listOfMovies: [MovieModel]) {
        super.init(frame: .zero)
        categoryName = category
        movieList = listOfMovies
        buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        categoryName = ""
        movieList = []
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews() {
        categoryLabel = UILabel()
        self.addSubview(categoryLabel)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.itemSize = CGSize(width: 120, height: 180)
        
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(MovieImageCell.self, forCellWithReuseIdentifier: cellId)
        self.addSubview(categoryCollectionView)
    }
    
    private func styleViews() {
        categoryLabel.text = categoryName
        categoryLabel.font = .systemFont(ofSize: 20, weight: .heavy)
    }
    
    private func defineLayout() {
        categoryLabel.autoPinEdge(toSuperviewEdge: .top)
        categoryLabel.autoPinEdge(toSuperviewEdge: .leading)
        categoryLabel.autoPinEdge(toSuperviewEdge: .trailing)
        
        categoryCollectionView.autoPinEdge(.top, to: .bottom, of: categoryLabel, withOffset: 16)
        categoryCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
        categoryCollectionView.autoPinEdge(toSuperviewEdge: .leading)
        categoryCollectionView.autoPinEdge(toSuperviewEdge: .trailing)
        categoryCollectionView.autoSetDimension(.height, toSize: 179)
    }
}

extension MovieCategoryCell : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieImageCell
        let movie = movieList[indexPath.item]
        cell.setData(imageURL: movie.imageUrl)
        
        return cell
    }
}
