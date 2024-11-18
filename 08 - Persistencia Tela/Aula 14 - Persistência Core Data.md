Core Data
Core Data é um framework de persistência fornecido pela Apple nos sistemas operacionais macOS e iOS. Ele permite que os dados organizados pelo modelo relacional de entidade-atributo sejam serializados em armazenamentos XML, binários ou SQLite. Existem diversas formas de persistir dados em uma aplicação, mas a mais robusta é usando banco de dados. Core Data é utilizado para trabalhar a camada Model da sua aplicação ele nos permite persistir dados em nosso aplicativo, utilizando banco de dados, de uma forma orientada a objetos.
Core Data não é um banco de dados, mas sim um gerenciador de grafoS que também inclui persistência. Trabalha (agrupa, ltra e organiza) os dados em memória. Nesta aula você irá persistir os dados e ver como é fácil navegar entre telas utilizando o storyboard com Navigation Controller e TableView.

Criando o Projeto
Nomeie o projeto como “Core Data Exemplo” (1), de na uma URL invertida em Organization Identi er (2), selecione Storyboard em User Interface (3), language: Swift (4), marque o checkbox: Use Core Data(5). IMPORTANTE: Para projetos Core Data não use “-” no nome do arquivo.

Navigation Controller
No seu Main.storyboard (1) inclua um Navigation Controller (2,3,4,5), este objeto acompanha um TableViewController.

Initial View Controller
Após incluir o Navigation Controller sua tela cará parecida com o exemplo abaixo, arraste o “Initial View Controller” (1) para antes do “Navigation Controller” (2)
Note que a seta “Initial View Controller” (1) mudou de local

Bar Button
Inclua na barra de navegação da TableView um objeto Bar Button Item (1,2,3), altere o atributo System Item para Add (4,5,6).

Add Bar Button
Ligue o item Add(1) a ViewController(2) e escolha Show(3).

Save Bar Button
Altere os títulos da barra de navegação da ViewController (1,2,3) e o título da barra de navegação da TableViewController (4,3).
Adicione um Bar Button Item (5, 6, 7) na ViewController e altere o atributo System Item para Save.

ViewController
Insira na ViewController três campos do tipo Text Field (1,2,3) e altere a propriedade Placeholder (4) de cada um.

Classe TableViewController
A d i c i o n e u m a n o va C la s s e (C o m m a n d + N ) , e s co l h a s u b c la s s e d e UITableViewController e nomeie como ContatoTableViewController.

Classe ViewController
Adicione o utra Classe, subclasse de UIViewController e nomeie como ContatoViewController.

Apagando ViewController.swift
Selecione a ViewController(1) que foi criada junto com o projeto, com o botão direito escolha delete e clique em Move To Trash (2).

Identity Inspector
Vamos ligar as Views aos seus respectivos controllers.

ReuseIdentifier
Clica na Table View Cell (1), entre em Attributes Inspector (2) e altere o atributo Identi er para “reuseIdentifier” (3).
Altere o atributo Style para Subtitle (4).

Text Field
Vamos deixar abertos simultaneamente o Storyboard e o ContatoViewController, crie os três Outlet’s das respectivas caixas.

Action Salvar
Ainda no ContatoViewController crie o IBAction para o botão Save.

Action e Outlet
Veja seus Outlet’s e o Action como no exemplo abaixo(1).

Core Data
A partir desse ponto você irá criar a entidade Pessoa. (Esta entidade irá aparecer no código como um NSManageObject)
Irá criar os atributos: Nome, Telefone e E-mail todos como String (Atributos são acessados no NSManagedObject via métodos valueForKey: e setValueForkey:.
O editor de modelo de dados tem muitos recursos que você pode explorar mais tarde. Por enquanto, vamos nos concentrar na criação de uma única entidade de dados centrais