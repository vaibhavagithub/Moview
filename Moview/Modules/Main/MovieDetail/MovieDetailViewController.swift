//
//  MovieDetailViewController.swift
//  Moview
//
//  Created by Empower on 12/08/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import UIKit
import CoreData


class MovieDetailViewController: UIViewController {
    
    var movieId : Int?

    var presenter : MovieDetailViewPresenter?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let networkLayer     = NetworkLayer()
        let dataLayer        = DataLayer()
        let translationLayer = TranslationLayer()
        let modelLayer       = ModelLayer(networkLayer: networkLayer, dataLayer: dataLayer, translationLayer: translationLayer)
        self.presenter       = MovieDetailViewPresenter(modelLayer: modelLayer)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        let networkLayer     = NetworkLayer()
        let dataLayer        = DataLayer()
        let translationLayer = TranslationLayer()
        let modelLayer       = ModelLayer(networkLayer: networkLayer, dataLayer: dataLayer, translationLayer: translationLayer)
        self.presenter       = MovieDetailViewPresenter(modelLayer: modelLayer)
        
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        print("MOVIE ID: \(movieId!)")
//        self.setupView()
//        self.fetchMovieDetails()
        self.loadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func loadData(){
        self.presenter?.loadMovieDetails(movieId: self.movieId!) { [unowned self] (movie) -> (Void) in
            print(movie)
            DispatchQueue.main.async {
                
            }
        }
        self.presenter?.loadMovieDetails(movieId: self.movieId!) { [unowned self] (movie) -> (Void) in
            print(movie)
            DispatchQueue.main.async {
                
            }
        }
    }
    
    private func fetchMovieDetails(){
        
        guard let movieId = self.movieId else { return }
        
        self.showProgress(status: "Please wait...")
        
        APIClient.shared.GET(entity: Movie.self, urlRequest: MovieEndpoint.movieDetails(movieId: String(movieId) ).urlRequest! , completionHandler: { (movieDetails) -> (Void) in
            
            DispatchQueue.main.async(execute: {
                self.hideProgress()
            })
            let fetchRequest = NSFetchRequest<Movie>.init(entityName: "Movie")
            fetchRequest.fetchLimit = 5
            fetchRequest.sortDescriptors?.append(NSSortDescriptor.init(key: "title", ascending: true))
            
            do {
                let fetchResults = try DataLayer.viewContext.fetch(fetchRequest)
//                self.nowPlayingMovies = fetchResults
                DispatchQueue.main.async(execute: {
//                    self.collection_recent.reloadData()
                })
            }catch {
                print(error)
            }
            
        }) { (error) -> (Void) in
            self.hideProgress()
            print("Error occured: \(error.localizedDescription)")
        }
    }

    
    

}
