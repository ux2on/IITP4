sap.ui.define([
	"sap/ui/model/Filter",
	"sap/ui/model/FilterOperator",
	"sap/ui/model/Sorter",
	"sap/ui/core/mvc/Controller",
	"../model/formatter"
], function (Filter, FilterOperator, Sorter, Controller, formatter) {
	"use strict";
	return Controller.extend("sap.study.zc06Proj002.controller.View1", {

		formatter: formatter,

		onInit: function () {},

		onAfterRendering: function () {

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
					} else {
						that.kunnr = "1000193";
					}

					var aFilters = [];
					var kunnr = that.kunnr;
					aFilters.push(new Filter("Kunnr", FilterOperator.EQ, kunnr));
					var oList = that.byId("table0");
					var oBinding = oList.getBinding("items");
					oBinding.filter(aFilters, "Application");

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

		handleSearchField: function () {

			var that = this;
			if (that.idn === "P2001856793") {
				that.kunnr = "1000091";
			} else {
				that.kunnr = "1000193";
			}
			var aFilters = [];
			var kunnr = that.kunnr;
			var sQuery = that.getView().byId("searchField1").getValue();
			aFilters.push(new Filter("Kunnr", FilterOperator.EQ, kunnr));
			aFilters.push(new Filter("Maktx", FilterOperator.EQ, sQuery));

			// update list binding
			var oList = that.byId("table0");
			var oBinding = oList.getBinding("items");
			oBinding.filter(aFilters, "Application");
		},

		action: function (oEvent) {
			var that = this;
			var actionParameters = JSON.parse(oEvent.getSource().data("wiring").replace(/'/g, "\""));
			var eventType = oEvent.getId();
			var aTargets = actionParameters[eventType].targets || [];
			aTargets.forEach(function (oTarget) {
				var oControl = that.byId(oTarget.id);
				if (oControl) {
					var oParams = {};
					for (var prop in oTarget.parameters) {
						oParams[prop] = oEvent.getParameter(oTarget.parameters[prop]);
					}
					oControl[oTarget.action](oParams);
				}
			});
			var oNavigation = actionParameters[eventType].navigation;
			if (oNavigation) {
				var oParams = {};
				(oNavigation.keys || []).forEach(function (prop) {
					oParams[prop.name] = encodeURIComponent(JSON.stringify({
						value: oEvent.getSource().getBindingContext(oNavigation.model).getProperty(prop.name),
						type: prop.type
					}));
				});
				if (Object.getOwnPropertyNames(oParams).length !== 0) {
					this.getOwnerComponent().getRouter().navTo(oNavigation.routeName, oParams);
				} else {
					this.getOwnerComponent().getRouter().navTo(oNavigation.routeName);
				}
			}
		}
	});
});