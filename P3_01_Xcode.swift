//create a Game
class Game{
    // 2 array where teams will be stocked
    private var player1Team :[Character] = [Character(),Character(),Character()]
    private var player2Team :[Character] = [Character(),Character(),Character()]
    
    // count the number of rounds
    private var roundsGame = 1
    
    //create an array with all characters
    private var allCharacters : [Character] = [Legionnary(),Barbaric(),Assassin(),Magician(),Monk()]
    
    // ask the number of character in list
    // if the number is not correct, ask again the question
    // j is the current player
    // i is the current character
    private func selectYourCharacter(j : Int , i : Int){
        var playerChosen: Character?
        
        while playerChosen == nil {

           guard let number = readLine(),
                 let choiceNumber = Int(number),
                 choiceNumber > 0 && choiceNumber <= allCharacters.count else {
            playerChosen = nil
            print ("Veuillez entrer un nombre entre 1 et \(allCharacters.count)")
                continue
               }
            
            if j == 1 {
                player1Team[i] = allCharacters[choiceNumber-1].copyCharacter()
            } else {
                player2Team[i] = allCharacters[choiceNumber-1].copyCharacter()
            }
            
        playerChosen = allCharacters[choiceNumber-1]
           
        }
}
    
    // return true if the name already attributed else return false
    private func existName(name : String) -> Bool {
        for i in 0..<player1Team.count{
            if name == player1Team[i].name {
                return true
            }
            for i in 0..<player2Team.count{
                if name == player2Team[i].name {
                    return true
                }
            }
        }
        return false
    }
    
    // ask the name of the current character
    // if the name already exist, ask again a name
    // j is the current player
    // i is the current character
    private func characterName(j : Int, i : Int){
        // var bool = false
        // if a character name already exist bool = True
        var bool = false
        
        while bool == false {

            guard let nameChoice = readLine(),
            !existName(name: nameChoice)
                  
           else {
            print ("Veuillez entrer un nom différent de ceux déjà existants")
                continue
               }
            
            if j == 1 {
                player1Team[i].name = nameChoice
                 print(player1Team[i].createDescription())
            } else {
                player2Team[i].name = nameChoice
                print(player2Team[i].createDescription())
            }
            bool = true
    }
 
}
    
    // print a summary of the 2 teams
    // use the 2 array for print statistics team 1 and 2
    // this function will be used when 2 teams are created and when the game is finished
    private func resumeTeams(){
        print("Pour résumer les deux équipes :")

                print("")
                print("joueur 1 :")
        
        for i in 0..<player1Team.count{
                print(player1Team[i].shortDescription())
                }
        
                print("")
                print("joueur 2 :")
        
                for i in 0..<player2Team.count{
                print(player2Team[i].shortDescription())
                }
    }
    
    // ask to 2 players to make their team
    private func teamConstructor(){
        print("")
        print("*******************************************************************")
        print("Bienvenue dans ce mini jeu composé de 2 joueurs!")
        print("Vous allez chacun votre tour créer votre équipe de 3 personnages")
        print("******************************************************************")
        print("")
        
        // j is the current Player
        for j in 1...2{
            // characters presentation
            print("")
            print("Salut Joueur\(j) à toi de créer tes 3 personnages ! !")
            print("Vous pouvez choisir l'un de ces personnages, tapez le numéro correspondant")
            for x in 0..<allCharacters.count{
                print("\(x+1) : \(allCharacters[x].name) possède \(allCharacters[x].hp) hp et un(e) \(allCharacters[x].weapon.name) qui tape \(allCharacters[x].weapon.hpAttack)")
            }
            
            // 3 turns for create 3 characters
            // i is the currently character that is being created
            for i in 0...2 {
                
                print("Création du personnage n°\(i+1) : ")
                selectYourCharacter(j : j , i: i)
                
                print("Veuillez donner un nom à votre personnage n°\(i+1), attention il doit etre différent des noms déjà créés dans cette partie ! : ")
                characterName( j : j , i : i)
                
            }
        }
        
        // we use this function for show the 2 teams
        resumeTeams()
    }
  
 
    
