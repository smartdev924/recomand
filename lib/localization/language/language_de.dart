import 'languages.dart';

class LanguageDe extends Languages {
  // @override
  String get appName => "LocalService";
  // error

  String get kEmailNullError => "Bitte geben Sie ihre E-Mail-Adresse ein";
  String get kInvalidEmailError =>
      "Bitte eine gültige E-Mail-Adresse eintragen";
  String get kPassNullError => "Bitte geben Sie Ihr Passwort ein";
  String get kConfirmPasswordError => "Nicht übereinstimmendes Passwort";
  String get kShortPassError => "Passwort ist zu kurz, mindestens 8 Zeichen";
  String get kMatchPassError => "Passwörter stimmen nicht überein";
  String get kNameNullError => "Bitte tragen Sie Ihren vollen Namen ein";
  String get kPhoneNumberNullError => "Bitte gib deine Telefonnummer ein";
  String get kAddressNullError => "Bitte geben Sie Ihre Adresse ein";
  String get kTitleNullError => "Bitte geben Sie Ihren Produkttitel ein";
  String get kDescriptionNullError => "Bitte Beschreibung eingeben";
  String get kPriceNullError => "Bitte geben Sie den Preis ein";
  String get kDeadLineNullError => "Bitte Frist eingeben";

  //Splash screen, sign in, sign out, reset, etc - first screens
  String get slogan => 'Kaufen und Verkaufen digitale produkte';
  String get lab_continue => 'Weiter';
  String get signin => 'Einloggen';
  String get signup => 'Neu registrieren';
  String get createaccount => 'Neu registrieren';
  String get forgotpassword => 'Passwort vergessen?';
  String get email => 'Email';
  String get password => 'Passwort';
  String get pleaseendteryouremail => 'Bitte gib deine E-mail-Addresse ein';
  String get pleaseenteryourpassword => 'Bitte gib dein Passwort ein';
  String get forgotpassword_description =>
      'Bitte gib hier deine E-Mail-Adresse ein, mit der du bei willhaben registriert bist. An diese E-Mail-Adresse senden wir den Link zum Ändern des Passworts.';
  String get lab_send => 'Änderungslink anfordern';
  String get changepassword => 'PASSWORT ÄNDERN';
  String get confirmpassword => 'Neues Passwort bestätigen';
  String get resetpass_description =>
      'Nach der Änderung kann das neue Passwort sofort verwendet werden..';
  String get resetpassword => 'Reset Passwort';
  String get currentpassword => 'Aktuell Passwort';
  String get enteryourcurrentpassword => 'Schreibst deine aktuelle passwort';
  String get newpassword => 'Neues passwort';
  String get enteryournewpassword => 'Neues Passwort';
  String get confirmnewpassword => 'Neues Passwort bestätigen';
  String get repeatyournewpassword => 'Wiederholen neues password';
  String get haveInvite => 'Hast du einladung code ?';
  String get inviteCode => 'Einladung Code';
  String get inputCode => 'Bitte schreiben seine einladung code';
  String get name => 'Name';
  String get inputName => 'Bitte gib deinen Vornamen ein';
  String get workType => "ARBEITEN";
  String get hireType => "MIETEN";

  //Settings page
  String get lab_settings => "Settings";
  String get labelSelectLanguage => "Wahlen Sie die sprache";
  String get labelLanguage => "Sprache";
  String get lab_colorstyle => 'Farbe Style';
  String get lab_changepassword => 'Anderung Passwort';
  String get labelInfo => "This is multi-languages demo application";
  String get delete_account => "Konto löschen";

  //accountsetting page
  String get addproduct => 'Produkt aufgeben';
  String get offersandpromos => 'Angebot & Rabatt';
  String get payments => 'Zahlungen';
  String get FAQ => 'FAQ';
  String get paymentshistory => 'Zahlungshistorie';
  String get myproducts => 'Meine Produkte';
  String get notificaiton => 'Benachrichtigungen';
  String get mysales => 'Verkauft';
  String get myorders => 'Meine Bestellungen';
  String get favorites => 'Favoriten';
  String get signout => 'Ausloggen';
  String get closeAccount => 'Konto schließen';
  String get fromCamera => "From Camera";
  String get fromFiles => "From Files";
  String get switchToHire => "Wechseln Sie zu mieten";
  String get switchToWorker => "Wechseln Sie zu Arbeiter";

