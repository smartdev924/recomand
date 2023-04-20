import 'languages.dart';

class LanguageRo extends Languages {
  String get appName => "LocalService";
// error

  String get kEmailNullError => "Te rog introdu e-mailul tău";
  String get kInvalidEmailError => "Vă rugăm să introduceți un e-mail valid";
  String get kPassNullError => "Va rugam sa introduceti parola";
  String get kConfirmPasswordError => "Parola nepotrivită";
  String get kShortPassError =>
      "Parola este prea scurtă, cel puțin 8 caractere";
  String get kMatchPassError => "Parolele nu se potrivesc";
  String get kNameNullError => "Te rog sa introduci numele complet";
  String get kPhoneNumberNullError =>
      "Vă rugăm să introduceți numărul dvs. de telefon";
  String get kAddressNullError => "Vă rugăm să introduceți adresa dvs";
  String get kTitleNullError => "Vă rugăm să introduceți titlul produsului dvs";
  String get kDescriptionNullError => "Vă rugăm să introduceți descrierea";
  String get kPriceNullError => "Vă rugăm să introduceți prețul";
  String get kDeadLineNullError => "Vă rugăm să introduceți termenul limită";

  //Splash screen, sign in, sign out, reset, etc - first screens
  String get slogan => 'Până la 7 oferte cu 1 cerere!';
  String get lab_continue => 'Continua';
  String get signin => 'Login';
  String get signup => 'Inregistrare';
  String get createaccount => 'Creează cont';
  String get forgotpassword => 'Ai uitat parola';
  String get email => 'E-mail';
  String get password => 'Parola';
  String get pleaseendteryouremail => 'Te rog introdu e-mailul tău';
  String get pleaseenteryourpassword => 'Va rugam sa introduceti parola';
  String get forgotpassword_description =>
      'Te rugam sa introduci adresa ta de email. Veți primi un link pentru a crea o nouă parolă prin e-mail.';
  String get lab_send => 'TRIMITE';
  String get changepassword => 'SCHIMBAŢI PAROLA';
  String get confirmpassword => 'Confirmă parola';
  String get resetpass_description =>
      'Introduceți o nouă parolă și confirmați.';
  String get resetpassword => 'Reseteaza parola';
  String get currentpassword => 'Parola actuală';
  String get enteryourcurrentpassword => 'Introduceti parola curenta';
  String get newpassword => 'Parolă Nouă';
  String get enteryournewpassword => 'Introduceți noua parolă';
  String get confirmnewpassword => 'Confirmă noua parolă';
  String get repeatyournewpassword => 'Repetați noua parolă';
  String get haveInvite => 'Ai un cod de invitatie?';
  String get inviteCode => 'Cod de invitație';
  String get inputCode => 'Vă rugăm să introduceți codul de invitație';
  String get name => 'Nume';
  String get inputName => 'Vă rugăm să introduceți numele dvs. complet';
  String get workType => "Sunt Expert, caut clienti.";
  String get hireType => "Sunt Client.";

  //Settings page
  String get lab_settings => "Setări";
  String get labelSelectLanguage => "Selecteaza limba";
  String get labelLanguage => "Limba";
  String get lab_colorstyle => 'Stilul de culoare';
  String get lab_changepassword => 'Schimbaţi parola';
  String get delete_account => "Sterge Account";

  //accountsetting page
  String get addproduct => 'Adăugați Serviciu';
  String get offersandpromos => 'Oferte și promoții';
  String get payments => 'Plăți';
  String get FAQ => 'FAQ';
  String get paymentshistory => 'Istoricul plăților';
  String get myproducts => 'Serviciile mele';
  String get notificaiton => 'Notificări';
  String get mysales => 'Vânzările mele';
  String get myorders => 'Comenzile mele';
  String get favorites => 'Favorite';
  String get signout => 'Deconecteaza-te';
  String get fromCamera => "De la Camera";
  String get fromFiles => "Din Files";
  String get switchToHire => "Schimba in Client";
  String get switchToWorker => "Schimba in Provider";
  //Chatting room
  String get conversations => 'Conversații';
  String get nochattingroom => 'Nu există încă camere de chat';
  String get gohomepage => 'Accesați pagina principală';
  String get goBrowserPage => "Răsfoiți job";
  String get cancel_btn => 'Anulare';
  String get delete_btn => 'Șterge';
  String get areyousure => 'Esti sigur ?';
  String get delete_description => 'Această cameră va fi ștearsă definitiv.';
  String get archiveroom => 'Arhivați această cameră';
  String get deleteroom => 'Șterge această cameră';