    //function for know if all character in a team are dead
    //if one of the 2 teams are dead return false, else return True
    private func testOneTeamIsDeath(array1 : [Character], array2 : [Character]) -> Bool{
        return ((((array1[0].hp + array1[1].hp + array1[2].hp) != 0)) && (((array2[0].hp + array2[1].hp + array2[2].hp) != 0)) )
    }
    
    
    // function for show one team (the current player)
    // j is the current player
    private func showTeam(j : Int){
        print("")
        if j == 1 {
            for i in 0..<player1Team.count {
                print("\(i+1) : \(player1Team[i].shortDescription())")
            }
        } else {
            for i in 0..<player2Team.count {
                print("\(i+1) : \(player2Team[i].shortDescription())")
            }
        }
    }
    
    
    // ask the player, the character who equipe the new weapon
    // the player can choice "none" if the weapon is weak
    // j is the current player
    // weapon is the new weapon in the treasure
    private func changeWeapon(weapon : Weapon ,j: Int){
        var playerChosen: Int?
        
        while playerChosen == nil {
            showTeam(j: j)
            print("\(player1Team.count+1) : Aucun, cette arme est nulle !")
            
           guard let number = readLine(),
                 let choiceNumber = Int(number),
                 choiceNumber > 0 && choiceNumber <= player1Team.count+1 else {
            playerChosen = nil
            print ("Veuillez entrer un nombre entre 1 et \(player1Team.count+1)")
                continue
               }
            if choiceNumber == player1Team.count+1 {
                print("L'arme a été jeté à la poubelle !")
                break
            }
            if j == 1 {
                player1Team[choiceNumber-1].weapon = weapon
            } else {
                player2Team[choiceNumber-1].weapon = weapon
            }
            
        playerChosen = choiceNumber
           
        }
        
    }
    
    // this function create a random weapon
    // ask the player who will equipe this new weapon
    // (few weapon doesn't exist in character select, only in the code, like excalibur)
    private func equipWeaponTreasure(j : Int){
        
        //create a random weapon
        let numberWeapon = Int.random(in : 1..<7)
        var weapon = Weapon()
        
        switch numberWeapon {
        case 1 :
            weapon = Axe()
        case 2 :
            weapon = Dagger()
        case 3 :
            weapon = Stick()
        case 4 :
            weapon = Excalibur()
        case 5 :
            weapon = Sword()
        case 6 :
            weapon = WoodSword()
        default :
         print("ça n'arrivera pas")
        }
        
        print("***************************************")
        print("Quelle chance Joueur\(j) un trésor magique vient d'apparaitre devant vous !")
        print("Il contient : \(weapon.name) , attaque : \(weapon.hpAttack) ")
        print("Sur quel personnage voulez vous l'équiper?" )
        print("****************************************")
        
        // select a character who will attribute a new weapon
        // the player can select "none", the new weapon is destroyed
        changeWeapon(weapon : weapon , j : j )
        
    }
    
    
    
    
    // this function can create a random treasure
    // this function is excuted 15% of time
    private func treasureRandom(j : Int){
        let number = Int.random(in : 0..<7)

        // if the random number is 6 then a treasure appears, else nothing
        if number == 6 {

            // ask player who will get the new weapon
            equipWeaponTreasure(j: j)
 
        }
    }
    
    // ask player who will do the action
    // if the number is incorrect ask again the question
    // j is the current player
    // this function return the character selected, used in selectTarget(j)
    private func selectCharacterAction(j : Int) -> Character {
       
        // show the current team
         print("")
         print("A toi Joueur\(j) quel personnage va effectuer une action?")
         showTeam(j: j)
        
        var playerChosen: Character?
        
        while playerChosen == nil {

           guard let number = readLine(),
                 let choiceNumber = Int(number),
                 choiceNumber > 0 && choiceNumber <= player1Team.count else {
            playerChosen = nil
            print ("Veuillez entrer un nombre entre 1 et \(player1Team.count)")
                continue
               }
            
            // the current player can't select a death character, question asked again
            // player can select a character, the function return this one
            if j == 1 {
                if player1Team[choiceNumber-1].hp != 0 {
                print("Vous avez sélectionné le personnage \(player1Team[choiceNumber-1].name)")
                    playerChosen = player1Team[choiceNumber-1] }
                else {
                    print("Vous ne pouvez pas sélectionner ce personnage, il est mort")
                    playerChosen = nil
                }

            } else if j == 2 {
                if player2Team[choiceNumber-1].hp != 0 {
                print("Vous avez sélectionné le personnage \(player2Team[choiceNumber-1].name)")
                    playerChosen = player2Team[choiceNumber-1]
                } else {
                    print("Vous ne pouvez pas sélectionner ce personnage, il est mort")
                    playerChosen = nil
                }
            }
       
        }
        return playerChosen!
    }
    
