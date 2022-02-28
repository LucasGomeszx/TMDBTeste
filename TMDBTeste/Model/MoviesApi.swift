//
//  MoviesApi.swift
//  TMDBTeste
//
//  Created by Lucas Gomesx on 23/02/22.
//

import Foundation

class MoviesApi {
    
    let constURL = K.urlFilmesPopulares
    var tmdbUrl = K.urlFilmesPopulares
    var page = 0
    var totalPage = 0
    var movieList = [Result]()
    
    func getData(completed: @escaping ()->()) {
        
        guard let url = URL(string: tmdbUrl) else {
            print("Erro ao acessar url")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("ERROR a: \(error.localizedDescription)")
            }
            do {
                let returned = try JSONDecoder().decode(MoviesModel.self, from: data!)
                self.page = returned.page + 1
                self.totalPage = returned.total_pages
                self.tmdbUrl = self.constURL + "\(K.page)\(self.page)"
                self.movieList = self.movieList + returned.results
            } catch {
                print("Error : " + error.localizedDescription)
            }
            completed()
        }
        task.resume()
    }
}