  //add product
  String get title => 'TITLU';
  String get description => 'DESCRIERE';
  String get price => 'PREȚ';
  String get next_btn => 'URMĂTORUL';

  //file
  String get publish_btn => 'PUBLICA';
  String get backtohome => 'Înapoi acasă.';
  String get copyClipboard => 'Copiat în Clipboard!';

  //add or remove product
  String get deleteImage => "Această imagine va fi ștearsă.";

  //here is the new languages for local service app

  //browse request
  String get searchRequest => 'Căutați o cerere';
  String get searchCategory => 'Căutați o categorie';
  String get new_tab => 'Nou';
  String get active => 'Activ';
  String get previous => 'Precedent';
  String get all => 'Toate';
  String get noItems => 'Nu există articole.';
  String get totalProposal => 'Propuneri';
  String get selectedServices => ' serviciile selectate';
  String get selectedCities => ' orașele selectate';
  String get depositCoins => ' Incarca acum';
  String get requireCreditsDescription =>
      "Pentru a vedea cerintele clientilor, trebuie sa ai macar 1 credit in contul aplicatiei.";
  String get credits => "Credite";
  //chat view
  String get unnamed => 'Fără nume';

  //validation text

  String get integeronly => "Vă rugăm să introduceți doar numere";
  String get filedMandatory => "Acest câmp este obligatoriu";

  //hirestep 01
  String get serviceCall => "Furnizorul de servicii poate suna";
  String get heading_request => 'Care sunt detaliile?';
  String get valid_question1 => "Detalii pe care le vezi relevante?";
  String get valid_question2 =>
      'Dacă nu furnizați suficiente informații, macar 100 de caractere, acest lucru va afecta numărul de oferte pe care le veți primi.';
  String get valid_question3 =>
      "Trebuie să introduceți cel puțin 100 de litere.";
  String get image_question => 'Doriți să adăugați fotografii?';
  String get where_location => 'Unde este ? (La locul de muncă)';
  String get location_validation =>
      'Nu vă putem folosi locația. Vă rugăm să căutați orașul sau introduceți manual';
  String get userMyLocation => 'FOLOSESTE LOCATIA MEA';
  String get enterCity => 'Introduceți numele orașului dvs';
  String get when_job => 'Cand ? (data de lucru)';
  String get answer_question => 'Vrei să răspunzi la aceste întrebări?';
  String get inputAnswer => 'Introdu raspunsul tau aici...';
  String get enterPhone => 'Introduceți telefonul dvs';
  String get phoneDescription =>
      'Profesioniștii noștri vă vor contacta mai repede dacă selectați "Contacteaza-ma la telefon”.';
  String get enterPhoneNumber => 'Introdu numarul tau de telefon';
  String get sendRequest => 'TRIMITE CEREREA';
  String get alert_image => "Încărcați cel puțin o imagine.";
  String get alert_description => 'Introduceți o descriere.';
  String get alert_address => 'Introdu adresa ta.';
  String get alert_one_option => 'Selecteaza o optiune.';
  String get alert_pick_date => 'Vă rugăm să ridicați data.';
  String get alert_answer => "Vă rugăm să răspundeți la întrebare";
  String get alert_phone => 'Introdu numarul tau de telefon.';
  String get request_success_msg => 'Felicitari! Ați solicitat cu succes!';
  String get alert_close_description =>
      'Puteți obține oferte gratuite răspunzând la câteva întrebări suplimentare.';
  String get go_on => 'CONTINUA';
  String get quit => 'IEȘI';
  String get servicesCompanyReady => "Firma de servicii gata";
  String get allow_contacts => "Arată numărul de telefon";
  String get dont_disturbme => "Nu mă deranja";
  String get only_phone => "Contacteaza-ma doar la telefon";
  String get only_offers => "Contacteaza-ma doar la telefon";
  String get only_whatsapp => "Contacteaza-ma doar pe whatsapp";

