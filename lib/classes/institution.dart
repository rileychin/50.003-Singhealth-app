class Institution{

  //institution is only to display the list of staffs and tenants
  //added into list everytime a user registers or expires.
  List<String> listOfStaffs;
  List<String> listOfTenants;

  static List<String> convertToStringList(List fullTenantList) {
    List<String> returnList=[];
    for (int i = 0; i<fullTenantList.length;i++){
      returnList.add(fullTenantList[i].toString());
    }
    return returnList;
  }

  static List<String> nonFnBTenantList =  ['168 Florist','Eu Yan Sang',
    'Hua Xia Taimobi Centre',
    'Mothercare',
    'The Choice Gift House',
    'B&G LifeCasting',
    'Junior Page',
    'Neol Gifts',
    'Spextacular Optics',
    'Lifeforce Limbs',
    'Noel',
    'Lifeline',
    'Noel Gifts',
    'Anytime Fitness',
    'Kindermusk',
  ];

  static List<String> fullTenantList(String institutionName) {
    switch (institutionName) {
    //Changi General Hospital
      case 'CGH':
        return ['Kopitiam', '1983', 'Subway', '7-Eleven', 'UmiSushi',
          'Starbucks', 'Mr Bean', '168 Florist'];

    //KK Hospital
      case 'KKH':
        return [
          'Mr Bean',
          'Delifrance',
          'Orchid Thai',
          'FairPrice Xpress',
          'Triplets',
          'Kopitiam',
          'Eu Yan Sang',
          'Hua Xia Taimobi Centre',
          'Mothercare',
          'The Choice Gift House',
          'B&G LifeCasting',
          'Junior Page',
          'Neol Gifts',
          'Spextacular Optics'
        ];

    //Singapore General Hospital
      case 'SGH':
        return [
          'Kaki Makan',
          'Coffee Bean',
          'Triplets',
          '7-Eleven',
          'Kaffe & Toast',
          'Kopitiam',
          'Polar',
          'Orchid Thai',
          'Mr Bean',
          'Lifeforce Limbs',
          'Noel',
          'Lifeline'
        ];

    //Sengkang Hospital
      case 'SKH':
        return [
          'Koufu',
          'Mr Bean',
          'Coffee Bean',
          'Polar',
          'Coffee Club',
          'Heavenly Wang',
          'Auntie Rosie',
          'Jewel Coffee',
          'Cheers',
          'Noel Gifts',
          'Anytime Fitness',
          'Kindermusk'
        ];


    //National Cancer Centre Singapore
      case 'NCCS':
        return ['CookBook'];
        break;

    //National Heart Centre Singapore
      case 'NHCS':
        return ['Kopitiam', 'Kaffee & Toast'];
        break;

    //Bright Vision Hospital
      case 'BVH':
        return ['Sky Cafe'];

    //Outram Community Hospital
      case 'OCH':
        return ['Starbucks', 'The Caffeine Experience', 'FairPrice Express'];
        break;

    //Academia
      case 'Academia':
        return ['Coffee Club'];

      default:
        return ['Kopitiam', '1983', 'Subway', '7-Eleven', 'UmiSushi',
          'Starbucks', 'Mr Bean', '168 Florist'];
    }
  }


}
