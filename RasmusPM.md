# Loki's Tale - Post Mortem
Rasmus Johansson 10/1-2024

## Inledning
Syftet med detta projekt var att skapa ett Pong-baserat spel anpassat till en modern och nutida publik med hjälp av spelmotorn Godot. Vår plan var att skapa en roguelite baserad på nordisk mytologi där målet var att ta sig från Hels djup ända upp till Asgard i syfte av att nå Valhalla. Påvägen till sitt mål stöter spelaren på flera olika fiender den måste slåss mot i en pong-liknande duell. Efter striderna får spelaren möjligheten att välja ett av tre stycken slumpmässigt valda föremål som antigen uppgraderar en av spelarens redan existerande förmågor eller erbjuder nya. Spelaren måste ta sig igenom ett antal världar innan de kan nå Valhalla. Världarnas layout är slumpmässigt genererade och blir successivt längre och svårare för varje värld spelaren tar sig igenom. Världen är grid-baserad och spelaren kan röra sig en ruta åt gången längs de fyra vädersträcken. Varje värld har även en egen boss som vaktar utvägen. För att låsa upp bossen måste spelaren dock först hitta en slumpmässigt placerad nyckel. Utöver dessa världar finns det även en huvudkarta där spelaren väljer vilken värld de vill spela igenom. På huvudkartan sorteras världarna i en sorts trädstruktur. För att låsa upp en värld krävs det att spelaren klarat ut de världar som är anslutna till den.

## Bakgrund
Till det här projektet var vi tre stycken personer som var för sig jobbade på egna olika delar av spelet. Dessa delar var föremål, fiender och kartan som jag jobbade på. Jag började med att jobba på själva huvudkartan där man sedan kan välja vilken värld man ska spela. Först gjorde jag denna karta ganska skalbar där man själv kunde ställa in hur många världar man ville skulle visas upp på kartan samt hur många grenar trädstrukturen skulle ha. Detta såg däremot inte väldigt bra ut i spelet själv och ledde till vissa problem samt att eftersom detta spel är baserat på nordisk mytologi krävdes det endast att vi hade nio stycken världar. På grund av detta är själva huvudkartan hårdkodad med hur världar är placerade och med vilka världar de är anslutna till.

Efter att huvudkartan var färdig började jag jobba på själva världarna. För att automatiskt skapa slumpmässigt genererade kartor använde jag mig av "Random Walk" metoden då den är väldigt enkel att implementera och fungerar bra till spelet. Jag använde mig då av enskilda sprite noder för att skapa varje tile. Nu i efterhand tror jag att det hade varit bättre att använda sig av en Tilemap nod däremot. 

Slutligen gjorde jag partiklar till bollen baserat på vilka uppgraderingar och items spelaren låst upp. 

## Vad gick bra
Att implementera Random Walk algoritmen så att den genererar nya fungerande kartor varje gång gick ganska bra.
Att jobba i grupp på det viset vi gjorde tyckte jag fungerade ganska bra. Eftersom att vi bara var tre stycken lyckades vi dela upp det så att vi alla jobbade på vår egen del av spelet och oftast utan att skapa problem med andra genom mergekonflikter. Det fungerade även ganska bra att ta hjälp av varandra och bidra till gruppen.


## Vad gick mindre bra
När spelaren träffar på en fiende var det tänkt att världen skulle sparas och scenen bytas till "strids-scenen". Efter att spelaren vunnit denna strid skulle scenen bytas tillbaka till världen spelaren var i. Världens layout skulle inte vara förändrad och spelarens position skulle vara densamma som den var innan striden skedde. För att göra detta krävdes det att flera variabler sparades och uppdaterades samt laddades. Problemet var att jag från början inte riktigt tänkte på hur jag skulle implementera en sparfunktion. Detta led till en del funktioner som var ganska röriga och slutade i att en del variabler aldrig ens användes.

Något jag även hade problem med var att rita ut vägarna mellan de olika världarna. Tanken var att vägarna skulle lysa olika färger beroende på om båda världarna var avklarade eller ej. 

Slutet gott, allting gott. :D