  //hire step 02
  String get alert_nocity => 'Din pacate nu gasim orasul ce il doresti...';
  String get what_looking => 'ce cauti';
  String get select_service => 'Selectați tipul de serviciu';
  String get remove_service => 'Eliminați acest serviciu';
  String get request_quote => 'Solicitați 7 estimări gratuite pentru';
  String get name_company => 'Nume și prenume (sau companie)';
  String get phone => 'Telefon';
  String get search_city => 'Caută un oraș (Introduceți cel puțin 3 litere)';
  String get input_3 => 'Introduceți cel puțin 3 litere pentru a căuta orașul';
  String get when_service => 'Când aveți nevoie de acest serviciu';
  String get asap => 'Cât mai repede posibil';
  String get flexible => 'Sunt flexibil';
  String get alert_name => 'Introduceți numele și prenumele dvs';
  String get alert_city => 'Selectați orașul';
  String get request_success => 'Solicitare reușită';
  String get tip_id => 'ID';
  String get success_thankyou =>
      'Vă mulțumim că ați ales serviciul nostru și vă putem ajuta cu nevoile dumneavoastră';

  //home page
  String get hi => 'Bună';
  String get home_description =>
      'Răsfoiți numărul de experți pentru a vă rezolva nevoile. Incepe chiar acum.';
  String get which_service => 'De ce servicii ai nevoie?';
  String get no_service => 'Fără Servicii';

  // job detail
  String get no_city_info => "Nicio informație asupra orașului";
  String get see_number => 'Deblocheaza si vezi numărul';
  String get job_detail => 'Detalii job';
  String get aboutCustomer => "Despre Client";
  String get receivedOffers => " Oferte primite";
  String get noOffers => "Fara Oferte";
  String get reviews => "REVIZUIRE";
  String get beFirstSend => "Fii primul care trimite o ofertă";

  //my account setting
  String get become_seller => 'Deveniți vânzător';

  //my job offer
  String get job_offer => 'Oferte de munca';
  String get deadline => 'Termen limita';
  String get Price => 'Preț';
  String get no_proposal => 'Nu există încă propuneri.';
  String get update_offer => "actualizare oferta";

  //my job
  String get ACTIVE => 'ACTIVE';
  String get CANCELED => 'FINALIZATE';
  String get Cancelled => 'Anulat';
  String get my_jobs => 'Joburile mele';
  String get card_onway =>
      'Ofertele sunt pe drum! Vă vom anunța când primiți o ofertă.';
  String get view_offer => 'Vezi oferte';
  String get see_details => 'VEZI DETALII';
  String get cancel_request => 'ANULEAZĂ CEREREA';

  //my request
  String get my_requests => 'Cererile mele';

  //order and pay
  String get oerder_pay => 'Comanda si plateste';
  String get company_info => 'Informatiile Companiei';
  String get payment_method => 'Modalitate de plată';
  String get credit_card => 'Card de credit sau debit';
  String get payment_bank => 'Plata prin transfer bancar';
  String get request_10 => '10 cereri';
  String get subscription_desc =>
      '400 lei 360 lei/luna pentru 2 luni apoi 400 lei/luna';
  String get paynow_01 => 'Plata acum (prima luna): 428,40 lei (TVA inclus)';
  String get agree => 'Sunt de acord cu';
  String get terms_service => 'Termenii și condițiile';
  String get payNow => 'PLĂTEȘTE ACUM';
  String get name_company_02 => 'Numele dvs. sau numele companiei';
  String get city => 'Oraș';
  String get address => 'Adresa';

  //splash
  String get send_splash => 'Trimite o cerere';
  String get receive_splash => 'Primiți până la 7 oferte';
  String get choose_splash => 'Alege expertul';

  //subscription
  String get choose_monthly => 'Alegeți abonamentul lunar';
  String get sub_01 => '400 lei 360 lei/luna pentru 2 luni apoi 400 lei/luna';
  String get on_average1 => 'În medie, vei concura cu 3 profesioniști.';
  String get no_contract => 'Fără perioadă de contract, puteți anula oricând';
  String get request_20 => '20 de cereri';
  String get sub_02 => '800 lei 480 lei/luna pentru 2 luni apoi 800 lei/luna';
  String get on_average2 => 'În medie, vei concura cu 3 profesioniști.';
  String get request_35 => '35 de cereri';
  String get on_average3 => 'În medie, vei concura cu 2 profesioniști.';
  String get on_average4 =>
      'Prețul mediu pe cerere este între 31,65 lei și 47,47 lei.';
  String get calc_description =>
      '*Numărul de cereri este orientativ și se calculează pe baza prețului mediu pe cerere. Preturile sunt detaliate in lista de preturi.';

