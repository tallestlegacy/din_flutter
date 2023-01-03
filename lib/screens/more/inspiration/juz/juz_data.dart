class Juz {
  final int id;
  final List<int> chapters;
  final String name;
  final String translation;
  final String transliteration;
  final Map verses;

  Juz({
    required this.id,
    required this.chapters,
    required this.verses,
    required this.name,
    required this.translation,
    required this.transliteration,
  });

  factory Juz.fromJson(dynamic json) => Juz(
        id: json["id"] as int,
        chapters: json["chapters"] as List<int>,
        verses: json["verses"],
        name: json["name"] as String,
        translation: json["translation"] as String,
        transliteration: json["transliteration"] as String,
      );
}

const List<Map<String, dynamic>> juz = [
  {
    "id": 1,
    "name": "آلم",
    "translation": "A.L.M",
    "transliteration": "Alīf-Lām-Mīm",
    "chapters": [1, 2],
    "verses": {
      "1": [1, 7],
      "2": [1, 141]
    }
  },
  {
    "id": 2,
    "name": "سَيَقُولُ",
    "translation": "\"Will (they) say\"",
    "transliteration": "Sayaqūlu",
    "chapters": [2],
    "verses": {
      "2": [142, 252]
    }
  },
  {
    "id": 3,
    "name": "تِلْكَ ٱلْرُّسُلُ",
    "translation": "\"These are the Messengers\"",
    "transliteration": "Tilka ’r-Rusulu",
    "chapters": [2, 3],
    "verses": {
      "2": [253, 286],
      "3": [1, 92]
    }
  },
  {
    "id": 4,
    "name": "لن تنالوا",
    "translation": "\"You will not get\"",
    "transliteration": "Lan Tana Lu",
    "chapters": [3, 4],
    "verses": {
      "3": [93, 200],
      "4": [1, 23]
    }
  },
  {
    "id": 5,
    "name": "وَٱلْمُحْصَنَاتُ",
    "translation": "\"And prohibited are the ones who are married\"",
    "transliteration": "Wa’l-muḥṣanātu",
    "chapters": [4],
    "verses": {
      "4": [24, 147]
    }
  },
  {
    "id": 6,
    "name": "لَا يُحِبُّ ٱللهُ",
    "translation": "\"Allah does not like\"",
    "transliteration": "Lā yuḥibbu-’llāhu",
    "chapters": [4, 5],
    "verses": {
      "4": [148, 176],
      "5": [1, 81]
    }
  },
  {
    "id": 7,
    "name": "وَإِذَا سَمِعُوا",
    "translation": "\"And when they hear\"",
    "transliteration": "Wa ’Idha Samiʿū",
    "chapters": [5, 6],
    "verses": {
      "5": [82, 120],
      "6": [1, 110]
    }
  },
  {
    "id": 8,
    "name": "وَلَوْ أَنَّنَا",
    "translation": "\"And (even) if (that) we had\"",
    "transliteration": "Wa-law annanā",
    "chapters": [6, 7],
    "verses": {
      "6": [111, 165],
      "7": [1, 87]
    }
  },
  {
    "id": 9,
    "name": "قَالَ ٱلْمَلَأُ",
    "translation": "\"Said the chiefs (eminent ones)\"",
    "transliteration": "Qāla ’l-mala’u",
    "chapters": [7, 8],
    "verses": {
      "7": [88, 206],
      "8": [1, 40]
    }
  },
  {
    "id": 10,
    "name": "وَٱعْلَمُواْ",
    "translation": "\"And (you) know\"",
    "transliteration": "Wa-’aʿlamū",
    "chapters": [8, 9],
    "verses": {
      "8": [41, 75],
      "9": [1, 92]
    }
  },
  {
    "id": 11,
    "name": "يَعْتَذِرُونَ",
    "translation": "\"Only the way (for blame)\"",
    "transliteration": "Yaʿtazerūn",
    "chapters": [9, 10, 11],
    "verses": {
      "9": [92, 129],
      "10": [1, 109],
      "11": [1, 5]
    }
  },
  {
    "id": 12,
    "name": "وَمَا مِنْ دَآبَّةٍ",
    "translation": "\"And there is no creature\"",
    "transliteration": "Wa mā min dābbatin",
    "chapters": [11, 12],
    "verses": {
      "11": [6, 123],
      "12": [1, 52]
    }
  },
  {
    "id": 13,
    "name": "وَمَا أُبَرِّئُ",
    "translation": "\"And I do not acquit\"",
    "transliteration": "Wa mā ubarri’u",
    "chapters": [12, 13, 14],
    "verses": {
      "12": [53, 111],
      "13": [1, 43],
      "14": [1, 52]
    }
  },
  {
    "id": 14,
    "name": "رُبَمَا",
    "translation": "A.L.R",
    "transliteration": "Alīf-Lām-Rā’  Rubamā",
    "chapters": [15, 16],
    "verses": {
      "15": [1, 99],
      "16": [1, 128]
    }
  },
  {
    "id": 15,
    "name": "سُبْحَانَ ٱلَّذِى",
    "translation": "\"Exalted is the One ( Allahu ‘Azza wa-jalla ) is who \"",
    "transliteration": "Subḥāna ’lladhī",
    "chapters": [17, 18],
    "verses": {
      "17": [1, 111],
      "18": [1, 74]
    }
  },
  {
    "id": 16,
    "name": "قَالَ أَلَمْ",
    "translation": "\"He ( Al-Khidr ) said: Did not\"",
    "transliteration": "Qāla ’alam",
    "chapters": [18, 19, 20],
    "verses": {
      "18": [75, 110],
      "19": [1, 98],
      "20": [1, 135]
    }
  },
  {
    "id": 17,
    "name": "ٱقْتَرَبَ لِلْنَّاسِ",
    "translation": "\"Has (the time of) approached for Mankind (people)\"",
    "transliteration": "Iqtaraba li’n-nāsi",
    "chapters": [21, 22],
    "verses": {
      "21": [1, 112],
      "22": [1, 78]
    }
  },
  {
    "id": 18,
    "name": "قَدْ أَفْلَحَ",
    "translation": "\"Indeed (Certainly) successful\"",
    "transliteration": "Qad ’aflaḥa",
    "chapters": [23, 24, 25],
    "verses": {
      "23": [1, 118],
      "24": [1, 64],
      "25": [1, 20]
    }
  },
  {
    "id": 19,
    "name": "وَقَالَ ٱلَّذِينَ",
    "translation": "\"And said those who\"",
    "transliteration": "Wa-qāla ’lladhīna",
    "chapters": [25, 26, 27],
    "verses": {
      "25": [21, 77],
      "26": [1, 227],
      "27": [1, 55]
    }
  },
  {
    "id": 20,
    "name": "أَمَّنْ خَلَقَ",
    "translation": "\"Is He Who created…\"",
    "transliteration": "’A’man Khalaqa",
    "chapters": [27, 28, 29],
    "verses": {
      "27": [56, 93],
      "28": [1, 88],
      "29": [1, 45]
    }
  },
  {
    "id": 21,
    "name": "أُتْلُ مَاأُوْحِیَ",
    "translation": "\"Recite, [O Muhammad], what has been revealed to you\"",
    "transliteration": "Otlu ma oohiya",
    "chapters": [29, 30, 31, 32, 33],
    "verses": {
      "29": [46, 69],
      "30": [1, 60],
      "31": [1, 34],
      "32": [1, 30],
      "33": [1, 30]
    }
  },
  {
    "id": 22,
    "name": "وَمَنْ يَّقْنُتْ",
    "translation": "\"And whoever is obedient (devoutly obeys)\"",
    "transliteration": "Wa-man yaqnut",
    "chapters": [33, 34, 35, 36],
    "verses": {
      "33": [31, 73],
      "34": [1, 54],
      "35": [1, 45],
      "36": [1, 27]
    }
  },
  {
    "id": 23,
    "name": "وَمَآ لي",
    "translation": "\"And what happened to me\"",
    "transliteration": "Wa-Mali",
    "chapters": [36, 37, 38, 39],
    "verses": {
      "36": [28, 83],
      "37": [1, 182],
      "38": [1, 88],
      "39": [1, 31]
    }
  },
  {
    "id": 24,
    "name": "فَمَنْ أَظْلَمُ",
    "translation": "\"So who is more unjust\"",
    "transliteration": "Fa-man ’aẓlamu",
    "chapters": [39, 40, 41],
    "verses": {
      "39": [32, 75],
      "40": [1, 85],
      "41": [1, 46]
    }
  },
  {
    "id": 25,
    "name": "إِلَيْهِ يُرَدُّ",
    "translation":
        "\"To Him ( Allahu Subhanahu wa-Ta'ala ) alone is attributed\"",
    "transliteration": "Ilayhi yuraddu",
    "chapters": [41, 42, 43, 44, 45],
    "verses": {
      "41": [47, 54],
      "42": [1, 53],
      "43": [1, 89],
      "44": [1, 59],
      "45": [1, 37]
    }
  },
  {
    "id": 26,
    "name": "حم",
    "translation": "\"Known to Allah or Ha Meem\"",
    "transliteration": "Ḥā’ Mīm",
    "chapters": [46, 47, 48, 49, 50, 51],
    "verses": {
      "46": [1, 35],
      "47": [1, 38],
      "48": [1, 29],
      "49": [1, 18],
      "50": [1, 45],
      "51": [1, 30]
    }
  },
  {
    "id": 27,
    "name": "قَالَ فَمَا خَطْبُكُم",
    "translation":
        "He ( Ibrahim A.S. ) said: \"Then what is your business (mission) here\"",
    "transliteration": "Qāla fa-mā khaṭbukum",
    "chapters": [51, 52, 53, 54, 55, 56, 57],
    "verses": {
      "51": [31, 60],
      "52": [1, 49],
      "53": [1, 62],
      "54": [1, 55],
      "55": [1, 78],
      "56": [1, 96],
      "57": [1, 29]
    }
  },
  {
    "id": 28,
    "name": "قَدْ سَمِعَ ٱللهُ",
    "translation": "\"Indeed has Allah heard\"",
    "transliteration": "Qad samiʿa ’llāhu",
    "chapters": [58, 59, 60, 61, 62, 63, 64, 65, 66],
    "verses": {
      "58": [1, 22],
      "59": [1, 24],
      "60": [1, 13],
      "61": [1, 14],
      "62": [1, 11],
      "63": [1, 11],
      "64": [1, 18],
      "65": [1, 12],
      "66": [1, 12]
    }
  },
  {
    "id": 29,
    "name": "تَبَارَكَ ٱلَّذِى",
    "translation": "\"Blessed is He ( Allah Subhanahu wa-Ta'ala )\"",
    "transliteration": "Tabāraka ’lladhī",
    "chapters": [67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77],
    "verses": {
      "67": [1, 30],
      "68": [1, 52],
      "69": [1, 52],
      "70": [1, 44],
      "71": [1, 28],
      "72": [1, 28],
      "73": [1, 20],
      "74": [1, 56],
      "75": [1, 40],
      "76": [1, 31],
      "77": [1, 50]
    }
  },
  {
    "id": 30,
    "name": "عَمَّ",
    "translation": "\"About what\"",
    "transliteration": "‘Amma",
    "chapters": [
      78,
      79,
      80,
      81,
      82,
      83,
      84,
      85,
      86,
      87,
      88,
      89,
      90,
      91,
      92,
      93,
      94,
      95,
      96,
      97,
      98,
      99,
      100,
      101,
      102,
      103,
      104,
      105,
      106,
      107,
      108,
      109,
      110,
      111,
      112,
      113,
      114
    ],
    "verses": {
      "78": [1, 40],
      "79": [1, 46],
      "80": [1, 42],
      "81": [1, 29],
      "82": [1, 19],
      "83": [1, 36],
      "84": [1, 25],
      "85": [1, 22],
      "86": [1, 17],
      "87": [1, 19],
      "88": [1, 26],
      "89": [1, 30],
      "90": [1, 20],
      "91": [1, 15],
      "92": [1, 21],
      "93": [1, 11],
      "94": [1, 8],
      "95": [1, 8],
      "96": [1, 19],
      "97": [1, 5],
      "98": [1, 8],
      "99": [1, 8],
      "100": [1, 11],
      "101": [1, 11],
      "102": [1, 8],
      "103": [1, 3],
      "104": [1, 9],
      "105": [1, 5],
      "106": [1, 4],
      "107": [1, 7],
      "108": [1, 3],
      "109": [1, 6],
      "110": [1, 3],
      "111": [1, 5],
      "112": [1, 4],
      "113": [1, 5],
      "114": [1, 6]
    }
  }
];