  //chatting room
  String get conversations => 'Nachrichten';
  String get nochattingroom => 'Noch kein nachricht';
  String get gohomepage => 'Homepage gehen';
  String get goBrowserPage => "Job durchsuchen";
  String get cancel_btn => 'Löschen';
  String get delete_btn => 'Löschen';
  String get areyousure => 'Bist du sicher?';
  String get delete_description => 'Dieser Raum wird endgültig gelöscht.';
  String get archiveroom => 'Archivieren das Raum';
  String get unarchiveroom => 'dearchivieren Sie den Raum';
  String get deleteroom => 'Löschen das Raum';

  //add product
  String get title => 'TITEL';
  String get description => 'Beschreibung';
  String get price => 'Verkaufspreis';
  String get next_btn => 'Weiter';

  //file
  String get publish_btn => 'VERÖFFENTLICHEN';
  String get backtohome => 'Zuruck zum homepage';
  String get copyClipboard => 'Kopiert zum Clipboard!';

  //add or remove product
  String get deleteImage => 'Löschen das bilder';

  //here is the new languages for local service app

  //browse request
  String get searchRequest => 'Suchen Sie nach einer Anfrage';
  String get searchCategory => 'Suchen Sie nach einer Kategorie';
  String get new_tab => 'Neu';
  String get active => 'Aktiv';
  String get previous => 'Vorherige';
  String get all => 'Alle';
  String get noItems => 'Es sind keine Artikel vorhanden.';
  String get totalProposal => 'Gesamtvorschlag';
  String get selectedServices => ' Dienste ausgewählt';
  String get selectedCities => ' Städte ausgewählt';
  String get depositCoins => 'Jetzt einzahlen';
  String get requireCreditsDescription =>
      "Um Kundenanfragen sehen zu können, müssen Sie mindestens 1 Guthaben auf Ihrem Konto haben.";
  String get credits => "Kredite";

  //chat view
  String get unnamed => 'Unbenannt';

  //validation text

  String get integeronly => "Bitte geben Sie nur ganze Zahlen ein";
  String get filedMandatory => "Das Feld ist obligatorisch";

  //hirestep 01
  String get serviceCall => 'Dienstleister kann anrufen';
  String get heading_request => 'Wie lauten die Details Ihrer Stellenanfrage?';
  String get valid_question1 =>
      'Irgendwelche anderen Details, die Sie für relevant halten?';
  String get valid_question2 =>
      'Wenn Sie nicht genügend Informationen bereitstellen. Dies wirkt sich auf die Anzahl der Angebote aus, die Sie erhalten.';
  String get valid_question3 =>
      'Sie sollten mindestens 100 Buchstaben eingeben.';
  String get image_question => 'Möchten Sie Bilder hinzufügen?';
  String get where_location => 'Wo ? (Ort des Arbeitsplatzes)';
  String get location_validation =>
      'Wir können Ihren Standort nicht verwenden. Bitte Stadt suchen oder manuell eingeben';
  String get userMyLocation => 'MEINEN STANDORT VERWENDEN';
  String get enterCity => 'Geben Sie Ihren Stadtnamen ein';
  String get when_job => 'Wann ? (Datum der Tätigkeit)';
  String get answer_question => 'Möchten Sie diese Fragen beantworten?';
  String get inputAnswer => 'Geben Sie hier Ihre Antwort ein...';
  String get enterPhone => 'Geben Sie Ihr Telefon ein';
  String get phoneDescription =>
      'Unsere Profis kontaktieren Sie schneller, wenn Sie „Dienstanbieter kann anrufen“ auswählen.';
  String get enterPhoneNumber => 'Trage deine Telefonnummer ein';
  String get sendRequest => 'ANFRAGE SENDEN';
  String get alert_image => 'Bitte laden Sie mindestens ein Bild hoch.';
  String get alert_description => 'Bitte Beschreibung eingeben.';
  String get alert_address => 'Bitte geben Sie Ihre Adresse ein.';
  String get alert_one_option => 'Bitte wählen Sie eine Option.';
  String get alert_pick_date => 'Bitte Abholtermin.';
  String get alert_answer => 'Bitte beantworten Sie die Frage';
  String get alert_phone => 'Bitte Telefonnummer eingeben.';
  String get request_success_msg =>
      'Glückwunsch! Sie haben erfolgreich angefordert!';
  String get alert_close_description =>
      'Sie können kostenlose Angebote erhalten, indem Sie einige weitere Fragen beantworten.';
  String get go_on => 'MACH WEITER';
  String get quit => 'VERLASSEN';
  String get servicesCompanyReady => "Dienstleistungsunternehmen bereit";
  String get allow_contacts => "Meine Telefonnummer anzeigen";
  String get dont_disturbme => "Stör mich nicht";
  String get only_phone => "Kontaktieren Sie mich nur telefonisch";
  String get only_offers => "Senden Sie mir nur Angebote";
  String get only_whatsapp => "Kontaktieren Sie mich nur per WhatsApp";

