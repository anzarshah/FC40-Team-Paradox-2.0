// import 'package:flutter/cupertino.dart';
// import 'package:web3dart/web3dart.dart';
// import 'package:http/http.dart';

// class MetaMaskProvider extends ChangeNotifier {
//   late Client httpClient;

//   late Web3Client ethClient;

//   //Ethereum address
//   final String myAddress = "0x8fF1b659bDC9D6eF5d99823B155cfdf47eF2944d";

//   //url from Infura
//   final String blockchainUrl =
//       "https://rinkeby.infura.io/v3/4e577288c5b24f17a04beab17cf9c959";

//   //strore the value of alpha and beta
//   var totalVotesA;
//   var totalVotesB;

//   static const operatingChain = 4;

//   String currentAddress = '';

//   int currentChain = -1;

//   bool get isEnabled => ethereum != null;

//   bool get isInOperatingChain => currentChain == operatingChain;

//   bool get isConnected => isEnabled && currentAddress.isNotEmpty;

//   Future<void> connect() async {
//     if (isEnabled) {
//       final accs = await ethereum!.requestAccount();
//       if (accs.isNotEmpty) currentAddress = accs.first;

//       currentChain = await ethereum!.getChainId();

//       notifyListeners();
//     }
//   }

//   clear() {
//     currentAddress = '';
//     currentChain = -1;
//     notifyListeners();
//   }

//   init() {
//     if (isEnabled) {
//       ethereum!.onAccountsChanged((accounts) {
//         clear();
//       });
//       ethereum!.onChainChanged((accounts) {
//         clear();
//       });
//     }
//   }
// }