    // ask player the action to do
    // here no need "j" because the action will be the same for the 2 players
    // this function will return an Int, the action selected
    // it's used in the function selectTarget(j)
    private func selectAction() -> Int {
        
        print("")
        print("Quelle action veux tu effectuer?")
        print("1 : Soigner un de mes personnage")
        print("2 : Attaquer un personnage ennemi")
        print("")
        
        var action: Int?
        
        while action == nil {

           guard let number = readLine(),
                 let choiceNumber = Int(number),
                 choiceNumber > 0 && choiceNumber <= 2 else {
            action = nil
            print ("Veuillez entrer un nombre entre 1 et 2")
                continue
               }
            action = choiceNumber
        }
        return action!
    }
    
    // ask to the player, the action target
    // j is the currently player
    // characterSelect is the character who will do the action
    // action is the action ( 1 for heal, 2 for attack)
    private func selectTarget( j : Int){
        let characterSelect = selectCharacterAction(j: j)
        let action = selectAction()
        
        var choice: Int?
        
        
        // if action is heal, show the same team
        // if action is attack, show the enemy team
        if j == 1 {
            if action == 1 {
                print("Quel personnage voulez vous soigner?")
                showTeam(j: action)
            } else {
                print("Quel personnage voulez vous attaquer?")
                showTeam(j: action)
            }
        } else if j == 2 {
            if action == 1 {
                print("Quel personnage voulez vous soigner?")
                showTeam(j: action+1)
            } else {
                print("Quel personnage voulez vous attaquer?")
                showTeam(j: action-1)
            }
        }
        
        while choice == nil {

           guard let number = readLine(),
                 let choiceNumber = Int(number),
                 choiceNumber > 0 && choiceNumber <= player1Team.count else {
            choice = nil
            print ("Veuillez entrer un nombre entre 1 et \(player1Team.count)")
                continue
               }
            if j == 1 {
                if action == 1 {
                characterSelect.heal(heal: player1Team[choiceNumber-1])
                } else if action == 2{
                characterSelect.attack(target: player2Team[choiceNumber-1])
                }
            } else if j == 2{
                if action == 1 {
                characterSelect.heal(heal: player2Team[choiceNumber-1])
                } else if action == 2{
                characterSelect.attack(target: player1Team[choiceNumber-1])
                }
            }
            
            choice = choiceNumber
        }
    }

// this function is the only public function
// this function can be used for start a new game
public func startGame(){
    
    //function where the 2 players create their team
    teamConstructor()
    
    print("")
    print("Maintenant que les équipes sont créées, place à la bataille !")
    print("")
    
        // while the 2 teams are alive the game continue
        while testOneTeamIsDeath(array1: player1Team, array2: player2Team) {
            print("Tour n° \(roundsGame) :")
            roundsGame += 1
            for j in 1...2 {
                // a treasure MAYBE appears
                // a treasure has a random weapon
                   treasureRandom(j: j)
                    
                    // in this function the player will select :
                    // the character, the action, and the target
                    selectTarget( j : j)
                    
                    // test if one of he two team is dead
                    // if not, the game continue
                    // else the game is finished
                    if !(testOneTeamIsDeath(array1: player1Team, array2: player2Team)){
                        print("Vous avez tué tout ses personnages ! ")
                        print("Le Joueur \(j) à gagné ! félicitations !")
                        print("")
                        resumeTeams()
                        print("")
                        print("Il a fallu \(roundsGame-1) tours pour terminer ce mini jeu ! ")
                        break
                    }
            }
        }

}
}



