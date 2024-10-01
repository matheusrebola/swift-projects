import Cocoa

class Enfermeira: NSObject {
	var nome:String
	var salario:Float
	var plantao:Bool
	var periodo:Int

	override init(){
		self.nome=""
		self.salario=0.0
		self.plantao=false
		self.periodo=-1
	}

	init (nome:String, salario:Float, plantao:Bool, periodo:Int){
		self.nome=nome
		self.salario=salario
		self.plantao=plantao
		self.periodo=periodo
	}

	func mostrarPlantao() -> String {
        if self.plantao {
            return "PLANTÃO"
        } else {
            return "FOLGA"
        }
    }

    func mostrarPeriodo() -> String {
        if self.periodo == -1 {
            return "INDEFINIDO"
        } else if self.periodo == 0 {
            return "NOTURNO"
        } else {
            return "DIURNO"
        }
    }

    func mostrarDetalhes() {
        print("A enfermeira \(self.nome) está de \(self.mostrarPlantao()) no período \(self.mostrarPeriodo())")
    }

    func analisarBonus()->Bool{
    	if(self.periodo == 0) {
    		return true
    	}
    	else {
    		return false
    	}
    }

    class func definirValorBonus()->Int{
    	if(self.analisarBonus() == true) {
    		return 20
    	}
    	else {
    		return 10
    	}
    }



}
