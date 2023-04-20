import 'languages.dart';

class LanguageIt extends Languages {
  // @override
  String get appName => "LocalService";
// error

  String get kEmailNullError => "Inserisci la tua email";
  String get kInvalidEmailError => "Perfavore Inserisci un'email valida";
  String get kPassNullError => "Per favore inserisci LA TUA password";
  String get kConfirmPasswordError => "Mancata corrispondenza della password";
  String get kShortPassError =>
      "La password è troppo corta, almeno 8 caratteri";
  String get kMatchPassError => "Le password non corrispondono";
  String get kNameNullError => "Inserisci il tuo nome e cognome";
  String get kPhoneNumberNullError =>
      "Per favore immetti il ​​tuo numero di telefono";
  String get kAddressNullError => "Inserisci il tuo indirizzo";
  String get kTitleNullError => "Inserisci il titolo del tuo prodotto";
  String get kDescriptionNullError => "Si prega di inserire la descrizione";
  String get kPriceNullError => "Si prega di inserire il prezzo";
  String get kDeadLineNullError => "Si prega di inserire la scadenza";

  //Splash screen, sign in, sign out, reset, etc - first screens
  String get slogan => 'Fino a 7 preventivi con 1 richiesta!';
  String get lab_continue => 'Continua';
  String get signin => 'Login';
  String get signup => 'Registrazione';
  String get createaccount => 'Creare un profilo';
  String get forgotpassword => 'Ha dimenticato la password';
  String get email => 'E-mail';
  String get password => "Password";
  String get pleaseendteryouremail => 'Per favore inserisci la tua email';
  String get pleaseenteryourpassword => 'per favore inserisci LA TUA password';
  String get forgotpassword_description =>
      'Inserisci il tuo indirizzo email. Riceverai un link per creare una nuova password via e-mail.';
  String get lab_send => 'INVIARE';
  String get changepassword => 'CAMBIA LA PASSWORD';
  String get confirmpassword => 'Conferma password';
  String get resetpass_description =>
      'Immettere la nuova password e confermare.';
  String get resetpassword => 'Resetta la password';
  String get currentpassword => 'Password attuale';
  String get enteryourcurrentpassword => 'Inserisci la tua password attuale';
  String get newpassword => 'Nuova password';
  String get enteryournewpassword => 'Inserisci la tua nuova password';
  String get confirmnewpassword => 'Conferma la nuova password';
  String get repeatyournewpassword => 'Ripeti la tua nuova password';
  String get haveInvite => 'Hai un codice di invito?';
  String get inviteCode => 'Codice di invito';
  String get inputCode => 'Inserisci il tuo codice di invito';
  String get name => 'Nome';
  String get inputName => 'Per favore inserisci il tuo nome completo';
  String get workType => "Professionista";
  String get hireType => "Cliente";

  //Settings page
  String get lab_settings => "Impostazioni";
  String get labelSelectLanguage => "Seleziona la lingua";
  String get labelLanguage => "Lingua";
  String get lab_colorstyle => 'Stile di colore';
  String get lab_changepassword => 'Cambia la password';
  String get delete_account => "Eliminare l'account";

  //accountsetting page
  String get addproduct => 'Aggiungi servizio';
  String get offersandpromos => 'Offerte e promozioni';
  String get payments => 'Pagamenti';
  String get FAQ => 'FAQ';
  String get paymentshistory => 'Cronologia pagamenti';
  String get myproducts => 'I miei servizi';
  String get notificaiton => 'Notifiche';
  String get mysales => 'Le mie vendite';
  String get myorders => 'i miei ordini';
  String get favorites => 'Preferiti';
  String get signout => 'Disconnessione';
  String get fromCamera => "Dalla fotocamera";
  String get fromFiles => "Da File";
  String get switchToHire => "Passa al Cliente";
  String get switchToWorker => "Passa al Professionista";

  //chatting room
  String get conversations => 'Conversazioni';
  String get nochattingroom => 'Ancora nessuna chat room';
  String get gohomepage => 'Vai alla home page';
  String get goBrowserPage => "Sfoglia lavoro";
  String get cancel_btn => 'Annulla';
  String get delete_btn => 'Elimina';
  String get areyousure => 'Sei sicuro ?';
  String get delete_description =>
      'Questa stanza verrà eliminata definitivamente.';
  String get archiveroom => 'Archivia questa stanza';
  String get deleteroom => 'Elimina questa stanza';

