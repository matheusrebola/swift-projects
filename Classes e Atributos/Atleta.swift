import Cocoa

class Atleta: NSObject {
	var nome:String
	var idade:Int

	override init(){
		self.idade=0 
		self.nome=''
	}

	init(nome:String, idade:Int){
		self.nome=nome
		self.idade=idade
	}

	deinit {
		print("\(nome) está sendo desinicializado")
	}
}