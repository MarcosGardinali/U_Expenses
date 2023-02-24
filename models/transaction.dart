//Atributos das transações
class Transaction{
  final String id;
  final String title;
  final double value;
  final DateTime date;

//Contrutor criado com todos os atributos requeridos
 const Transaction({
   required this.id,
   required this.title,
   required this.value,
   required this.date
  });
}