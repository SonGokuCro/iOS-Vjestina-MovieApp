import Foundation
import PureLayout
import MovieAppData
import UIKit

class NavigationTabBar : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews () {
        let movieCategoryViewController = MovieCategoryViewController()
        
        let home = UIImage(systemName: "house")?.withTintColor(UIColor.systemGray)
        let homeSelected = UIImage(systemName: "house")?.withTintColor(UIColor.systemBlue)
        
        movieCategoryViewController.tabBarItem = UITabBarItem(title: "Movie List", image: .some(home!), selectedImage: .some(homeSelected!))
        
        let favoritesViewController = FavoritesViewController()
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [movieCategoryViewController, favoritesViewController]
    }
}
