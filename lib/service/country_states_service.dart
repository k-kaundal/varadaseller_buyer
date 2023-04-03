// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/area_dropdown_model.dart';
import 'package:qixer/model/country_dropdown_model.dart';
import 'package:qixer/model/states_dropdown_model.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/const_strings.dart';
import 'package:qixer/view/utils/others_helper.dart';

var defaultId = '0';

class CountryStatesService with ChangeNotifier {
  var countryDropdownList = [];
  var countryDropdownIndexList = [];
  dynamic selectedCountry = ConstString.selectCountry;
  dynamic selectedCountryId = defaultId;

  var statesDropdownList = [];
  var statesDropdownIndexList = [];

  dynamic selectedState = ConstString.selectState;
  dynamic selectedStateId = defaultId;

  var areaDropdownList = [];
  var areaDropdownIndexList = [];
  dynamic selectedArea = ConstString.selectArea;
  dynamic selectedAreaId = defaultId;

  bool isLoading = false;

  setStateDefault() {
    statesDropdownList = [];
    statesDropdownIndexList = [];
    selectedState = ConstString.selectState;
    selectedStateId = defaultId;
    notifyListeners();
  }

  setAreaDefault() {
    areaDropdownList = [];
    areaDropdownIndexList = [];
    selectedArea = ConstString.selectArea;
    selectedAreaId = defaultId;
    notifyListeners();
  }

  setCountryValue(value) {
    selectedCountry = value;
    print('selected country $selectedCountry');
    notifyListeners();
  }

  setStatesValue(value) {
    selectedState = value;
    print('selected state $selectedState');
    notifyListeners();
  }

  setAreaValue(value) {
    selectedArea = value;
    notifyListeners();
  }

  setSelectedCountryId(value) {
    selectedCountryId = value;
    print('selected country id $value');
    notifyListeners();
  }

  setSelectedStatesId(value) {
    selectedStateId = value;
    print('selected state id $value');
    notifyListeners();
  }

  setSelectedAreaId(value) {
    selectedAreaId = value;
    print('selected area id $value');
    notifyListeners();
  }

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

//Set country based on user profile
//==============================>

  setCountryBasedOnUserProfile(BuildContext context) {
    selectedCountry = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .country
            .country ??
        ConstString.selectCountry;
    selectedCountryId = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .countryId ??
        defaultId;

    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }

//Set state based on user profile
//==============================>
  setStateBasedOnUserProfile(BuildContext context) {
    selectedState = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .city
            .serviceCity ??
        ConstString.selectState;
    selectedStateId = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .city
            .id ??
        defaultId;
    print(statesDropdownList);
    print(statesDropdownIndexList);
    print('selected state $selectedState');
    print('selected state id $selectedStateId');
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   notifyListeners();
    // });
  }

  //Set area based on user profile
//==============================>
  setAreaBasedOnUserProfile(BuildContext context) {
    selectedArea = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .area
            .serviceArea ??
        ConstString.selectArea;
    selectedAreaId = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .area
            .id ??
        defaultId;
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   notifyListeners();
    // });
  }

  fetchCountries(BuildContext context) async {
    if (countryDropdownList.isNotEmpty) return;

    if (countryDropdownList.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setLoadingTrue();
      });
      var response = await http.get(Uri.parse('$baseApi/country'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        var data = CountryDropdownModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < data.countries.length; i++) {
          countryDropdownList.add(data.countries[i].country);
          countryDropdownIndexList.add(data.countries[i].id);
        }

        setCountry(context, data: data);

        notifyListeners();
      } else {
        //error fetching data
        countryDropdownList.add(ConstString.selectCountry);
        countryDropdownIndexList.add(defaultId);
        selectedCountry = ConstString.selectState;
        selectedCountryId = defaultId;
        notifyListeners();
      }
    } else {
      //country list already loaded from api
      setCountry(context);
      // set_State(context);
      // setArea(context);
    }
  }

  Future<bool> fetchStates(BuildContext context) async {
    //make states list empty first
    statesDropdownList = [];
    statesDropdownIndexList = [];
    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });

    var response = await http
        .get(Uri.parse('$baseApi/country/service-city/$selectedCountryId'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = StatesDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.serviceCities.length; i++) {
        statesDropdownList.add(data.serviceCities[i].serviceCity);
        statesDropdownIndexList.add(data.serviceCities[i].id);
      }

      //keeping the data
      // oldStateDropdownList = statesDropdownList;
      // oldStatesDropdownIndexList = oldStatesDropdownIndexList;

      set_State(context, data: data);
      notifyListeners();
      return true;
    } else {
      //error fetching data
      statesDropdownList.add(ConstString.selectState);
      statesDropdownIndexList.add(defaultId);
      selectedState = ConstString.selectState;
      selectedStateId = defaultId;
      notifyListeners();
      return false;
    }
  }

  fetchArea(BuildContext context) async {
    //make states list empty first
    areaDropdownList = [];
    areaDropdownIndexList = [];
    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });

    var response = await http.get(Uri.parse(
        '$baseApi/country/service-city/service-area/$selectedCountryId/$selectedStateId'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = AreaDropdownModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.serviceAreas.length; i++) {
        areaDropdownList.add(data.serviceAreas[i].serviceArea);
        areaDropdownIndexList.add(data.serviceAreas[i].id);
      }

      setArea(context, data: data);
      notifyListeners();
    } else {
      areaDropdownList.add(ConstString.selectArea);
      areaDropdownIndexList.add(defaultId);
      selectedArea = ConstString.selectArea;
      selectedAreaId = defaultId;
      notifyListeners();
    }
  }

  setCountry(BuildContext context, {data}) {
    var profileData =
        Provider.of<ProfileService>(context, listen: false).profileDetails;
    //if profile of user loaded then show selected dropdown data based on the user profile
    if (profileData != null &&
        profileData.userDetails.country.country != null) {
      setCountryBasedOnUserProfile(context);
    } else {
      if (data != null) {
        selectedCountry = data.countries[0].country;
        selectedCountryId = data.countries[0].id;
      }
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }

//==============>
  set_State(BuildContext context, {data}) {
    var profileData =
        Provider.of<ProfileService>(context, listen: false).profileDetails;

    if (profileData != null) {
      var userCountryId = Provider.of<ProfileService>(context, listen: false)
          .profileDetails
          .userDetails
          .countryId;

      if (userCountryId == selectedCountryId) {
        //if user selected the country id which is save in his profile
        //only then show state/area based on that

        setStateBasedOnUserProfile(context);
      } else {
        if (data != null) {
          selectedState = data.serviceCities[0].serviceCity;
          selectedStateId = data.serviceCities[0].id;
        }
      }
    } else {
      if (data != null) {
        selectedState = data.serviceCities[0].serviceCity;
        selectedStateId = data.serviceCities[0].id;
      }
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }

// ==================>
  setArea(BuildContext context, {data}) {
    var profileData =
        Provider.of<ProfileService>(context, listen: false).profileDetails;

    if (profileData != null) {
      var userCountryId = Provider.of<ProfileService>(context, listen: false)
          .profileDetails
          .userDetails
          .countryId;
      if (userCountryId == selectedCountryId) {
        //if user selected the country id which is save in his profile
        //only then show state/area based on that

        setAreaBasedOnUserProfile(context);
      } else {
        if (data != null) {
          selectedArea = data.serviceAreas[0].serviceArea;
          selectedAreaId = data.serviceAreas[0].id;
        }
      }
    } else {
      if (data != null) {
        selectedArea = data.serviceAreas[0].serviceArea;
        selectedAreaId = data.serviceAreas[0].id;
      }
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
  }
}
