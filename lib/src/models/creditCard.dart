
class CreditCard {

  String cardHolderName;
    String get getCardHoldeName => cardHolderName;
  String expiryDate;
    String get getExpiryDate => expiryDate;
  String cardNumber;
    String get getCardNumber => cardNumber;
  String cvvCode;
    String get getCvvCode =>  cvvCode;
  bool showBackView;
    bool get getShowBackView => showBackView;

  CreditCard({this.cardHolderName, this.expiryDate, this.cardNumber, this.cvvCode, this.showBackView});

}
