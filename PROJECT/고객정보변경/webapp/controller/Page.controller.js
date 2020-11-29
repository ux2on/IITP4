sap.ui.define([
	"sap/ui/core/Fragment",
	"sap/ui/core/mvc/Controller",
	"sap/m/MessageToast",
	"sap/m/MessageBox",
	"sap/ui/model/json/JSONModel",
	"sap/ui/model/Filter",
	"sap/ui/model/FilterOperator",
	"../model/formatter"
], function (Fragment, Controller, MessageToast, MessageBox, JSONModel, Filter, FilterOperator, formatter) {
	"use strict";

	var PageController = Controller.extend("sap.study.zc06Proj001.controller.Page", {

		formatter: formatter,

		onInit: function (oEvent) { },

		onAfterRendering: function () {

			// [Display Fragment]을 화면에 띄움
			this._showFormFragment("Display");
			// [Display Fragment]-[custom list]에 특정 key값에 대한 oData 연결
			var that = this;
			// JSON Model 선언			
			var oModel = new sap.ui.model.json.JSONModel();
			// Model 명 지정		
			this.getView().setModel(oModel, "userapi");
			// UserInfo Api Load
			oModel.loadData("/services/userapi/currentUser");
			/* Add a completion handler to log the json and any errors*/
			oModel.attachRequestCompleted(function onCompleted(oEvent2) {
				if (oEvent2.getParameter("success")) {
					this.setData({
						"json": this.getJSON(),
						"status": "Success"
					}, true);

					that.idn = oEvent2.getSource().getData().name;
					if (that.idn === "P2001856793") {
						that.kunnr = "1000091";
						that.name1 = "%EC%94%A8%EC%A0%9C%EC%9D%B4";

					} else {
						that.kunnr = "1000193";
						that.name1 = "SPC";
					}

					// [Display Fragment]에 특정 key값에 대한 oData 연결
					var sServiceUrl = "/sap/opu/odata/SAP/ZC06_KNA1_ODATA_SRV/";
					var oModel_defalt = new sap.ui.model.odata.ODataModel(sServiceUrl, true);

					oModel_defalt.attachRequestCompleted(function () {
						that.byId("edit").setEnabled(true);
					});
					that.getView().setModel(oModel_defalt);
					that.sObjectPath = that.getView().getModel().createKey("KNA1_oDataSet", {
						Kunnr: that.kunnr,
						Name1: that.name1
					});

					that.getView().bindElement({
						path: "/" + that.sObjectPath,
						events: {
							change: function (oEvent3) {
								var fragmentId = that.getView().getId();
								var aFilters = [];
								var kunnr = sap.ui.core.Fragment.byId(fragmentId, "kunnrId").getText();

								aFilters.push(new Filter("Kunnr", FilterOperator.EQ, kunnr)); //kunnr.toString()
								var oList = sap.ui.core.Fragment.byId(fragmentId, "panel0");
								var oBinding = oList.getBinding("content");
								oBinding.filter(aFilters, "Application");
							}
						}
					});

				} else {
					var msg = oEvent2.getParameter("errorObject").textStatus;
					if (msg) {
						this.setData("status", msg);
					} else {
						this.setData("status", "Unknown error retrieving user info");
					}
				}
			});
		},

		onExit: function () {

			for (var sPropertyName in this._formFragments) {
				if (!this._formFragments.hasOwnProperty(sPropertyName) || this._formFragments[sPropertyName] === null) {
					return;
				}
				this._formFragments[sPropertyName].destroy();
				this._formFragments[sPropertyName] = null;
			}
		},


		doFindAddress: function (oEvent) {

			var that = this;
			var fragmentId = that.getView().getId();

			jQuery.sap.includeScript({
				url: "https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js",
				id: "daum"
			}).then(function () {
				var element_layer = that.getView().byId("layer");
				new daum.Postcode({
					oncomplete: function (data) {
						console.log('data', data);
						sap.ui.core.Fragment.byId(fragmentId, "ipPstlz").setValue(data.zonecode);
						sap.ui.core.Fragment.byId(fragmentId, "ipOrt01").setValue(data.sido);
						sap.ui.core.Fragment.byId(fragmentId, "ipOrt02").setValue(data.sigungu);
						var dosi = data.sido.length;
						var sigu = data.sigungu.length;
						var numb = dosi + sigu + 2;
						var road = data.roadAddress.substring(numb);

						console.log(road);
						sap.ui.core.Fragment.byId(fragmentId, "ipStras").setValue(road);
					},
					width: '500px',
					height: '500px',
					maxSuggestItems: 5
				}).open();
			});
		},

		closeDaumPostcode: function () {
			this.getView().byId("layer").setVisible(false);
		},


		handleEditPress: function () {
			this._toggleButtonsAndView(true);
		},

		handleCancelPress: function () {

			this._toggleButtonsAndView(false);
			var that = this;
			this.getView().bindElement({
				path: "/" + this.sObjectPath,
				events: {
					change: function (oEvent2) {
						var fragmentId = that.getView().getId();
						var aFilters = [];
						var kunnr = sap.ui.core.Fragment.byId(fragmentId, "kunnrId").getText();

						aFilters.push(new Filter("Kunnr", FilterOperator.EQ, kunnr)); //kunnr.toString()
						var oList = sap.ui.core.Fragment.byId(fragmentId, "panel0");
						var oBinding = oList.getBinding("content");
						oBinding.filter(aFilters, "Application");
					}
				}
			});
		},

		handleSavePress: function () {

			var fragmentId = this.getView().getId();

			var checkIcon = sap.ui.core.Fragment.byId(fragmentId, "Icon3check").getText();
			if (checkIcon === "3") {
				MessageToast.show("현재 변경 신청중인 데이터가 있습니다.");

			} else {

				MessageBox.confirm(
					"변경 신청 하시겠습니까?", {
					actions: [
						MessageBox.Action.YES,
						MessageBox.Action.NO
					],
					onClose: function (sAction) {
						if (sAction === MessageBox.Action.YES) {

							var empKunnr = sap.ui.core.Fragment.byId(fragmentId, "ipKunnr").getValue();
							var empNameV = sap.ui.core.Fragment.byId(fragmentId, "NameV").getText();
							var empName1 = sap.ui.core.Fragment.byId(fragmentId, "ipName1").getValue();
							var empTelf1 = sap.ui.core.Fragment.byId(fragmentId, "ipTelf1").getValue();
							var empLand1 = sap.ui.core.Fragment.byId(fragmentId, "ipLand1").getValue();
							var empPstlz = sap.ui.core.Fragment.byId(fragmentId, "ipPstlz").getValue();
							var empOrt01 = sap.ui.core.Fragment.byId(fragmentId, "ipOrt01").getValue();
							var empOrt02 = sap.ui.core.Fragment.byId(fragmentId, "ipOrt02").getValue();
							var empStras = sap.ui.core.Fragment.byId(fragmentId, "ipStras").getValue();
							var empCuser = sap.ui.core.Fragment.byId(fragmentId, "ipCuser").getValue();
							var empIcon = "3";

							var empLoad = {
								"Kunnr": empKunnr,
								"Name1": empName1,
								"Telf1": empTelf1,
								"Land1": empLand1,
								"Pstlz": empPstlz,
								"Ort01": empOrt01,
								"Ort02": empOrt02,
								"Stras": empStras,
								"Icon": empIcon,
								"Cuser": empCuser
							};

							this.getView().getModel().update("/KNA1_oDataSet(Kunnr='" + empKunnr + "',Name1='" + empNameV + "')", empLoad, {
								method: "PUT",
								success: function (odata, Response) {
									MessageToast.show("success");
								},
								error: function (cc, vv) {
									MessageToast.show("fail");
								}
							});

						} else if (sAction === MessageBox.Action.NO) {

						}
					}.bind(this)
				});
			}
		},

		_formFragments: {},

		_toggleButtonsAndView: function (bEdit) {

			var oView = this.getView();

			// Show the appropriate action buttons
			oView.byId("edit").setVisible(!bEdit);
			oView.byId("save").setVisible(bEdit);
			oView.byId("cancel").setVisible(bEdit);

			// Set the right form type
			this._showFormFragment(bEdit ? "Change" : "Display");

		},

		_getFormFragment: function (sFragmentName) {

			var oFormFragment = this._formFragments[sFragmentName];

			if (oFormFragment) {
				return oFormFragment;
			}

			oFormFragment = sap.ui.xmlfragment(this.getView().getId(), "sap.study.zc06Proj001.view." + sFragmentName, this);

			this._formFragments[sFragmentName] = oFormFragment;
			return this._formFragments[sFragmentName];

		},

		_showFormFragment: function (sFragmentName) {

			var oPage = this.byId("page");

			oPage.removeAllContent();
			oPage.insertContent(this._getFormFragment(sFragmentName));
		}

	});
	return PageController;
});