// class Character
// name is the character name
// weapon is the weapon
// hp is the current hp
class Character  {
    var name : String
    var weapon : Weapon {
        willSet{
            
        }
        didSet{
            print("Le personnage \(name) possède désormais un(e) \(weapon.description())")
        }
    }
    var hp = 50 {
        willSet{
            
        }
        didSet{
            // if the hp are negative
            // print "character is dead", then hp = 0
            if hp <= 0{
                print("")
                print("Le personnage \(name) est mort il lui reste 0 hp")
                print("")
                hp = 0
            // a character has hpMax
            // hp can't be superior than hpMax, so if hp>hpMax then hp = hpMax
            } else if hp > hpMax() {
                print("")
                print("Votre personnage \(name) est au maximum de ses hp max il possède désormais \(hpMax()) hp ")
                hp = hpMax()
                print("")
            }
            // if oldValue < hp then print "the character earn hp"
            else if oldValue < hp {
                print("")
                print("Votre personnage a récupéré \(abs(oldValue - hp)) hp il possède désormais \(hp) hp")
                print("")
            // if oldValue > hp then "print character lost hp"
            } else if oldValue > hp{
                print("")
                print("Le personnage \(name) a perdu \(abs(hp - oldValue)) hp ! il lui reste \(hp) hp")
                print("")
            }
        }
    }
    
    //create a character with a name, a weapon and hp
    init(name : String, weapon : Weapon, hp : Int){
        self.name = name
        self.weapon = weapon
        self.hp = hp
    }
    
    //create a character without name, weapon, hp
    // defaults Values
    convenience init(){
        self.init(name : "nomParDefaut", weapon : Weapon(), hp : 50)
    }
    
    // return hpMax
    func hpMax() -> Int {
        return hp
    }
    
    // a description of the character that has just been created
    func createDescription() -> String {
        return (" vous venez de créer \(name) son arme est un(e) \(weapon.name) qui tape \(weapon.hpAttack) et il possède \(hp) hp !")
    }
    
    // a short description of character
    // show "name : hp, weapon : attack"
    func shortDescription() -> String {
        return ("\(name) : \(hp) hp, arme : \(weapon) ( \(weapon.hpAttack) dégats)")
    }
    
    //attack an enemy
    func attack(target : Character){
        target.hp -= weapon.hpAttack
    }
    
    //heal an ally
    func heal(heal : Character){
        heal.hp += weapon.hpAttack
    }
    
    // create a copy of the character
    // this one is used when the player select a Character at begin
    func copyCharacter() -> Character {
        let newCharacter = Character()
        return newCharacter
    }
    
}

// class Legionnary
class Legionnary : Character{
    let type: String = "Legionnaire"
    let maxHp = 45
    
    init(){
    let type: String = type
    let weapon: Weapon = Sword()
        
    super.init(name: type, weapon: weapon, hp: maxHp)
    }
        
    override func shortDescription() -> String {
        return ("\(name) : \(hp) hp, arme : \(weapon.name) ( \(weapon.hpAttack) dégats )")
    }
    
    override func createDescription() -> String{
        return ("vous venez de créer \(name) qui est un \(type) , son arme est un(e) \(weapon.name) qui tape \(weapon.hpAttack) et il possède \(hp) hp !")
    }
    
     override func hpMax() -> Int {
        return maxHp
    }
    
    override func copyCharacter() -> Character {
        let newCharacter = Legionnary()
        return newCharacter
    }
}

//class Assassin
class Assassin : Character {
    let type: String = "Assassin"
    let maxHp = 30
    
    init(){
    let type: String = type
    let weapon: Weapon = Dagger()
        
    super.init(name: type, weapon: weapon, hp: maxHp)
    }
        
    override func shortDescription() -> String {
        return ("\(name) : \(hp) hp, arme : \(weapon.name) ( \(weapon.hpAttack) dégats )")
    }
    
    override func createDescription() -> String {
        return ("vous venez de créer \(name) qui est un \(type) , son arme est un(e) \(weapon.name) qui tape \(weapon.hpAttack) et il possède \(hp) hp !")
    }
    
     override func hpMax() -> Int {
        return maxHp
    }
    