  //add product
  String get title => 'TITOLO';
  String get description => 'DESCRIZIONE';
  String get price => 'PREZZO';
  String get next_btn => 'PROSSIMO';

  //file
  String get publish_btn => 'PUBBLICARE';
  String get backtohome => 'Torna alla home';
  String get copyClipboard => 'Copiato negli Appunti!';

  //add or remove product
  String get deleteImage => 'Questa immagine verrà eliminata.';

  //here is the new languages for local service app

  //browse request
  String get searchRequest => 'Cerca una richiesta';
  String get searchCategory => 'Cerca una categoria';
  String get new_tab => 'Nuova';
  String get active => 'Attivo';
  String get previous => 'Precedente';
  String get all => 'Tutto';
  String get noItems => 'Non ci sono articoli.';
  String get totalProposal => 'Proposta totale';
  String get selectedServices => ' servizi selezionati';
  String get selectedCities => ' città selezionate';
  //chat view
  String get unnamed => 'Senza nome';
  String get depositCoins => 'Deposita ora';
  String get requireCreditsDescription =>
      "Per poter vedere le richieste dei clienti, devi avere almeno 1 credito nel tuo account.";
  String get credits => "Crediti";

  //validation text

  String get integeronly => "Si prega di inserire solo numeri interi";
  String get filedMandatory => "Questo campo è obbligatorio";

  //hirestep 01
  String get serviceCall => 'Il fornitore di servizi può chiamare';
  String get heading_request =>
      'Quali sono i dettagli della tua richiesta di lavoro?';
  String get valid_question1 => 'Scrivi qui piu detagli possibili';
  String get valid_question2 =>
      'Se non fornisci informazioni sufficienti,almeno 100 caratteri, questo influirà sul numero di preventivi che riceverai.';
  String get valid_question3 => 'Dovresti inserire almeno 100 lettere.';
  String get image_question => 'Vuoi aggiungere immagini?';
  String get where_location => 'Dove ? (Luogo di lavoro)';
  String get location_validation =>
      'Non possiamo usare la tua posizione. Si prega di cercare la città o inserirla manualmente';
  String get userMyLocation => 'USA LA MIA POSIZIONE';
  String get enterCity => 'Inserisci il nome della tua città';
  String get when_job => 'Quando ? (data del lavoro)';
  String get answer_question => 'Vuoi rispondere a queste domande?';
  String get inputAnswer => 'Inserisci qui la tua risposta...';
  String get enterPhone => 'Inserisci il tuo telefono';
  String get phoneDescription =>
      'I nostri professionisti possono contattarti più velocemente se selezioni "Contattami al telefono".';
  String get enterPhoneNumber => 'Inserisci il tuo numero di telefono';
  String get sendRequest => 'INVIA RICHIESTA';
  String get alert_image => 'Carica almeno un\'immagine.';
  String get alert_description => 'Inserisci la descrizione.';
  String get alert_address => 'Inserisci il tuo indirizzo.';
  String get alert_one_option => 'Seleziona un\'opzione.';
  String get alert_pick_date => 'Si prega di data di ritiro.';
  String get alert_answer => "Per favore, rispondi alla domanda";
  String get alert_phone => 'Inserisci il numero di telefono.';
  String get request_success_msg =>
      'Congratulazioni! Hai inoltrato la tua richiesta con successo!';
  String get alert_close_description =>
      'Puoi ottenere preventivi gratuiti rispondendo a poche altre domande.';
  String get go_on => 'CONTINUA';
  String get quit => 'USCIRE';
  String get servicesCompanyReady => "Società di servizi pronta";
  String get allow_contacts => "Mostra il mio numero di telefono";
  String get dont_disturbme => "Non disturbarmi";
  String get only_phone => "Contattami solo telefonicamente";
  String get only_offers => "Inviami solo offerte";
  String get only_whatsapp => "Contattami solo tramite whatsapp";

