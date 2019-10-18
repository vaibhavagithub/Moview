//
//  OtherMoviesCollectionPresenter.swift
//  Moview
//
//  Created by Shubham Ojha on 15/10/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

class OtherMoviesCollectionPresenter {
    var otherMoviesCollections : [[Movie]] = [[], []]
    let sections        : [String] = ["Upcoming Movies", "Latest"]
    
    fileprivate var modelLayer : ModelLayer
    
    init(modelLayer: ModelLayer) {
        self.modelLayer = modelLayer
    }
    
    func loadUpcomingMovies(page: Int, handler: @escaping FetchMoviesFromSourceCompletionHandler) {
        modelLayer.loadUpcomingMovies(from: .local, page: page) { (movies, source, error) -> (Void) in
            if (error == nil) {
                if movies.count != 0 {
                    self.otherMoviesCollections[0] = movies
                }
                handler(.local)
            }
        }
        
        modelLayer.loadUpcomingMovies(from: .network, page: 1) { (movies, source, error) -> (Void) in
            if (error == nil) {
                if movies.count != 0 {
                    self.otherMoviesCollections[0] = movies
                }
                handler(.network)
            }
        }
        
    }
    
    
    func loadLatestMovies(page: Int, handler: @escaping FetchMoviesFromSourceCompletionHandler) {
        modelLayer.loadLatestMovies(from: .local, page: page) { (movies, source, error) -> (Void) in
            if (error == nil) {
                if movies.count != 0 {
                    self.otherMoviesCollections[1] = movies
                }
                handler(.local)
            }
        }
        
        modelLayer.loadLatestMovies(from: .network, page: 1) { (movies, source, error) -> (Void) in
            if (error == nil) {
                if movies.count != 0 {
                    self.otherMoviesCollections[1] = movies
                }
                handler(.network)
            }
        }
        
    }
}

