import UIKit

class ViewController: UIViewController {
	var movies: Movie?

	@IBOutlet weak var ivMovie: UIImageView!
	@IBOutlet weak var lbTitle: UILabel!
	@IBOutlet weak var lbCategories: UILabel!
	@IBOutlet weak var lbDuration: UILabel!
	@IBOutlet weak var lbRating: UILabel!
	@IBOutlet weak var tvSummary: UITextView!

	override func viewDidLoad() {
		super.viewDidLoad()
		//Chamamos o método loadMovies()
		loadMovies()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let movie = movie {
			ivMovie.image = movie.image as? UIImage
			lbTitle.text = movie.title
			lbCategories.text = movie.categories
			lbDuration.text = movie.duration
			lbRating.text = "⭐ \(movie.rating)/10"
			tvSummary.text = movie.summary
		}
	}

	//Este método abrirá o arquivo movies.json e converterá em um array de Movie
	func loadMovies() {
		//Recuperando a URL do arquivo
		guard let fileURL = Bundle.main.url(forResource:
		"movies", withExtension: "json") else {return}
		do {
			//Criando o dara, a representação binária de nosso arquivo
			let data = try Data(contentsOf: fileURL)
	
			//Decodificando o JSON em um Array de Movie
			movies = try JSONDecoder().decode([Movie].self,
				from: data)
	
			//Varremos o array para imprimir na Debug Area o nome e duração de cada filme
			for movie in movies {
				print(movie.title, "-", movie.duration)
			}
		} catch {
			//Caso aconteça algum erro na interpretação do JSON, o sistema de tratamento exibirá a causa
			print(error.localizedDescription)
		}
	}

	if let movie = movie {
		ivMovie.image = UIImage(named: movie.image)
		lbTitle.text = movie.title
		lbCategories.text = movie.categories
		lbDuration.text = movie.duration
		lbRating.text = "⭐ \(movie.rating)/10"
		tvSummary.text = movie.summary
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? AddEditViewController {vc.movie = movie}
	}
}