import UIKit

class MoviesTableViewController: UITableViewController {
	
	//Criamos o objeto fetchedResultsController definindo que será um controller da entidade Movie
		var fetchedResultsController: NSFetchedResultsController<Movie>!

	override func viewDidLoad() {
		super.viewDidLoad()
		loadMovies()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? ViewController {
			let movie = fetchedResultsController.object(at: tableView.indexPathForSelectedRow!)
			vc.movie = movie
		}
}

	func loadMovies() {
		guard let fileURL = Bundle.main.url(forResource:
			"movies", withExtension: "json") else {return}
		do {
			let data = try Data(contentsOf: fileURL)
			movies = try JSONDecoder().decode([Movie].self,
				from: data)
		} catch {
			print(error.localizedDescription)
		}
	}

	func loadMovies() {
		//O objeto fetchRequest é responsável por fazer uma leitura dos itens do Core Data. Criamos um fetchRequest de Movie pois queremos buscar todos os filmes da base. A classe Movie (gerada pelo Core Data) já possui um método que nos retorna seu fetchRequest 
		let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
		//Abaixo, definimos que os filmes serão ordenados em ordem alfabética pelo título
		let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		//Instanciando objeto fetchedResultsController. Aqui precisamos passar o fetchRequest e o contexto do Core Data.
		fetchedResultsController = 
			NSFetchedResultsController(fetchRequest: fetchRequest,
				managedObjectContext: context,
				sectionNameKeyPath: nil,
				cacheName: nil)

		//Definimos que esta classe será delegate do fetchedResultsController. Ela que será chamada quando algo acontecer no contexto dos filmes
		fetchedResultsController.delegate = self
			do {
				//Executando a requisição de movies
				try fetchedResultsController.performFetch()
				} catch {
					print(error.localizedDescription)
					}
	}
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {return 1}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//Os filmes estarão presentes no objeto fetchedObjects. Verificamos se tem filmes e caso não tenha retornamos 0
		return fetchedResultsController.fetchedObjects?.count ?? 0
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		//Se o usuário apertou no botão delete
		if editingStyle == .delete {
			//Recuperamos o filme daquela célula
			let movie = fetchedResultsController.object(at: indexPath)
			//O context possui um método para exclusão de um elemento
			context.delete(movie)
			do {
				try context.save()
			} catch {print(error.localizedDescription)}
		}
	}

	//Este método prepara cada uma das células para apresentar o filme correspondente 
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//Vamos tratar a célula como sendo uma MovieTableViewCell
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
		//Para recuperarmos o filme, usamos o método object(at: ) do fetchedResultsController
	
		//Com ele, passamos o indexPath da célula e obtemos o filme vinculado a ela 
		let movie = fetchedResultsController.object(at: indexPath)
		//Para preencher a imagem, basta tratarmos o atributo image como sendo uma Imagem, pois nele nós salvaremos a imagem do filme
		cell.ivMovie.image = movie.image as? UIImage
		cell.lbTitle.text = movie.title
		cell.lbSummary.text = movie.summary
		return cell
	}
	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit
		editingStyle: UITableViewCell.EditingStyle, forRowAt
			indexPath: IndexPath) {
		if editingStyle == .delete {
			// Delete the row from the data source
			tableView.deleteRows(at: [indexPath], with:.fade)
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate
				class, insert it into the array, and add a new row to the table view
		}
	}
	*/
}
	//Através de extensions, vamos implementar o protocolo NSFetchedResultsControllerDelegate para que esta classe possa ser delegate do objeto:fetchedResultsControllerDelegate

extension MoviesTableViewController: NSFetchedResultsControllerDelegate {
	//O método abaixo é chamado sempre que alguma alteração é feita em algum filme. Quando isto ocorrer, iremos fazer o reload da tabela, assim ela recarrega todos os
	//filmes e atualiza seu conteúdo.
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {tableView.reloadData()}
}