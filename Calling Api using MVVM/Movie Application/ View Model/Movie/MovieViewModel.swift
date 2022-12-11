import Foundation
import UIKit

class MovieViewModel {
    //MAHMOUD:-variables

     var apiService = ApiService()
     var results = [Resultt]()
     var allData = [Resultt]()
    
    
    
    func fetchMovieData(completion:@escaping()->()){
        
        apiService.getDataFromServer {[weak self] (result) in
            switch result{
            case .success(let listOf):
                self?.results = listOf.results!
                self?.allData = listOf.results!
              completion()
                
            case .failure(let error ) :
                print(error.localizedDescription)
                
                
            }
            
        }
        
    }

    

    func numberOfRowsInSection (section : Int )->Int{
           if results.count != 0 {
               return results.count
           }
           return 0
       }
       func cellForRowAt (indexPath:IndexPath)->Resultt{
        print("\(results[indexPath.row])")
           return  results[indexPath.row]
       }
    

          //MAHMOUD:-calling images

                func getImageDataFrom(url: String,myImage:UIImageView) {
                  let  baseurl = URL(string:Constants.identifiers.baseUrl+url)
                    URLSession.shared.dataTask(with: baseurl!) { (data, response, error) in
                        // Handle Error
                        if let error = error {
                            print("DataTask error: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let data = data else {
                            // Handle Empty Data
                            print("Empty Data")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            if let image = UIImage(data: data) {
                                myImage.image = image
                              
                
                            }
                        }
                    }.resume()
                }
                
    
    
    //MAHMOUD:-filtering objects

    
    func filteringData(text:String?,completion:@escaping()->()){
        if text!=="" {
            self.results=allData
            completion()
        }else{
            self.results=results.filter{$0.title!.lowercased().contains(text!.lowercased())}
                   completion()
        }
        
        
        
    }
       
    
    

}
  
  
    