    override func copyCharacter() -> Character {
        let newCharacter = Assassin()
        return newCharacter
    }
}

// class Monk
class Monk : Character {
    let type: String = "Moine"
    let maxHp = 60
    
    init(){
    let type: String = type
    let weapon: Weapon = Scepter()
        
    super.init(name: type, weapon: weapon, hp: maxHp)
    }
        
    override func shortDescription() -> String {
        return ("\(name) : \(hp) hp, arme : \(weapon.name) ( \(weapon.hpAttack) dégats )")
    }
    
    override func createDescription() -> String {
        return ("vous venez de créer \(name) qui est un \(type) , son arme est un(e) \(weapon.name) qui tape \(weapon.hpAttack) et il possède \(hp) hp !")
    }
    
     override func hpMax() -> Int {
        return maxHp
    }
    
    override func copyCharacter() -> Character {
        let newCharacter = Monk()
        return newCharacter
    }
}

// class Magician
class Magician : Character {
    let type: String = "Magicien"
    let maxHp = 40
    
    init(){
    let type: String = type
    let weapon: Weapon = Stick()
        
    super.init(name: type, weapon: weapon, hp: maxHp)
    }
        
    override func shortDescription() -> String {
        return ("\(name) : \(hp) hp, arme : \(weapon.name) ( \(weapon.hpAttack) dégats )")
    }
    
    override func createDescription() -> String {
        return ("vous venez de créer \(name) qui est un \(type) , son arme est un(e) \(weapon.name) qui tape \(weapon.hpAttack) et il possède \(hp) hp !")
    }
    
     override func hpMax() -> Int {
        return maxHp
    }
    
    override func copyCharacter() -> Character {
        let newCharacter = Magician()
        return newCharacter
    }
}

//classe Barbaric
class Barbaric : Character {
    let type: String = "Barbare"
    let maxHp = 35
    
    init(){
    let type: String = type
    let weapon: Weapon = Axe()
        
    super.init(name: type, weapon: weapon, hp: maxHp)
    }
        
    override func shortDescription() -> String {
        return ("\(name) : \(hp) hp, arme : \(weapon.name) ( \(weapon.hpAttack) dégats )")
    }
    
    override func createDescription() -> String {
        return ("vous venez de créer \(name) qui est un \(type) , son arme est un(e) \(weapon.name) qui tape \(weapon.hpAttack) et il possède \(hp) hp !")
    }
    
     override func hpMax() -> Int {
        return maxHp
    }
    
    override func copyCharacter() -> Character {
        let newCharacter = Barbaric()
        return newCharacter
    }
}


//class Weapon
// name is the name of the weapon
// hpAttack is the damages of this weapon
class Weapon{
    var name : String
    var hpAttack : Int
    
    //create a weapon with a name and and attack number
    init( name : String , hpAttack : Int){
        self.name = name
        self.hpAttack = hpAttack
    }
    
    //create a weapon without name and attack number
    //defaults Values
    convenience init(){
        self.init(name : "nomParDéfaut", hpAttack : 0 )
    }
    
    // description of the weapon, return a String
    func description() -> String {
        return ("\(name) (attaque : \(hpAttack))")
    }
}

//class Stick
class Stick : Weapon{
    
    init(){
        super.init(name: "bâton", hpAttack: 13)
    }
    
}


// class Axe
class Axe : Weapon{
    
    init(){
        super.init(name: "hache", hpAttack: 15)
    }

}

// class Sword
class Sword : Weapon{
    
    init(){
        super.init(name: "epee", hpAttack: 11)
    }
}

// class WoodSword
class WoodSword : Weapon{
    
    init(){
        super.init(name: "epee en bois", hpAttack: 1)
    }
}

// class Dagger
class Dagger : Weapon{
    
    init(){
        super.init(name: "dague", hpAttack: 19)
    }
}

//class Scepter
class Scepter : Weapon{
    
    init(){
        super.init(name: "sceptre", hpAttack: 7)
    }
}

// class excalibur
class Excalibur : Weapon{
    
    init(){
        super.init(name: "excalibur", hpAttack: 40)
    }
}


var jeu = Game()
jeu.startGame()