  //view service
  String get get_7 => 'Obțineți 7 cotații';

  //work step 1
  String get step1_des => 'Ce servicii oferiți?';
  String get eliminate => 'Elimina';
  String get step1_heading => 'Ce servicii oferiți?';
  String get change_anytime => 'Puteți schimba acest lucru în orice moment.';
  String get selected_service => 'Servicii selectate';
  String get alert_select_service =>
      'Vă rugăm să selectați serviciul din lista de mai jos pentru următorul pas!';

  //work step 2
  String get step2_heading => 'Ce tip de muncă te interesează?';

  //work step 3
  String get step3_heading => 'În ce oraș(e) lucrezi ca';
  String get selected_city => 'Orașele selectate';
  String get alert_select_city =>
      'Ar trebui să selectați orașul pentru pasul următor';

  //country page
  String get ro => 'România';
  String get de => 'Germania';
  String get sp => 'Spania';
  String get fr => 'Franţa';
  String get it => 'Italia';
  String get start => 'start';

  //missing
  String get selectCategory => 'SELECTEAZA CATEGORIA';
  String get filters => 'Filtre';
  String get priority => 'PRIORITATE';
  String get search => 'Căutare';
  String get category => 'CATEGORIE';

  String get buyCredits => 'Cumpărați credite';
  String get countryHeading => 'Vă rugăm să selectați țara dvs';
  String get creditHistory => 'Istoricul creditului';
  String get ID => 'ID';
  String get amount => 'Cantitate';
  String get date => 'Data';
  String get noCredit => 'Fără istoric de credit';
  String get Congratulation => 'Felicitari';
  String get requestPriority => 'Cerere Prioritate';
  String get acceptPolicy =>
      'Accept utilizatorul și acordul de confidențialitate apăsând pe "TRIMITERE CERERE”';
  String get willNotify =>
      'Vă vom anunța prin e-mail,sms si notificare atunci când solicitarea dvs. primește cotații de la profesioniști.';
  String get receivedRequest => 'Am primit cererea ta!';
  String get free => 'Liber';
  String get priceCoins => 'PRET MONEDE';
  String get type => 'TIP';
  String get planSelect =>
      'Alegeți-vă planul de plată în funcție de viteza cu care trebuie să găsiți experți.';
  String get canceledRequest => 'Ați anulat această solicitare!';
  String get reasonSelect =>
      'Vă rugăm să selectați unul dintre motivele de mai jos.';
  String get reason_1 => 'Sunt de acord cu o ofertă în afara acestui site web.';
  String get reason_2 => 'Tarifele sunt prea mari.';
  String get reason_3 => 'Nu sunt sigur de calitate.';
  String get reason_4 => 'Nu sunt suficiente oferte.';
  String get reason_5 => 'Nu am putut obține oferte la nevoile mele.';
  String get reason_6 => 'Numai am nevoie de acest serviciu';
  String get unlockedReq => 'Ai deblocat această solicitare!';
  String get sureUnlock =>
      'Sunteți sigur că doriti sa deblocati această solicitare?';
  String get activeStatus => 'Stare: ACTIV';
  String get offers => 'PROMOȚII';
  String get viewOffers => 'VEZI OFERTE';
  String get jobID => 'ID JOB';
  String get unlockReq => 'Solicitare de deblocare';
  String get sendOffer => 'Trimite oferta';

  //my account
  String get myaccount => 'Contul meu';
  String get myDetails => 'Detaliile mele';
  String get successUpdated => 'Actualizat cu succes!';
  String get imageSelectAlert => 'Imaginea nu este selectată';
  String get coins => 'de monede';
  String get myOffers => 'Ofertele mele';
  String get myservices => 'Serviciile mele';
  String get offer => 'OFERĂ';
  String get noJobs => 'NU AVETI SOLICITARI';
  String get noRequestDesc =>
      'Nu aveți nicio cerinta solicitata.\nSolicitați serviciul dorit, obțineți oferte gratuite!';

