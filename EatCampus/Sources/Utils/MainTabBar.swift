//
//  MainTabBar.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import UIKit

enum Tab {
    static func home(_ tabBarController: UITabBarController) -> UINavigationController {
        return Create.navigationController(
            tabBarController: tabBarController,
            title: "홈",
            selectedImageName: "house.fill",
            unselectedImageName: "house",
            rootViewController: HomeController()
        )
    }
    
    static func now(_ tabBarController: UITabBarController) -> UINavigationController {
        return Create.navigationController(
            tabBarController: tabBarController,
            title: "지금",
            selectedImageName: "clock.fill",
            unselectedImageName: "clock",
            rootViewController: NowController()
        )
    }
    
    static func vote(_ tabBarController: UITabBarController) -> UINavigationController {
        return Create.navigationController(
            tabBarController: tabBarController,
            title: "투표",
            selectedImageName: "checkmark.square.fill",
            unselectedImageName: "square",
            rootViewController: VoteController()
        )
    }
    
    static func profile(
        _ tabBarController: UITabBarController,
        withUser user: User
    ) -> UINavigationController {
        return Create.navigationController(
            tabBarController: tabBarController,
            title: "프로필",
            selectedImageName: "person.fill",
            unselectedImageName: "person",
            rootViewController: ProfileController(user: user)
        )
    }
    
    static func setting(_ tabBarController: UITabBarController) -> UINavigationController {
        return Create.navigationController(
            tabBarController: tabBarController,
            title: "설정",
            selectedImageName: "gearshape.fill",
            unselectedImageName: "gearshape",
            rootViewController: SettingController()
        )
    }
}

struct Create {
    static func navigationController(
        tabBarController: UITabBarController,
        title: String,
        selectedImageName: String,
        unselectedImageName: String,
        rootViewController: UIViewController
    ) -> UINavigationController {
        tabBarController.tabBar.tintColor = .tabBarItemTint
        
        let tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: unselectedImageName),
            selectedImage: UIImage(systemName: selectedImageName)
        )
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = tabBarItem
        navigationController.navigationBar.tintColor = .black
        
        return navigationController
    }
}


//enum Tab {
//    static func home(_ tabBarController: UITabBarController) -> UINavigationController {
//        return Create.navigationController(
//            tabBarController: tabBarController,
//            title: "홈",
//            selectedImageName: "house.fill",
//            unselectedImageName: "house",
//            rootViewController: HomeController()
//        )
//    }
//    
//    static func now(_ tabBarController: UITabBarController) -> UINavigationController {
//        return Create.navigationController(
//            tabBarController: tabBarController,
//            title: "지금",
//            selectedImageName: "clock.fill",
//            unselectedImageName: "clock",
//            rootViewController: NowController()
//        )
//    }
//    
//    static func vote(_ tabBarController: UITabBarController) -> UINavigationController {
//        return Create.navigationController(
//            tabBarController: tabBarController,
//            title: "투표",
//            selectedImageName: "checkmark.square.fill",
//            unselectedImageName: "square",
//            rootViewController: VoteController()
//        )
//    }
//    
//    static func profile(
//        _ tabBarController: UITabBarController,
//        withUser user: User
//    ) -> UINavigationController {
//        return Create.navigationController(
//            tabBarController: tabBarController,
//            title: "프로필",
//            selectedImageName: "person.fill",
//            unselectedImageName: "person",
//            rootViewController: ProfileController(user: user)
//        )
//    }
//    
//    static func setting(_ tabBarController: UITabBarController) -> UINavigationController {
//        return Create.navigationController(
//            tabBarController: tabBarController,
//            title: "설정",
//            selectedImageName: "gearshape.fill",
//            unselectedImageName: "gearshape",
//            rootViewController: SettingController()
//        )
//    }
//}
//
//struct Create {
//    static func navigationController(
//        tabBarController: UITabBarController,
//        title: String,
//        selectedImageName: String,
//        unselectedImageName: String,
//        rootViewController: UIViewController
//    ) -> UINavigationController {
//        tabBarController.tabBar.tintColor = .tabBarItemTint
//        
//        let tabBarItem = UITabBarItem(
//            title: title,
//            image: UIImage(systemName: unselectedImageName),
//            selectedImage: UIImage(systemName: selectedImageName)
//        )
//        
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        navigationController.tabBarItem = tabBarItem
//        navigationController.navigationBar.tintColor = .black
//        
//        return navigationController
//    }
//}
