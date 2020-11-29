sap.ui.define([
	"sap/ui/core/mvc/Controller",
	"sap/m/MessageToast",
	"sap/m/MessageBox",
	"sap/ui/model/Filter",
	"sap/ui/model/FilterOperator",
	"sap/ui/model/json/JSONModel",
	"../model/formatter",

], function (Controller, MessageToast, MessageBox, Filter, FilterOperator, JSONModel, formatter) {
	"use strict";
	return Controller.extend("sap.study.zc06Proj002.controller.View2", {

		formatter: formatter,

		onInit: function () {
			this.handleNavigationWithContext();
		},

		getPage: function () {
			return this.byId("dynamicPageId");
		},

		onToggleFooter: function () {
			this.getPage().setShowFooter(!this.getPage().getShowFooter());
		},

		onAfterRendering: function () {	},

		onExit: function () { },

		handleSavePress: function () {

			var checkIcon = this.getView().byId("check3").getValue();
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

							var empMaktx = this.getView().byId("ipMaktx").getValue();
							var empKunnr = this.getView().byId("ipKunnr").getText();
							var empKnumh = this.getView().byId("ipKnumh").getValue();
							var empKbetr = this.getView().byId("ipKbetr").getValue();
							var empDatab = this.getView().byId("ipDatab").getValue();
							var empDatbi = this.getView().byId("ipDatbi").getValue();
							var empCuser = this.getView().byId("ipCuser").getValue();
							var empIcon = "3";

							var empLoad = {
								"Maktx": empMaktx,
								"Kunnr": empKunnr,
								"Knumh": empKnumh,
								"Kbetr": empKbetr,
								"Datab": empDatab,
								"Datbi": empDatbi,
								"Cuser": empCuser,
								"Icon": empIcon
							};

							this.getView().getModel().update("/Konh_odataSet(Maktx='" + empMaktx + "',Kunnr='" + empKunnr + "',Knumh='" + empKnumh +
								"')",
								empLoad, {
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

		handleNavigationWithContext: function () {

			var that = this;
			var entitySet;
			var sRouteName;

			function _onBindingChange(oEvent) {
				// No data for the binding
				if (!that.getView().getBindingContext()) {
					//Need to insert default fallback route to load when requested route is not found.
					that.getOwnerComponent().getRouter().getTargets().display("");
				}
				// MARA
				var matnr = this.getView().byId("MatnrId").getText();
				var aFilters = new Filter("Matnr", FilterOperator.EQ, matnr);
				var oList = this.byId("table0_copy");
				var oBinding = oList.getBinding("items");
				oBinding.filter(aFilters, "Application");

				// MARA
				var knumh = this.getView().byId("ipKnumh").getValue();
				var aFilters2 = new Filter("Knumh", FilterOperator.EQ, knumh);
				var oList2 = this.byId("list9");
				var oBinding2 = oList2.getBinding("items");
				oBinding2.filter(aFilters2, "Application");

			}

			function _onRouteMatched(oEvent) {
				var oArgs, oView;
				oArgs = oEvent.getParameter("arguments");
				oView = that.getView();
				var sKeysPath = Object.keys(oArgs).map(function (key) {
					var oProp = JSON.parse(decodeURIComponent(oArgs[key]));
					return key + "=" + (oProp.type === "Edm.String" ? "'" + oProp.value + "'" : oProp.value);
				}).join(",");

				oView.bindElement({
					path: entitySet + "(" + sKeysPath + ")",
					events: {
						change: _onBindingChange.bind(that),
						dataRequested: function () {
							oView.setBusy(true);
						},
						dataReceived: function () {
							oView.setBusy(false);
						}
					}
				});
			}

			if (that.getOwnerComponent().getRouter) {
				var oRouter = that.getOwnerComponent().getRouter();
				var oManifest = this.getOwnerComponent().getMetadata().getManifest();
				var content = that.getView().getContent();
				if (content) {
					var oNavigation = oManifest["sap.ui5"].routing.additionalData;
					var oContext = oNavigation[that.getView().getViewName()];
					sRouteName = oContext.routeName;
					entitySet = oContext.entitySet;
					oRouter.getRoute(sRouteName).attachMatched(_onRouteMatched, that);
				}
			}
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