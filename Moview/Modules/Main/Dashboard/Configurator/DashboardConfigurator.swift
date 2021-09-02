//
//  DashboardConfigurator.swift
//  Moview
//
//  Created by Shubham Ojha on 02/09/21.
//  Copyright © 2021 Shubham. All rights reserved.
//

import Foundation
import UIKit


protocol ICleanConfigurator {
    associatedtype ViewController
    
    func configure(viewController: ViewController)
}



struct DashboardConfigurator: ICleanConfigurator {
    
    static let shared : DashboardConfigurator = DashboardConfigurator()
    
    func configure(viewController: DashboardViewController){
        let vc = viewController
        let nowPlayingService = NowPlayingDataService.init(apiClient: APIClient.shared)
        
        let topRatedService = TopRatedMoviesService.init(apiClient: APIClient.shared)
        
        let latestMovieService = LatestMoviesService.init(apiClient: APIClient.shared)
        
        
        vc.recentMoviesPresenter = RecentMoviesPresenter(service: nowPlayingService, repository: MovieRepository.shared, translator: TranslationLayer.shared)
        vc.otherMoviesPresenter = OtherMoviesPresenter.init(topRatedMoviesService: topRatedService, latestMoviesService: latestMovieService, repository: MovieRepository.shared, translator: TranslationLayer.shared)
        
//        let networkLayer     = NetworkLayer()
//        let dataLayer        = DataLayer()
//        let _  = ModelLayer(networkLayer: networkLayer, dataLayer: dataLayer, translationLayer: TranslationLayer.shared)
//        self.otherMoviesPresenter = OtherMoviesCollectionPresenter(modelLayer: modelLayer)
    }
}
