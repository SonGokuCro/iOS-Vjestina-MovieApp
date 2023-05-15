import Foundation
import UIKit

protocol RouterProtocol {
    func setStartScreen(in window: UIWindow?)
    func showMovieDataViewController(movieId: Int)
}

class Router: RouterProtocol {
    private let navigationController: UINavigationController!
    private var tabBarController: UITabBarController!
    private var movieListViewController: MovieCategoryViewController!
    private var favoritesViewController: FavoritesViewController!
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setStartScreen(in window: UIWindow?) {
        movieListViewController = MovieCategoryViewController(router: self)
        favoritesViewController = FavoritesViewController()
        tabBarController = UITabBarController()
        
        styleControllers()
        
        tabBarController.viewControllers = [navigationController, favoritesViewController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func styleControllers() {
        movieListViewController.navigationItem.title = "Movie list"
        navigationController.pushViewController(movieListViewController, animated: false)
        
        let home = UIImage(systemName: "house")
        movieListViewController.tabBarItem = UITabBarItem(title: "Movie List", image: .some(home!), selectedImage: .some(home!))
        
        let favourite = UIImage(systemName: "heart")
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: .some(favourite!), selectedImage: .some(favourite!))
        
        tabBarController.tabBar.tintColor = UIColor.systemBlue
        
    }
    func showMovieDataViewController(movieId: Int) {
        let viewController = MovieDataViewController(router: self, movieId: movieId)
        viewController.navigationItem.title = "Movie details"
        navigationController.pushViewController(viewController, animated: true)
    }
}
