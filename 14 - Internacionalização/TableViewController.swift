import UIKit
import CoreData

class TableViewController: UITableViewController {
	var greenDays: [NSManagedObject] = []

	override func viewWillAppear(_ animated: Bool){
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
		let managedContext = appDelegate.persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GreenDay")
		fetchRequest.sortDescriptor = [NSSortDescriptor.init(key: "nomeDoProjeto", ascending: true)]

		do {
			pessoas = try managedContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("não foi possível buscar os dados \(error), \(error.userInfo)")
		}

		self.tableView.reloadData()
	}

	//populando a table view
	override func numberOfSections(in tableView: UITableView) -> Int{return 1}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{return greenDays.count}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: indexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIndetifier: "reuseIdentifier", for: indexPath)
		let greenDay = greenDays[indexPath.row]
		cell.textLabel?.text = greenDay.value(forKeyPath: "nomeDoProjeto") as? String
		cell.detailTextLabel?.text = greenDay.value(forKey: "tipoEnergia") as? String
		return cell
	}

	//deletando
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
	if editingStyle == .delete {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
		let managedContext = appDelegate.persistentContainer.viewContext
		managedContext.delete(greenDays[indexPath.row])
		do {
			try managedContext.save()
			greenDays.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		} catch let error as NSError{
			print("não foi possível excluir \(error), \(error.userInfo)")
		}
	} else if editingStyle == .insert  {

	}
}
}