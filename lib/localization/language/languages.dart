import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

// @override
  String get appName;
  //error
  String get kEmailNullError;
  String get kInvalidEmailError;
  String get kPassNullError;
  String get kConfirmPasswordError;
  String get kShortPassError;
  String get kMatchPassError;
  String get kNameNullError;
  String get kPhoneNumberNullError;
  String get kAddressNullError;
  String get kTitleNullError;
  String get kDescriptionNullError;
  String get kPriceNullError;
  String get kDeadLineNullError;
  //Splash screen, sign in, sign out, reset, etc - first screens
  String get slogan;
  String get lab_continue;
  String get signin;
  String get signup;
  String get createaccount;
  String get forgotpassword;
  String get email;
  String get password;
  String get pleaseendteryouremail;
  String get pleaseenteryourpassword;
  String get forgotpassword_description;
  String get lab_send;
  String get changepassword;
  String get confirmpassword;
  String get resetpass_description;
  String get resetpassword;
  String get currentpassword;
  String get enteryourcurrentpassword;
  String get newpassword;
  String get enteryournewpassword;
  String get confirmnewpassword;
  String get repeatyournewpassword;
  String get haveInvite;
  String get inviteCode;
  String get inputCode;
  String get name;
  String get inputName;
  String get workType;
  String get hireType;

  //Settings page
  String get lab_settings;
  String get labelSelectLanguage;
  String get labelLanguage;
  String get lab_colorstyle;
  String get lab_changepassword;
  String get delete_account;

  //accountsetting page
  String get addproduct;
  String get payments;
  String get FAQ;
  String get paymentshistory;
  String get myproducts;
  String get notificaiton;
  String get mysales;
  String get myorders;
  String get favorites;
  String get signout;
  String get fromFiles;
  String get fromCamera;
  String get switchToHire;
  String get switchToWorker;

  //chatting room
  String get conversations;
  String get nochattingroom;
  String get gohomepage;
  String get goBrowserPage;
  String get cancel_btn;
  String get delete_btn;
  String get areyousure;
  String get delete_description;
  String get archiveroom;
  String get deleteroom;

  //add product
  String get title;
  String get description;
  String get price;
  String get next_btn;

  //file
  String get publish_btn;
  String get backtohome;
  String get copyClipboard;

  //add or remove product
  String get deleteImage;

  //here is the new languages for local service app

  //browse request
  String get searchRequest;
  String get searchCategory;
  String get new_tab;
  String get active;
  String get previous;
  String get all;
  String get noItems;
  String get totalProposal;
  String get selectedServices;
  String get selectedCities;
  String get depositCoins;
  String get requireCreditsDescription;
  String get credits;
  //chat view
  String get unnamed;

  //validation text

  String get integeronly;
  String get filedMandatory;

  //hirestep 01
  String get serviceCall;
  String get heading_request;
  String get valid_question1;
  String get valid_question2;
  String get valid_question3;
  String get image_question;
  String get where_location;
  String get location_validation;
  String get userMyLocation;
  String get enterCity;
  String get when_job;
  String get answer_question;
  String get inputAnswer;
  String get enterPhone;
  String get phoneDescription;
  String get enterPhoneNumber;
  String get sendRequest;
  String get alert_image;
  String get alert_description;
  String get alert_address;
  String get alert_one_option;
  String get alert_pick_date;
  String get alert_answer;
  String get alert_phone;
  String get request_success_msg;
  String get alert_close_description;
  String get go_on;
  String get quit;
  String get servicesCompanyReady;
  String get allow_contacts;
  String get dont_disturbme;
  String get only_phone;
  String get only_offers;
  String get only_whatsapp;
  //hire step 02
  String get alert_nocity;
  String get what_looking;
  String get select_service;
  String get remove_service;
  String get request_quote;
  String get name_company;
  String get phone;
  String get search_city;
  String get input_3;
  String get when_service;
  String get asap;
  String get flexible;
  String get alert_name;
  String get alert_city;
  String get request_success;
  String get tip_id;
  String get success_thankyou;

  //home page
  String get hi;
  String get home_description;
  String get which_service;
  String get no_service;

  // job detail
  String get no_city_info;
  String get see_number;
  String get job_detail;
  String get aboutCustomer;
  String get receivedOffers;
  String get noOffers;
  String get reviews;
  String get beFirstSend;

  //my account setting
  String get become_seller;

  //my job offer
  String get job_offer;
  String get deadline;
  String get Price;
  String get no_proposal;
  String get update_offer;

  //my job
  String get ACTIVE;
  String get CANCELED;
  String get Cancelled;
  String get my_jobs;
  String get card_onway;
  String get view_offer;
  String get see_details;
  String get cancel_request;

  //my request
  String get my_requests;

  //order and pay
  String get oerder_pay;
  String get company_info;
  String get payment_method;
  String get credit_card;
  String get payment_bank;
  String get request_10;
  String get subscription_desc;
  String get paynow_01;
  String get agree;
  String get terms_service;
  String get payNow;
  String get name_company_02;
  String get city;
  String get address;

  //splash
  String get send_splash;
  String get receive_splash;
  String get choose_splash;

  //subscription
  String get choose_monthly;
  String get sub_01;
  String get on_average1;
  String get no_contract;
  String get request_20;
  String get sub_02;
  String get on_average2;
  String get request_35;
  String get on_average3;
  String get on_average4;
  String get calc_description;

  //view service
  String get get_7;

  //work step 1
  String get step1_des;
  String get eliminate;
  String get step1_heading;
  String get change_anytime;
  String get selected_service;
  String get alert_select_service;

  //work step 2
  String get step2_heading;

  //work step 3
  String get step3_heading;
  String get selected_city;
  String get alert_select_city;

  //country page
  String get ro;
  String get de;
  String get sp;
  String get fr;
  String get it;
  String get start;

  //missing
  String get selectCategory;
  String get filters;
  String get priority;
  String get search;
  String get category;

  String get buyCredits;
  String get countryHeading;
  String get creditHistory;
  String get ID;
  String get amount;
  String get date;
  String get noCredit;
  String get Congratulation;
  String get requestPriority;
  String get acceptPolicy;
  String get willNotify;
  String get receivedRequest;
  String get free;
  String get priceCoins;
  String get type;
  String get planSelect;
  String get canceledRequest;
  String get reasonSelect;
  String get reason_1;
  String get reason_2;
  String get reason_3;
  String get reason_4;
  String get reason_5;
  String get reason_6;
  String get unlockedReq;
  String get sureUnlock;
  String get activeStatus;
  String get offers;
  String get viewOffers;
  String get jobID;
  String get unlockReq;
  String get sendOffer;

  //my account
  String get myaccount;
  String get myDetails;
  String get successUpdated;
  String get imageSelectAlert;
  String get coins;
  String get myOffers;
  String get myservices;
  String get offer;
  String get noJobs;
  String get noRequestDesc;
  String get browseServices;
  String get c_reason_1;
  String get c_reason_2;
  String get c_reason_3;
  String get c_reason_4;
  String get c_reason_5;
  String get cancelOffer;
  String get pauseReq;
  String get cancelledOffer;
  String get startFrom;
  String get save;

  String get services;
  String get cities;
  String get noService;
  String get noServicesDesc;
  String get noCity;
  String get noCityDesc;
  String get addService;
  String get searchService;
  String get myServices;
  String get myCities;
  String get addCity;
  String get searchCity;

  String get newOffer;
  String get offerType;
  String get offerDescriptionHint;
  String get sentOffer;
  String get updatedOffer;
  String get noNotification;
  String get notificationDesc;

  String get creditCard;
  String get bank;
  String get proposalReq;

  String get BECOME_SELLER;
  String get verifyCode;
  String get codeVerifyDesc;
  String get resend_code;
  String get avg_rating;
  String get verify_review;

  String get noSearchResult;
  String get inputThree;

  String get nojobreq;
  String get nojobreq_des;

  String get serviceReady;
  String get everyear;
  String get peopleTrust;

  //redeem code section
  String get redeemVoucher;
  String get redeemAction;
  String get codeInvaild;
  String get couponSuccess;
  String get cousherCode;
  String get tryAgain;
  String get addNew;
  String get addBtn;
  String get apply;
  String get haveRedeemCode;

  String get paymentMethod;

  String get specificTime;
  String get inTwoMonth;
  String get inSixMonth;
  String get onlyPrice;
  String get flexibleTime;
  String get allContact;
  String get onlyOffers;
  String get onlyPhone;
  String get onlyWhatsapp;
  String get notDisturb;

  String get processing;
  String get thankyou;

  //become a seller
  String get companyNameHint;
  String get companyNumberHint;
  String get profileDescriptionHint;
  String get companyNameValidateError;
  String get companyNumberValidateError;
  String get profileDescriptionValidateError;
  String get addressValidateError;
  String get phoneValidateError;
  String get optional;
  String get becomeSellerApproved;
  String get private;
  String get company;
  String get close;

  //other

  String get call;
  String get skip;
  String get chat;
  String get seeAll;
  String get award;
  String get noPhoneNumber;
  String get about;
  String get photos;
  String get feedBacks;
  String get contact;
  String get favorite;
  String get share;
  String get pleaseSelectReason;
  String get confirm;
  String get cancelRequestReason1;
  String get cancelRequestReason2;
  String get cancelRequestReason3;
  String get cancelRequestReason4;
  String get cancelRequestReason5;
  String get cancelRequestReason6;
  String get clientMode;
  String get providerMode;
  String get addButton;
  String get backButton;
  String get addSucceed;

  // write review
  String get howWasService;
  String get writeReview;
  String get keepMeReviewHidden;
  String get inputReviewError;
  String get reviewedSuccess;
  String get minute;
  String get minutes;
  String get day;
  String get days;
  String get hour;
  String get hours;
  String get month;
  String get months;
  String get ago;
  String get headStringRegistered;
  String get tailStringRegistered;
  String get high;
  String get iWant;
  String get total;
  String get availableFrom;
  String get deadLineHint;

  //chat widget
  String get typing;
  String get online;
  String get offline;
  String get connecting;
  String get joinRoom;
  String get hintTextMessage;
  String get fullScreen;
  String get noOffersDesc;
}