  String get browseServices => 'CAUTA SERVICII';
  String get c_reason_1 => 'M-am răzgândit cu privire la serviciu.';
  String get c_reason_2 => 'Sunt ocupat cu alte treburi.';
  String get c_reason_3 => 'Nu-mi place clientul';
  String get c_reason_4 => 'Nu am timp pentru alti clienti.';
  String get c_reason_5 => 'Fara motiv.';
  String get cancelOffer => 'Anulează oferta';
  String get pauseReq => 'CERERE DE PAUZĂ';
  String get cancelledOffer => 'Ați anulat această ofertă!';
  String get startFrom => 'ÎNCEPE DE LA';
  String get save => "Salva";

  String get services => 'Servicii';
  String get cities => 'Orase';
  String get noService => 'Fara Servicii!';
  String get noServicesDesc =>
      'Nu aveți încă niciun serviciu.\nVă rugăm să adăugați servicii dacă doriți să începeți să câștigați.';
  String get noCity => 'Fără orașe!';
  String get noCityDesc =>
      'Nu aveți încă niciun oraș.\nVă rugăm să adăugați orașe dacă doriți să începeți să câștigați.';
  String get addService => 'Adăugați serviciu';
  String get searchService => 'Serviciu de căutare';
  String get myServices => 'Serviciile mele';
  String get myCities => 'Orașele mele';
  String get addCity => 'Adăugați orașul';
  String get searchCity => 'Caută oraș';

  String get newOffer => 'Ofertă nouă';
  String get offerType => 'TIP OFERTA';
  String get offerDescriptionHint =>
      'Aratai Clientului ca iai inteles nevoile. Fa o oferta personalizata. Spune-i ce vei face si de ce e important pentru el.';
  String get sentOffer => 'Ai trimis oferta!';
  String get updatedOffer => 'Ai actualizat oferta!';
  String get noNotification => 'Nicio notificare!';
  String get notificationDesc =>
      'Nu ai încă nicio notificare. Vă rugăm să plasați comanda';

  String get creditCard => 'Card de credit';
  String get bank => 'bancă';
  String get proposalReq => 'Cerere de propuneri';

  String get BECOME_SELLER => 'DEVINO VANZATOR';
  String get verifyCode => 'Cod de verificare';
  String get codeVerifyDesc =>
      'Vă trimitem un cod de verificare. Verificați-vă căsuța de e-mail pentru a le primi.';
  String get resend_code => 'Retrimite codul';
  String get avg_rating => 'rata medie';
  String get verify_review => 'recenzii verificate';

  String get noSearchResult => 'Niciun rezultat al căutării';
  String get inputThree => 'Vă rugăm să introduceți cel puțin 3 litere';

  String get nojobreq => 'Nicio cerere de locuri de muncă.';
  String get nojobreq_des =>
      'Nicio cerere de locuri de muncă pentru serviciile dvs. Vă vom trimite notificări când apar noi solicitări pentru serviciile dvs.';

  String get serviceReady => 'Firma de servicii gata';
  String get everyear => 'In fiecare an';
  String get peopleTrust => 'oamenii au încredere în Serviciile locale pentru';

  //redeem code section
  String get redeemVoucher => 'Răscumpărați VOUCHER';
  String get redeemAction => 'Acest cod va fi aplicat contului dvs.';
  String get codeInvaild => 'Codul introdus nu este valid.';
  String get couponSuccess =>
      'Codul de cupon aplicat cu succes în contul dumneavoastră.';
  String get cousherCode => 'Codul pentru tine';
  String get tryAgain => 'ÎNCEARCĂ DIN NOU';
  String get addNew => 'ADĂUGA NOU';
  String get addBtn => 'ADĂUGA';

  String get apply => 'APLICA';
  String get haveRedeemCode => 'Aveți un cod de răscumpărare?';
  String get paymentMethod => 'Modalitate de plată';