  //hire step 02
  String get alert_nocity =>
      'Spiacente ma non riusciamo a trovare la città che desideri...';
  String get what_looking => 'Che cosa sta cercando';
  String get select_service => 'Seleziona il tipo di servizio';
  String get remove_service => 'Rimuovi questo servizio';
  String get request_quote => 'Richiedi 7 preventivi gratuiti per';
  String get name_company => 'Nome e cognome (o azienda)';
  String get phone => 'Telefono';
  String get search_city => 'Cerca una città (Inserisci almeno 3 lettere)';
  String get input_3 => 'Inserisci almeno 3 lettere per cercare la città';
  String get when_service => 'Quando hai bisogno di questo servizio';
  String get asap => 'Appena possibile';
  String get flexible => 'Sono flessibile';
  String get alert_name => 'Inserisci nome e cognome';
  String get alert_city => 'Seleziona città';
  String get request_success => 'Richiesta andata a buon fine';
  String get tip_id => 'ID mancia';
  String get success_thankyou =>
      'Grazie per aver scelto il nostro servizio e della fiducia per aiutarti con i tuoi problemi';

  //home page
  String get hi => 'Ciao';
  String get home_description =>
      'Sfoglia il numero di esperti per risolvere i tuoi problemi. inizia subito la consulenza';
  String get which_service => 'Di quali servizi hai bisogno?';
  String get no_service => "Nessun servizio";

  // job detail
  String get no_city_info => "Nessuna informazione sulla città";
  String get see_number => "Sblocca per vedere e chiamare il mio numero";
  String get job_detail => 'Dettagli di lavoro';

  String get aboutCustomer => "Informazioni sul cliente";
  String get receivedOffers => " Offerte ricevute";
  String get noOffers => "Nessuna offerta";
  String get reviews => "REVISIONE";
  String get beFirstSend => "Sii il primo a inviare un'offerta";

  //my account setting
  String get become_seller => "Diventa un venditore";

  //my job offer
  String get job_offer => 'Offerte di lavoro';
  String get deadline => 'Scadenza';
  String get Price => 'Prezzo';
  String get no_proposal => "Non ci sono ancora proposte.";
  String get update_offer => "offerta di aggiornamento";

  //my job
  String get ACTIVE => 'ATTIVO';
  String get CANCELED => 'ANNULLATO';
  String get Cancelled => 'Annullato';
  String get my_jobs => "I miei lavori";
  String get card_onway =>
      'Le quotazioni sono in arrivo! Ti faremo sapere quando riceveremo un preventivo.';
  String get view_offer => 'Visualizza offerte';
  String get see_details => 'GUARDA I DETAGLI';
  String get cancel_request => 'RICHIESTA CANCELLATA';

  //my request
  String get my_requests => "Le mie richieste";

  //order and pay
  String get oerder_pay => 'Ordina e paga';
  String get company_info => 'Informazioni sull\'azienda';
  String get payment_method => 'Metodo di pagamento';
  String get credit_card => "Carta di credito o di debito";
  String get payment_bank => 'Pagamento tramite bonifico bancario';
  String get request_10 => '10 richieste';
  String get subscription_desc =>
      '100 eur 75 euro/mese per 2 mesi poi 100 euro/mese';
  String get paynow_01 => 'Paga ora (primo mese): 110,40 euro (IVA inclusa)';
  String get agree => 'Sono d\'accordo con';
  String get terms_service => 'Termenii și condițiile';
  String get payNow => 'PAGA ORA';
  String get name_company_02 => "Il tuo nome o il nome dell'azienda";
  String get city => 'Città';
  String get address => 'Indirizzo';

  //splash
  String get send_splash => 'Invia una richiesta';
  String get receive_splash => 'Ricevi fino a 7 offerte';
  String get choose_splash => 'Scegli l\'esperto';