  //hire step 02
  String get alert_nocity =>
      'Entschuldigung, aber wir können die gewünschte Stadt nicht finden...';
  String get what_looking => 'Wonach suchst du';
  String get select_service => 'Dienstart auswählen';
  String get remove_service => 'Entfernen Sie diesen Dienst';
  String get request_quote => 'Fordern Sie 7 kostenlose Angebote an';
  String get name_company => 'Vor- und Nachname (oder Firma)';
  String get phone => 'Telefon';
  String get search_city =>
      'Suchen Sie nach einer Stadt (Geben Sie mindestens 3 Buchstaben ein)';
  String get input_3 =>
      'Bitte geben Sie mindestens 3 Buchstaben ein, um die Stadt zu suchen';
  String get when_service => 'Wann brauchen Sie diesen Service';
  String get asap => 'So bald wie möglich';
  String get flexible => 'Ich bin flexibel';
  String get alert_name => 'Bitte Vor- und Nachnamen eingeben';
  String get alert_city => 'Bitte Stadt auswählen';
  String get request_success => 'Erfolg anfordern';
  String get tip_id => 'Tipp-ID';
  String get success_thankyou =>
      'Vielen Dank, dass Sie sich für unseren Service entschieden haben und darauf vertrauen, Ihnen bei Ihren Problemen zu helfen';

  //home page
  String get hi => 'Hi';
  String get home_description =>
      'Durchsuchen Sie eine Reihe von Experten, um Ihre Probleme zu lösen. Starten Sie jetzt mit der Beratung.';
  String get which_service => 'Welche Leistungen benötigen Sie?';
  String get no_service => 'Keine Dienste';

  // job detail
  String get no_city_info => 'Keine Stadtinfo';
  String get see_number => 'Sie können anrufen und meine Nummer sehen';
  String get job_detail => 'Auftragsdetails';

  String get aboutCustomer => "Über Kunde";
  String get receivedOffers => " Erhaltene Angebote";
  String get noOffers => "Keine Angebote";
  String get reviews => "REZENSION";
  String get beFirstSend => "Senden Sie als Erster ein Angebot";

  //my account setting
  String get become_seller => 'Verkäufer werden';

  //my job offer
  String get job_offer => 'Jobangebote';
  String get deadline => 'Termin';
  String get Price => 'Preis';
  String get no_proposal => 'Es gibt noch keine Vorschläge.';
  String get update_offer => "Angebot aktualisieren";

