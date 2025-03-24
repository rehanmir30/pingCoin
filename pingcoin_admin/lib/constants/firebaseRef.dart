import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;
final userRef = firestore.collection('Users');
final coinsRef = firestore.collection('Coins');
final businessesRef=firestore.collection("Businesses");
final adInterestRef = firestore.collection('AdInterests');
final supportRef = firestore.collection('Support');
final faqRef = firestore.collection('FAQs');
final adsRef = firestore.collection('Ads');
final managementRef = firestore.collection('Management');
final sysConfigRef = firestore.collection('SystemConfiguration');

// final specificCodeRef=firestore.collection("specificCodes");
