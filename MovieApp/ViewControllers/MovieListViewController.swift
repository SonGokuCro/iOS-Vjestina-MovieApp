import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieListViewController : UIViewController {
    
    var movieCollectionView : UICollectionView!
    var movieList: [MovieModel]!
    let cellId = "cellId"
    
    private var router: RouterProtocol!
    convenience init(router: RouterProtocol) {
        self.init(router: RouterProtocol.self as! RouterProtocol)
        self.router = router
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    func createViews() {
        movieList = MovieUseCase().allMovies
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.itemSize = CGSize(width: view.bounds.width - 40, height: 140)
        
        movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.register(MovieListCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(movieCollectionView)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
    }
    
    private func defineLayout() {
        movieCollectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        movieCollectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        movieCollectionView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        movieCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieListCell
        let movie = movieList[indexPath.item]
        cell.setData(name: movie.name, summary: movie.summary, imageURL: movie.imageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieList[indexPath.row]
        router.showMovieDataViewController(movieId: movie.id)
    }
}