  //my job
  String get ACTIVE => 'AKTIV';
  String get CANCELED => 'ABGESAGT';
  String get Cancelled => 'Abgesagt';
  String get my_jobs => 'Meine Jobs';
  String get card_onway =>
      'Angebote sind unterwegs! Wir informieren Sie, wenn ein Angebot eingegangen ist.';
  String get view_offer => 'Angebote anzeigen';
  String get see_details => 'SIEHE EINZELHEITEN';
  String get cancel_request => 'ANFRAGE ABBRECHEN';

  //my request
  String get my_requests => 'Meine Anfragen';

  //order and pay
  String get oerder_pay => 'Bestellen und bezahlen';
  String get company_info => 'Firmeninformation';
  String get payment_method => 'Zahlungsmethode';
  String get credit_card => 'Kredit- oder Debitkarte';
  String get payment_bank => 'Zahlung per Banküberweisung';
  String get request_10 => '10 Anfragen';
  String get subscription_desc =>
      '400 Lei 360 Lei/Monat für 2 Monate, dann 400 Lei/Monat';
  String get paynow_01 =>
      'Jetzt bezahlen (erster Monat): 428,40 Lei (inkl. MwSt.)';
  String get agree => 'Ich bin einverstanden mit';
  String get terms_service => 'Geschäftsbedingungen';
  String get payNow => 'ZAHLEN SIE JETZT';
  String get name_company_02 => 'Ihr Name oder Firmenname';
  String get city => 'Stadt';
  String get address => 'Adresse';

  //splash
  String get send_splash => 'Eine Anfrage senden';
  String get receive_splash => 'Erhalten Sie bis zu 17 Angebote';
  String get choose_splash => 'Wählen Sie den Experten';

  //subscription
  String get choose_monthly => 'Wählen Sie ein monatliches Abonnement';
  String get sub_01 => '400 Lei 360 Lei/Monat für 2 Monate, dann 400 Lei/Monat';
  String get on_average1 => 'Im Durchschnitt treten Sie mit 3 Profis an.';
  String get no_contract => 'Keine Vertragslaufzeit, jederzeit kündbar';
  String get request_20 => '20 Anfragen';
  String get sub_02 => '800 Lei 480 Lei/Monat für 2 Monate dann 800 Lei/Monat';
  String get on_average2 => 'Im Durchschnitt treten Sie mit 3 Profis an.';
  String get request_35 => '35 Anfragen';
  String get on_average3 => 'Im Durchschnitt treten Sie mit 2 Profis an.';
  String get on_average4 =>
      'Der durchschnittliche Preis pro Anfrage liegt zwischen 31,65 Lei und 47,47 Lei.';
  String get calc_description =>
      '*Die Anzahl der Anfragen ist indikativ und wird auf der Grundlage des Durchschnittspreises pro Anfrage berechnet. Die Preise sind in der Preisliste aufgeführt.';

  //view service
  String get get_7 => 'Erhalten Sie 7 Angebote';

  //work step 1
  String get step1_des => 'Welche Dienstleistungen bieten Sie an?';
  String get eliminate => 'Beseitigen';
  String get step1_heading => 'Welche Dienstleistungen bieten Sie an?';
  String get change_anytime => 'Sie können dies jederzeit ändern.';
  String get selected_service => 'Ausgewählte Dienstleistungen';
  String get alert_select_service =>
      'Bitte wählen Sie für den nächsten Schritt den Dienst aus der folgenden Liste aus!';

  //work step 2
  String get step2_heading =>
      'Für welche Art von Arbeit interessieren Sie sich?';

  //work step 3
  String get step3_heading => 'In welchen Städten arbeitest du als';
  String get selected_city => 'Ausgewählte Stadt(en)';
  String get alert_select_city =>
      'Sie sollten die Stadt für den nächsten Schritt auswählen';

  //country page
  String get ro => 'Rumänien';
  String get de => 'Deutschland';
  String get sp => 'Spanien';
  String get fr => 'Frankreich';
  String get it => 'Italien';
  String get start => 'Start';

