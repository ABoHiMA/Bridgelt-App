import 'package:flutter/material.dart';

Color bg = Colors.deepPurpleAccent;
Color clr = const Color.fromARGB(255, 238, 234, 255);
bool ae = true;
int index = 0;
String? thmMode;
bool? onBoarding;
String? uId;
String? userType;
bool? verify;
String msgTeam = "";
String fPrint = "";
bool drSelected = false;
bool vSelected = false;
bool spSelected = false;
String bridgeltMail = "Bridgeltt@hotmail.com";
Map<String, List<String>> governorate = {
  'Alexandria': [
    'Borg El Arab',
    'Miami',
    'Montaza',
    'Smouha',
    'Stanley',
  ],
  'Aswan': [
    'Aswan',
    'Edfu',
    'Kom Ombo',
    'Abu Simbel',
    'Daraw',
  ],
  'Assiut': [
    'Assiut',
    'Abu Tig',
    'Manfalut',
    'Sahel Selim',
    'Dayrout',
  ],
  'Beheira': [
    'Damanhour',
    'Rashid',
    'Kafr El Dawwar',
    'Abu Hummus',
    'Rosetta',
  ],
  'Beni Suef': [
    'Beni Suef',
    'Nasser',
    'Beba',
    'Biba',
    'El Fashn',
  ],
  'Cairo': [
    'Nasr City',
    'Maadi',
    'Heliopolis',
    'Mohandessin',
    'Zamalek',
  ],
  'Dakahlia': [
    'Mansoura',
    'Talkha',
    'Mit Ghamr',
    'El Senbellawein',
    'Agamiyet El Mahalla',
  ],
  'Damietta': [
    'Damietta',
    'Kafr Saad',
    'Kafr El-Batikh',
    'New Damietta',
    'Ras El Bar',
  ],
  'Fayoum': [
    'Fayoum',
    'Tamiya',
    'Ibsheway',
    'Senouras',
    'Yusuf El Sediaq',
  ],
  'Gharbia': [
    'Tanta',
    'Kafr El Zayat',
    'Mahalla El Kubra',
    'Zefta',
    'Samannoud',
  ],
  'Giza': [
    'Giza',
    '6th of October City',
    'Sheikh Zayed City',
    'Al Haram',
    'Agouza',
    'El-Warraq',
    'Nahia',
  ],
  'Ismailia': [
    'Ismailia',
    'Fayed',
    'Qantara Sharq',
    'El Qantara',
    'El Tal El Kebir',
  ],
  'Kafr el-Sheikh': [
    'Kafr El Sheikh',
    'Desouk',
    'Metoubes',
    'Fuwwah',
    'Baltim',
  ],
  'Matrouh': [
    'Marsa Matruh',
    'El Hamam',
    'Alamein',
    'Dabaa',
    'Siwa',
  ],
  'Minya': [
    'Minya',
    'Sohag',
    'Beni Mazar',
    'Maghagha',
    'Abu Qurqas',
  ],
  'Menofia': [
    'Shebin El Koum',
    'Tala',
    'Ashmoun',
    'Menouf',
    'Sadat City',
  ],
  'New Valley': [
    'Kharga',
    'Dakhla',
    'Farafra',
    'Baris',
    'Mut',
  ],
  'North Sinai': [
    'Arish',
    'Rafah',
    'Bir Al Abd',
    'Sheikh Zuweid',
    'Nakhl',
  ],
  'Port Said': [
    'Port Said',
    'Port Fouad',
  ],
  'Qualyubia': [
    'Banha',
    'Qalyub',
    'Shubra El Kheima',
    'Obour',
    'Khosous',
  ],
  'Qena': [
    'Qena',
    'Naqada',
    'Qift',
    'Nag Hammadi',
    'Abu Tesht',
  ],
  'Red Sea': [
    'Hurghada',
    'Safaga',
    'El Gouna',
    'Marsa Alam',
    'Ras Gharib',
  ],
  'Al-Sharqia': [
    'Zagazig',
    'Al Husseiniya',
    '10th of Ramadan City',
    'Ain Shams',
    'Faqous',
  ],
  'Soha': [
    'Sohag',
    'Akhmim',
    'Girga',
    'Maragha',
    'Tahta',
  ],
  'South Sinai': [
    'Sharm El Sheikh',
    'Dahab',
    'Nuweiba',
    'Ras Sudr',
    'Saint Catherine',
  ],
  'Suez': [
    'Suez',
    'Ismailia',
    'Arbaeen',
    'El Ataba',
    'El Salam',
  ],
  'Luxor': [
    'Luxor',
    'Karnak',
    'El Bayadeya',
    'El Tod',
    'Esna',
  ],
};

final List<String> governorates = [
  'Alexandria',
  'Aswan',
  'Assiut',
  'Beheira',
  'Beni Suef',
  'Cairo',
  'Dakahlia',
  'Damietta',
  'Fayoum',
  'Gharbia',
  'Giza',
  'Ismailia',
  'Kafr el-Sheikh',
  'Matrouh',
  'Minya',
  'Menofia',
  'New Valley',
  'North Sinai',
  'Port Said',
  'Qualyubia',
  'Qena',
  'Red Sea',
  'Al-Sharqia',
  'Soha',
  'South Sinai',
  'Suez',
  'Luxor',
];