  String get specificTime => 'Timp specific (în termen de trei săptămâni)';
  String get inTwoMonth => 'În două luni';
  String get inSixMonth => 'În șase luni';
  String get onlyPrice => 'Caut doar pretul';
  String get flexibleTime => 'Flexibil';
  String get allContact => 'Permite Contacte';
  String get onlyOffers => 'Doar Oferte';
  String get onlyPhone => 'Doar Telefon';
  String get onlyWhatsapp => 'Doar WhatsApp';
  String get notDisturb => 'Nu mă deranja';

  String get processing => "prelucrare";
  String get thankyou => "Mulțumesc";
  //become a seller
  String get companyNameHint => 'Numele companiei sau numele personal';
  String get companyNumberHint => 'Numărul companiei sau numărul personal';
  String get profileDescriptionHint => "Descrierea profilului";
  String get companyNameValidateError =>
      "Vă rugăm să introduceți numele companiei sau personalului";
  String get companyNumberValidateError =>
      "Vă rugăm să introduceți numărul de companie sau personal";
  String get profileDescriptionValidateError =>
      "Vă rugăm să introduceți Descrierea profilului";
  String get addressValidateError => "Vă rugăm să introduceți adresa";
  String get phoneValidateError => "Vă rugăm să introduceți numărul de telefon";
  String get optional => "(OPȚIONAL)";
  String get becomeSellerApproved =>
      "A fost depusă cererea dumneavoastră de a deveni vânzător.";
  String get private => "PRIVAT";
  String get company => "COMPANIE";
  String get close => "ÎNCHIDE";

  //other
  String get call => "APEL";
  String get skip => "OCOLIRE";
  String get chat => "CONVERSAȚIE";
  String get seeAll => "VEZI TOATE";
  String get award => "ADJUDECARE";
  String get noPhoneNumber => "Utilizator nu are număr de telefon.";
  String get about => "Despre";
  String get photos => "Fotografii";
  String get feedBacks => "Feedback-uri";
  String get contact => "a lua legatura";
  String get favorite => "Favorit";
  String get share => "Distribuie";
  String get clientMode => "Modul client";
  String get providerMode => "Modul furnizor";
  String get addButton => "Adăuga";
  String get backButton => "Înapoi";
  String get addSucceed => "Adăugat cu succes";
  // write review
  String get howWasService => "Cum a fost serviciul primit? \nEști mulțumit?";
  String get writeReview => "Scrie o recenzie";
  String get keepMeReviewHidden => "Ține recenzia mea ascunsă";
  String get inputReviewError => "Vă rugăm să introduceți recenzia dvs";
  String get reviewedSuccess => "Ați evaluat cu succes";

  String get pleaseSelectReason =>
      "Vă rugăm să selectați unul dintre motivele de mai jos.";
  String get confirm => "A confirma";
  String get cancelRequestReason1 =>
      "Sunt de acord cu o ofertă în afara acestui site web.";
  String get cancelRequestReason2 => "Tarifele sunt prea mari.";
  String get cancelRequestReason3 => "Nu sunt sigur de calitate.";
  String get cancelRequestReason4 => "Nu sunt suficiente oferte.";
  String get cancelRequestReason5 =>
      "Nu am putut obține răspunsuri la întrebările mele.";
  String get cancelRequestReason6 =>
      "Niciun șezlong nu am nevoie de acest serviciu";
  String get minute => 'minut';
  String get minutes => 'minute';
  String get day => ' zi';
  String get days => ' zile';
  String get month => 'lună';
  String get months => 'luni';
  String get hour => "ora";
  String get hours => "ore";
  String get ago => 'în urmă';
  String get headStringRegistered => 'Înregistrat acum ';
  String get tailStringRegistered => '';
  String get high => "înalt";
  String get iWant => "Vreau";
  String get total => "total";
  String get availableFrom => "Disponibil de la";
  String get deadLineHint => 'in 5 zile';

  //chat widget
  String get typing => 'tastare';
  String get online => 'pe net';
  String get offline => 'deconectat';
  String get connecting => 'Conectare';
  String get joinRoom => 'Alăturați-vă din nou';
  String get hintTextMessage => "mesaj";
  String get fullScreen => "Ecran complet";
  String get noOffersDesc =>
      "Nu ai inca nici o oferta. Dute la pagina de solicitari si trimite oferte la cererile clientilor";
}