  //missing
  String get selectCategory => 'KATEGORIE WÄHLEN';
  String get filters => 'Filter';
  String get priority => 'PRIORITÄT';
  String get search => 'Suche';
  String get category => 'KATEGORIE';

  String get buyCredits => 'Guthaben kaufen';
  String get countryHeading => 'Bitte wählen Sie Ihr Land';
  String get creditHistory => 'Kredit Geschichte';
  String get ID => 'ICH WÜRDE';
  String get amount => 'Menge';
  String get date => 'Datum';
  String get noCredit => 'Keine Kreditgeschichte';
  String get Congratulation => 'Glückwunsch';
  String get requestPriority => 'Priorität anfordern';
  String get acceptPolicy =>
      'Ich akzeptiere die Benutzer- und Datenschutzvereinbarung, indem ich auf "ANFRAGE SENDEN" drücke';
  String get willNotify =>
      'Wir werden Sie per E-Mail und SMS benachrichtigen, wenn Ihre Anfrage Angebote von Profis erhält.';
  String get receivedRequest => 'Wir haben Ihre Anfrage erhalten!';
  String get free => 'Frei';
  String get priceCoins => 'PREIS MÜNZEN';
  String get type => 'TYP';
  String get planSelect =>
      'Wählen Sie Ihren Zahlungsplan entsprechend der Geschwindigkeit, mit der Sie Experten finden müssen.';
  String get canceledRequest => 'Sie haben diese Anfrage storniert!';
  String get reasonSelect => 'Bitte wählen Sie einen der folgenden Gründe aus.';
  String get reason_1 =>
      'Mit einem Angebot außerhalb dieser Website einverstanden.';
  String get reason_2 => 'Die Preise sind zu hoch.';
  String get reason_3 => 'Nicht sicher über die Qualität.';
  String get reason_4 => 'Nicht genug Angebote.';
  String get reason_5 => 'Konnte keine Antworten auf meine Fragen erhalten.';
  String get reason_6 => 'Ich brauche diesen Service nicht';
  String get unlockedReq => 'Sie haben diese Anfrage freigeschaltet!';
  String get sureUnlock => 'Möchten Sie diese Anfrage wirklich entsperren?';
  String get activeStatus => 'Status: AKTIV';
  String get offers => 'BIETET AN';
  String get viewOffers => 'ANGEBOTE ANSEHEN';
  String get jobID => 'JOB-ID';
  String get unlockReq => 'Anfrage entsperren';
  String get sendOffer => 'Sende Angebot';

  //my account
  String get myaccount => 'Mein Konto';
  String get myDetails => 'Meine Details';
  String get successUpdated => 'Erfolgreich aktualisiert!';
  String get imageSelectAlert => 'Bild nicht ausgewählt';
  String get coins => 'Münzen';
  String get myOffers => 'Meine Angebote';
  String get myservices => 'Meine Dienstleistungen';
  String get offer => 'BIETEN';
  String get noJobs => 'HIER KEINE ARBEITSPLÄTZE';
  String get noRequestDesc =>
      'Sie haben keinen Auftrag angefordert.\nFordern Sie den gewünschten Service an, erhalten Sie kostenlose Angebote!';

  String get browseServices => 'DIENSTE DURCHSUCHEN';
  String get c_reason_1 => 'Ich habe meine Meinung über den Service geändert.';
  String get c_reason_2 => 'Ich bin mit anderen Arbeiten beschäftigt.';
  String get c_reason_3 => 'Ich mag den Kunden nicht';
  String get c_reason_4 => 'Keine Zeit zum Arbeiten.';
  String get c_reason_5 => 'Kein Grund.';
  String get cancelOffer => 'Angebot stornieren';
  String get pauseReq => 'ANFRAGE PAUSIEREN';
  String get cancelledOffer => 'Sie haben dieses Angebot storniert!';
  String get startFrom => 'BEGINNE VON';
  String get save => "Speichern";

