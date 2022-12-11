

import UIKit
import MBCircularProgressBar

class MovieListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var mylabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var movieListTableView: UITableView!
    
    
     var viewModel =  MovieViewModel()
     private var dataTask:URLSessionDataTask?

  
    override func viewDidLoad() {
        super.viewDidLoad()
        //MAHMOUD:- registering MovieTabelViewCell
        movieListTableView.register(UINib(nibName: Constants.identifiers.MovieTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.identifiers.MovieTableViewCell)
           setUp()
        //MAHMOUD:-calling function
         loadPopularMoviesData()

        }
     
    private func loadPopularMoviesData() {
          viewModel.fetchMovieData { [weak self] in
            self?.movieListTableView.dataSource = self
            self!.movieListTableView.reloadData()
            }
        }

    //MAHMOUD:-set up function
        func setUp(){
        movieListTableView.delegate=self
        movieListTableView.dataSource=self
       
    }
    
    
    //MAHMOUD:-segmented control


    @IBAction func segmented(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0 :
            mylabel.text = segmentedControl.titleForSegment(at: 0)
            case 1 :
            mylabel.text = segmentedControl.titleForSegment(at: 1)
            
    
        default:
             mylabel.text = segmentedControl.titleForSegment(at: 2)
            
        }
        
    }
    
    //MAHMOUD:-filtering data
    
    @IBAction func search(_ sender: UITextField) {
        
        viewModel.filteringData(text: sender.text!) {
            self.movieListTableView.reloadData()
        }
        

        
    }
    

    
}

extension MovieListViewController{
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  viewModel.numberOfRowsInSection(section: section)
       
        
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = movieListTableView.dequeueReusableCell(withIdentifier: Constants.identifiers.MovieTableViewCell, for: indexPath) as! MovieTableViewCell
        
      viewModel.getImageDataFrom(url: viewModel.cellForRowAt(indexPath: indexPath).posterPath!, myImage:cell.movieImage!)
        cell.movieName.text = viewModel.cellForRowAt(indexPath: indexPath).title
        cell.movieDescription.text = viewModel.cellForRowAt(indexPath: indexPath).overview!
        cell.date.text = viewModel.cellForRowAt(indexPath: indexPath).releaseDate!
        let newValue  =  viewModel.cellForRowAt(indexPath: indexPath).voteAverage! * 10
        cell.progressView.value = CGFloat(newValue)
            return cell
            
        }
      
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 304
      }
      
      
      
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MovieListViewController", sender: self)
      }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let detailsVC = segue.destination as! MovieViewController
    let selectedRow = movieListTableView.indexPathForSelectedRow!
        print(selectedRow)
        detailsVC.name = viewModel.cellForRowAt(indexPath: selectedRow).title
        detailsVC.overview = viewModel.cellForRowAt(indexPath: selectedRow).overview


    }
    
}




    
        



