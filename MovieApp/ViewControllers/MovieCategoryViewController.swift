import Foundation
import UIKit
import PureLayout
import MovieAppData

class MovieCategoryViewController : UIViewController {
    
    var scrollView : UIScrollView!
    var contentView : UIView!
    var stackView : UIStackView!
    
    var popularList = MovieUseCase().popularMovies
    var popularMovieCollectionView : MovieCategoryCell!
    var freeList = MovieUseCase().freeToWatchMovies
    var freeMovieCollectionView : MovieCategoryCell!
    var trendingMovieCollectionView : MovieCategoryCell!
    var trendingList = MovieUseCase().trendingMovies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        stackView = UIStackView()
        contentView.addSubview(stackView)
        
        popularMovieCollectionView = MovieCategoryCell(category: "What's popular", listOfMovies: popularList)
        stackView.addArrangedSubview(popularMovieCollectionView)
        
        freeMovieCollectionView = MovieCategoryCell(category: "Free to Watch", listOfMovies: freeList)
        stackView.addArrangedSubview(freeMovieCollectionView)
        
        trendingMovieCollectionView = MovieCategoryCell(category: "Trending", listOfMovies: trendingList)
        stackView.addArrangedSubview(trendingMovieCollectionView)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 40
    }
    
    private func defineLayout() {
        scrollView.autoPinEdgesToSuperviewEdges()
        scrollView.contentSize = contentView.frame.size
        
        contentView.autoPinEdgesToSuperviewEdges()
        contentView.autoMatch(.width, to: .width, of: view)
        
        stackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 25)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 15)
        stackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 15)
        stackView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
}