  String get services => 'Dienstleistungen';
  String get cities => 'Städte';
  String get noService => 'Keine Dienstleistungen!';
  String get noServicesDesc =>
      'Sie haben noch keinen Dienst.\nBitte fügen Sie Dienste hinzu, wenn Sie mit dem Verdienen beginnen möchten.';
  String get noCity => 'Keine Städte!';
  String get noCityDesc =>
      'Sie haben noch keine Städte.\nBitte fügen Sie Städte hinzu, wenn Sie mit dem Verdienen beginnen möchten.';
  String get addService => 'Dienst hinzufügen';
  String get searchService => 'Suchdienst';
  String get myServices => 'Meine Dienstleistungen';
  String get myCities => 'Meine Städte';
  String get addCity => 'Stadt hinzufügen';
  String get searchCity => 'Stadt suchen';

  String get newOffer => 'Neues Angebot';
  String get offerType => 'ANGEBOTSART';
  String get offerDescriptionHint =>
      'Aratai Clientului ca iai inteles nevoile. Fa o oferta personalizata. Spune-i ce vei face si de ce e important pentru el.';
  String get sentOffer => 'Sie haben ein Angebot gesendet!';
  String get updatedOffer => 'Ihr aktualisiertes Angebot!';
  String get noNotification => 'Keine Benachrichtigungen!';
  String get notificationDesc =>
      'Sie haben noch keine Benachrichtigung. Bitte Bestellung aufgeben';

  String get creditCard => 'Kreditkarte';
  String get bank => 'Bank';
  String get proposalReq => 'Angebotsanfrage';

  String get BECOME_SELLER => 'VERKÄUFER WERDEN';
  String get verifyCode => 'Verifizierungs-Schlüssel';
  String get codeVerifyDesc =>
      'Wir senden Ihnen einfach einen Bestätigungscode. Überprüfen Sie Ihren Posteingang, um sie zu erhalten.';
  String get resend_code => 'Code erneut einsenden';
  String get avg_rating => 'durchschnittliche Bewertung';
  String get verify_review => 'verifizierte Bewertungen';

  String get noSearchResult => 'Kein Suchergebnis';
  String get inputThree => 'Bitte geben Sie mindestens 3 Buchstaben ein';

  String get nojobreq => 'Keine Jobanfrage.';
  String get nojobreq_des =>
      'Keine Jobanfrage für Ihre Dienste. Wir senden Ihnen Benachrichtigungen, wenn neue Anfragen für Ihre Dienste erscheinen.';

  String get serviceReady => 'Dienstleistungsunternehmen bereit';
  String get everyear => 'Jährlich';
  String get peopleTrust => 'Menschen vertrauen lokalen Diensten für';

  //redeem code section
  String get redeemVoucher => 'GUTSCHEIN EINLÖSEN';
  String get redeemAction => 'Dieser Code wird auf Ihr Konto angewendet.';
  String get codeInvaild => 'Der eingegebene Code ist nicht gültig.';
  String get couponSuccess =>
      'Gutscheincode erfolgreich auf Ihr Konto angewendet.';
  String get cousherCode => 'Gutscheincode';
  String get tryAgain => 'VERSUCHEN SIE ES NOCHMAL';
  String get addNew => 'NEUE HINZUFÜGEN';
  String get addBtn => 'HINZUFÜGEN';
  String get apply => 'ANWENDEN';
  String get haveRedeemCode => 'Haben Sie einen Einlösecode?';
  String get paymentMethod => 'Zahlungsmethode';

  String get specificTime => 'Bestimmte Zeit (innerhalb von drei Wochen)';
  String get inTwoMonth => 'In zwei Monaten';
  String get inSixMonth => 'In sechs Monaten';
  String get onlyPrice => 'Suche nur nach Preis';
  String get flexibleTime => 'Flexibel';
  String get allContact => 'Kontakte zulassen';
  String get onlyOffers => 'Nur Angebote';
  String get onlyPhone => 'Nur Telefon';
  String get onlyWhatsapp => 'Nur WhatsApp';
  String get notDisturb => 'Stör mich nicht';

