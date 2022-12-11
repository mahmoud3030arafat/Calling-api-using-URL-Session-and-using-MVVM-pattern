

import UIKit
//protocol myProtocol {
//    func MyData(index:IndexPath,arr:Resultt)
//}

class MovieViewController: UIViewController {

    //MAHMOUD:- IBOutlet
    @IBOutlet weak var nameOfMovie: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var imageOfMovie: UIImageView!
    @IBOutlet weak var viewOfMovie: UIView!
    @IBOutlet weak var overviewMovie: UILabel!
    
    var name: String!
    var overview: String!
    var image : UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MAHMOUD:- calling viewChanges function
         viewChanges()
        nameOfMovie.text = name
        overviewMovie.text = overview

        
 
    }
   

    func viewChanges(){
        imageOfMovie.layer.cornerRadius = 24
        viewOfMovie.layer.cornerRadius = 16
        detailsButton.layer.cornerRadius = 12
    }
    

    
    @IBAction func detailsButtontapped(_ sender: Any) {

       
        
    }
    


    
   

}
