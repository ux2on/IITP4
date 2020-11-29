function initModel() {
	var sUrl = "/sap/opu/odata/SAP/ZC06_KNA1_ODATA_SRV/";
	var oModel = new sap.ui.model.odata.ODataModel(sUrl, true);
	sap.ui.getCore().setModel(oModel);
}