  String get processing => "wird bearbeitet";
  String get thankyou => "Danke schön";
  //become a seller
  String get companyNameHint => 'Firmenname oder Personenname';
  String get companyNumberHint => 'Firmennummer oder Personennummer';
  String get profileDescriptionHint => "Profil Beschreibung";
  String get companyNameValidateError =>
      "Bitte geben Sie den Firmen- oder Personennamen ein";
  String get companyNumberValidateError =>
      "Bitte geben Sie die Firmen- oder Personennummer ein";
  String get profileDescriptionValidateError =>
      "Bitte Profilbeschreibung eingeben";
  String get addressValidateError => "Bitte Adresse eingeben";
  String get phoneValidateError => "Bitte Telefon eingeben";
  String get optional => "(OPTIONAL)";
  String get becomeSellerApproved =>
      "Ihre Bewerbung als Verkäufer wurde eingereicht.";
  String get private => "PRIVAT";
  String get company => "UNTERNEHMEN";
  String get close => "NAH DRAN";

  //other
  String get call => "ANRUF";
  String get skip => "ÜBERSPRINGEN";
  String get chat => "PLAUDERN";
  String get seeAll => "ALLES SEHEN";
  String get award => "VERGEBEN";
  String get noPhoneNumber => "User haven't got phone number.";
  String get about => "Über";
  String get photos => "Fotos";
  String get feedBacks => "Rückmeldungen";
  String get contact => "Kontakt";
  String get favorite => "Favorit";
  String get share => "Teilen";
  String get clientMode => "Client-Modus";
  String get providerMode => "Provider-Modus";
  String get addButton => "Hinzufügen";
  String get backButton => "Zurück";
  String get addSucceed => "Успешно добавлено";
  // write review
  String get howWasService =>
      "Wie war der Service, den Sie erhalten haben? \nSind Sie zufrieden?";
  String get writeReview => "Schreiben Sie eine Bewertung";
  String get keepMeReviewHidden => "Halten Sie meine Bewertung verborgen";
  String get inputReviewError => "Bitte geben Sie Ihre Bewertung ein";
  String get reviewedSuccess =>
      "Ihre Überprüfung wurde erfolgreich durchgeführt";
  String get pleaseSelectReason =>
      "Bitte wählen Sie einen der folgenden Gründe aus.";
  String get confirm => "Bestätigen";
  String get cancelRequestReason1 =>
      "Mit einem Angebot außerhalb dieser Website einverstanden.";
  String get cancelRequestReason2 => "Die Preise sind zu hoch.";
  String get cancelRequestReason3 => "Nicht sicher über die Qualität.";
  String get cancelRequestReason4 => "Nicht genug Angebote.";
  String get cancelRequestReason5 =>
      "Konnte keine Antworten auf meine Fragen bekommen.";
  String get cancelRequestReason6 => "Ich brauche diesen Service nicht";
  String get minute => 'Minute';
  String get minutes => 'Protokoll';
  String get day => 'Tag';
  String get days => 'Tage';
  String get month => 'Monat';
  String get months => 'Monate';
  String get ago => 'vor';
  String get hour => "Stunde";
  String get hours => "Std.";
  String get headStringRegistered => 'vor';
  String get tailStringRegistered => 'registriert';
  String get high => "hoch";
  String get iWant => "Ich will";
  String get total => "gesamt";
  String get availableFrom => "Verfügbar ab";
  String get deadLineHint => 'in 5 Tagen';

  //chat widget
  String get typing => 'tippen';
  String get online => 'online';
  String get offline => 'offline';
  String get connecting => 'Verbinden';
  String get joinRoom => 'Raum betreten';
  String get hintTextMessage => "Nachricht";
  String get fullScreen => "Ganzer Bildschirm";
  String get noOffersDesc =>
      "Sie haben noch keine Angebote.Gehen Sie jetzt auf die Anfrageseite und senden Sie Angebote auf Kundenanfragen.";
}