  //subscription
  String get choose_monthly => 'Scegli abbonamento mensile';
  String get sub_01 => '100 euro 75 euro/mese per 2 mesi poi 100 euro/mese';
  String get on_average1 => 'In media, avrai 3 competitor.';
  String get no_contract =>
      "Nessun periodo di contratto, puoi disdire in qualsiasi momento";
  String get request_20 => '20 richieste';
  String get sub_02 => '200 euro 170 euro/mese per 2 mesi poi 200 euro/mese';
  String get on_average2 => 'In media, avrai 3 competitor.';
  String get request_35 => '35 richieste';
  String get on_average3 => 'In media, avrai 2 competitor.';
  String get on_average4 =>
      'Il prezzo medio per richiesta è compreso tra 8 euro e 10 lei.';
  String get calc_description =>
      '*Il numero di richieste è indicativo e viene calcolato sulla base del prezzo medio per richiesta. I prezzi sono dettagliati nel listino prezzi.';

  //view service
  String get get_7 => 'Ottieni 7 preventivi';

  //work step 1
  String get step1_des => 'Quali servizi offrite?';
  String get eliminate => 'Eliminare';
  String get step1_heading => "Quali servizi offrite?";
  String get change_anytime => 'Puoi cambiarlo in qualsiasi momento.';
  String get selected_service => 'Servizi selezionati';
  String get alert_select_service =>
      'Seleziona il servizio dall\'elenco sottostante per il passaggio successivo!';

  //work step 2
  String get step2_heading => 'Che tipo di lavoro ti interessa?';

  //work step 3
  String get step3_heading => 'In quale città lavori come';
  String get selected_city => 'Città/e selezionate';
  String get alert_select_city =>
      "Dovresti selezionare la città per il passaggio successivo";

  //country page
  String get ro => 'Romania';
  String get de => 'Germania';
  String get sp => 'Spagna';
  String get fr => 'Francia';
  String get it => 'Italia';
  String get start => 'Inizio';

  //missing
  String get selectCategory => 'SELEZIONA CATEGORIA';
  String get filters => 'Filtri';
  String get priority => 'PRIORITA';
  String get search => 'Cerca';
  String get category => 'CATEGORIA';

  String get buyCredits => 'Compra Crediti';
  String get countryHeading => 'Seleziona il paese';
  String get creditHistory => 'Cronologia Crediti ';
  String get ID => 'ID';
  String get amount => 'Quantità';
  String get date => 'Data';
  String get noCredit => 'Nessun cronologia di crediti';
  String get Congratulation => 'Congratulazioni';
  String get requestPriority => 'Richiedi Priorita';
  String get acceptPolicy =>
      'Accetto la politica dell utente e privacy premendo “INVIA RICHIESTA”';
  String get willNotify =>
      'Ti invieremo notifiche per email e sms quando la tua richiesta riceverà preventivi dai professionisti.';
  String get receivedRequest => 'Abbiamo ricevuto la tua richiesta!';
  String get free => 'Gratis';
  String get priceCoins => 'PREZZO CREDITI';
  String get type => 'TYPE';
  String get planSelect =>
      'Scegli il tuo piano di pagamento in concordanza con l\'urgenza che hai nel trovare esperti.';
  String get canceledRequest => 'Hai cancellato questa richiesta!';
  String get reasonSelect => 'Prego, scegliere una delle seguenti opzioni.';
  String get reason_1 =>
      'Do il mio consenso per un offerta esterna all\' sito.';
  String get reason_2 => 'I preventivi sono troppo alti.';
  String get reason_3 => 'Non sono sicuro della qualità.';
  String get reason_4 => 'Non abbastanza preventivi.';
  String get reason_5 => 'Non ho ricevuto preventivi per la mia richiesta.';
  String get reason_6 => 'Non ho piu bisogno di questo servizio';
  String get unlockedReq => 'Hai sbloccato questa richiesta!';
  String get sureUnlock => '>Sei sicuro di sbloccare questa richiesta?';
  String get activeStatus => 'Stato: ATTIVO';
  String get offers => 'OFFERTE';
  String get viewOffers => 'VEDI OFFERTE';
  String get jobID => 'JOB ID';
  String get unlockReq => 'Sblocca richiesta';
  String get sendOffer => 'Invia offerta';

  //my account
  String get myaccount => 'Il mio conto';
  String get myDetails => 'I miei dettagli';
  String get successUpdated => 'Aggiornato con successo!';
  String get imageSelectAlert => 'immagine non selezionata';
  String get coins => 'monete';
  String get myOffers => 'Le mie offerte';
  String get myservices => 'I miei servizi';
  String get offer => 'OFFERTA';
  String get noJobs => 'NON LAVORO QUI';
  String get noRequestDesc =>
      'Non hai nessun lavoro richiesto.\nRichiedi il servizio che desideri, ottieni preventivi gratuiti!';

