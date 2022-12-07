    //
    //  MovieListViewController.swift
    //  Complex UI Application
    //
    //  Created by mohit.dubey on 05/08/22.
    //

import UIKit

struct NoFileError: LocalizedError {
    var errorDescription: String?
    var failureReason: String?
}

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var movieListTableController: UITableView!
    var movieList: MoviesListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movieListTableController.dataSource = self
        movieListTableController.delegate = self
        
            // Do any additional setup after loading the view.
        Task {
            do {
                try await fetchMoviesListCreateTask()
            } catch {
                Swift.print("Mohit: Error occured viewDidLoad \(error.localizedDescription)")
            }
        }
    }
    
    
    private func fetchMovieList(_ listTask: Task<MoviesListModel?, Error>) async throws {
        do {
            let movieList = try await listTask.value
            self.movieList = movieList
            DispatchQueue.main.async {
                self.movieListTableController.reloadData()
            }
        } catch {
            Swift.print("Mohit: Error occured fetchMoviesList \(error.localizedDescription)")
            throw error
        }
    }
    
    private func fetchMoviesListCreateTask() async throws {
        let listTask = Task { () throws -> MoviesListModel? in
            do {
                if let data = try FileOperations.readContentOfFile(name: "MostPopular") {
                    let responseObject: MoviesListModel = try JsonParser.parseJsonToObject(data: data)
                    return responseObject
                } else {
                    throw NoFileError(errorDescription: "Failed to either read file or parse json",
                                      failureReason: "Failed to either read file or parse json")
                }
            } catch {
                throw error
            }
        }
        
        try await fetchMovieList(listTask)
    }
}

extension MovieListViewController: UITableViewDelegate {
    
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let movieListItem = movieList?.items {
            cell.textLabel?.text = movieListItem[indexPath.row].title
        }
        
        return cell
    }
}
