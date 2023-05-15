import Foundation
import PureLayout
import MovieAppData
import UIKit

class NavigationTabBar : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.setViewControllers([
            createTabBarItem(tabBarTitle: "Movie List", tabBarImage: UIImage(systemName: "house")!, viewController: MovieCategoryViewController()),
            createTabBarItem(tabBarTitle: "Favorites", tabBarImage: UIImage(systemName: "star")!, viewController: FavoritesViewController())
        ], animated: false)}
        
        fileprivate func createTabBarItem(tabBarTitle: String, tabBarImage: UIImage, viewController: UIViewController) -> UINavigationController {
              let navigationController = UINavigationController(rootViewController: viewController)

              navigationController.navigationBar.tintColor = .black
              navigationController.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
              
              let appearance = UINavigationBarAppearance()
              appearance.configureWithOpaqueBackground()
              navigationController.navigationBar.standardAppearance = appearance
              navigationController.navigationBar.scrollEdgeAppearance = appearance

              navigationController.tabBarItem = UITabBarItem(title: tabBarTitle, image: tabBarImage, selectedImage: tabBarImage)
              
              return navigationController
          }
}