  String get browseServices => 'SFOGLIA I SERVIZI';
  String get c_reason_1 => 'Ho cambiato idea sul servizio.';
  String get c_reason_2 => 'Sono impegnato con altri lavori.';
  String get c_reason_3 => 'non mi piace il cliente';
  String get c_reason_4 => 'Non ho tempo per altri clienti.';
  String get c_reason_5 => 'Nessuna ragione.';
  String get cancelOffer => 'Annulla offerta';
  String get pauseReq => 'RICHIESTA DI PAUSA';
  String get cancelledOffer => 'Hai annullato questa offerta!';
  String get startFrom => 'INIZIA DA';
  String get save => "Salva";

  String get services => 'Servizi';
  String get cities => 'Città';
  String get noService => 'Nessun servizio!';
  String get noServicesDesc =>
      'Non hai ancora alcun servizio.\nAggiungi servizi se vuoi iniziare a guadagnare.';
  String get noCity => 'Nessuna città!';
  String get noCityDesc =>
      'Non hai ancora nessuna città.\nAggiungi città se vuoi iniziare a guadagnare.';
  String get addService => 'Aggiungi servizio';
  String get searchService => 'Servizio di ricerca';
  String get myServices => 'I miei servizi';
  String get myCities => 'Le mie città';
  String get addCity => 'Aggiungi città';
  String get searchCity => 'Cerca Città';

  String get newOffer => 'Nuova offerta';
  String get offerType => 'TIPO DI OFFERTA';
  String get offerDescriptionHint =>
      "Mostra al cliente che comprendi le sue esigenze. Fai un'offerta speciale. Digli cosa ti rende diverso e perché può fidarsi di te.";
  String get sentOffer => 'Hai inviato un\'offerta!';
  String get updatedOffer => 'Hai aggiornato l\'offerta!';
  String get noNotification => 'Nessuna notifica!';
  String get notificationDesc =>
      'Non hai ancora alcuna notifica. Si prega di effettuare l\'ordine';

  String get creditCard => 'Carta di credito';
  String get bank => 'Banca';
  String get proposalReq => 'Richiesta proposte';

  String get BECOME_SELLER => 'DIVENTA UN VENDITORE';
  String get verifyCode => 'Codice di verifica';
  String get codeVerifyDesc =>
      'Ti abbiamo appena inviato un codice di verifica. Controlla la tua casella di posta per vederlo.';
  String get resend_code => 'Invia nuovamente il codice';
  String get avg_rating => 'voto medio';
  String get verify_review => 'recensioni verificate';

  String get noSearchResult => 'Nessun risultato di ricerca';
  String get inputThree => 'Si prega di inserire almeno 3 lettere';

  String get nojobreq => 'Nessuna richiesta di lavoro.';
  String get nojobreq_des =>
      'Nessuna richiesta di lavoro per i tuoi servizi. Ti invieremo notifiche quando compaiono nuove richieste per i tuoi servizi.';

  String get serviceReady => 'Società di servizi pronta';
  String get everyear => 'Ogni anno';
  String get peopleTrust => 'le persone si affidano a Servizi locali per';

  //redeem code section
  String get redeemVoucher => 'RISCATTARE COUPON';
  String get redeemAction => 'Questo codice verrà applicato al tuo account.';
  String get codeInvaild => 'Il codice inserito non è valido.';
  String get couponSuccess =>
      'Codice coupon applicato correttamente al tuo account.';
  String get cousherCode => 'Codice promozionale';
  String get tryAgain => 'RIPROVA';
  String get addNew => 'AGGIUNGERE NUOVA';
  String get addBtn => 'AGGIUNGERE';
  String get apply => 'FARE DOMANDA A';
  String get haveRedeemCode => 'Hai un codice di riscatto?';
  String get paymentMethod => 'Metodo di pagamento';

  String get specificTime => 'Tempo specifico (entro tre settimane)';
  String get inTwoMonth => 'In due mesi';
  String get inSixMonth => 'Tra sei mesi';
  String get onlyPrice => 'Sto solo cercando un prezzo';
  String get flexibleTime => 'Flessibile';
  String get allContact => 'Consenti contatti';
  String get onlyOffers => 'Solo Offerte';
  String get onlyPhone => 'Solo telefono';
  String get onlyWhatsapp => 'Solo WhatsApp';
  String get notDisturb => 'Non disturbarmi';

  String get processing => "in lavorazione";
  String get thankyou => "Grazie";
  //become a seller
  String get companyNameHint => 'Nome dell\'azienda o nome personale';
  String get companyNumberHint => 'Numero dell\'azienda o numero personale';
  String get profileDescriptionHint => "Descrizione del profilo";
  String get companyNameValidateError =>
      "Si prega di inserire la società o il nome personale";
  String get companyNumberValidateError =>
      "Inserisci il numero dell'azienda o personale";
  String get profileDescriptionValidateError =>
      "Inserisci la descrizione del profilo";
  String get addressValidateError => "Si prega di inserire l'indirizzo";
  String get phoneValidateError => "Si prega di inserire il telefono";
  String get optional => "(OPZIONALE)";
  String get becomeSellerApproved =>
      "La tua domanda per diventare un venditore è stata inviata.";
  String get private => "PRIVATO";
  String get company => "AZIENDA";
  String get close => "CHIUDERE";

  //other
  String get call => "CHIAMATA";
  String get skip => "SALTA";
  String get chat => "CHIACCHIERARE";
  String get seeAll => "VEDI TUTTO";
  String get award => "PREMIO";
  String get noPhoneNumber => "Il Utente non ha il numero di telefono.";
  String get about => "Di";
  String get photos => "Fotografie";
  String get feedBacks => "Feedback";
  String get contact => "Contatto";
  String get favorite => "Preferito";
  String get share => "Condividere";
  String get clientMode => "Modalità cliente";
  String get providerMode => "Modalità fornitore";
  String get addButton => "Aggiungere";
  String get backButton => "Indietro";
  String get addSucceed => "Aggiunto con successo";
  // write review
  String get howWasService =>
      "Com'è stato il servizio che hai ricevuto? \nSei soddisfatto?";
  String get writeReview => "Scrivi la tua recensione";
  String get keepMeReviewHidden => "Tieni nascosta la mia recensione";
  String get inputReviewError => "Inserisci la tua recensione";
  String get reviewedSuccess => "La tua recensione è andata a buon fine";

  String get pleaseSelectReason => "Seleziona uno dei seguenti motivi.";
  String get confirm => "Confermare";
  String get cancelRequestReason1 =>
      "Concordato con un'offerta al di fuori di questo sito web.";
  String get cancelRequestReason2 => "Le tariffe sono alte.";
  String get cancelRequestReason3 => "Non sono sicuro della qualità.";
  String get cancelRequestReason4 => "Offerte insufficienti.";
  String get cancelRequestReason5 =>
      "Impossibile ottenere risposte alle mie domande.";
  String get cancelRequestReason6 => "Non ho bisogno di questo servizio";
  String get minute => 'minuto ';
  String get minutes => 'minuti ';
  String get day => 'giorno ';
  String get days => 'giorni ';
  String get month => 'mese ';
  String get months => 'mesi ';
  String get hour => "ora";
  String get hours => "ore";
  String get ago => 'fa ';
  String get headStringRegistered => 'registrato';
  String get tailStringRegistered => 'fa';
  String get high => "alto";
  String get iWant => "Voglio";
  String get total => "totale";
  String get availableFrom => "Disponibile da";
  String get deadLineHint => 'tra 5 giorni';

  //chat widget
  String get typing => 'digitando';
  String get online => 'in linea';
  String get offline => 'disconnesso';
  String get connecting => 'Collegamento';
  String get joinRoom => 'Unisciti di nuovo';
  String get hintTextMessage => "mensaje";
  String get fullScreen => "Pantalla completa";
  String get noOffersDesc =>
      "Non hai ancora offerte.Vai ora alla pagina delle richieste e invia offerte su richieste dei clienti.";
}
