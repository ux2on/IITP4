sap.ui.define([
	"sap/ui/core/library"
], function (coreLibrary) {
	"use strict";

	// shortcut for sap.ui.core.ValueState
	var ValueState = coreLibrary.ValueState;

	return {

		phoneFormat: function (num) {
			var type = 1; //타입은 사용하지않기 때문에 type = 0 을 방지 하기위함
			
			if(!num) return '';
			
			var formatNum = '';
			if (num.length == 11) {
				if (type == 0) {
					formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-****-$3');
				} else {
					formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
				}
			} else if (num.length == 8) {
				formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');
			} else {
				if (num.indexOf('02') == 0) {
					if (type == 0) {
						formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-****-$3');
					} else {
						formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
					}
				} else {
					if (type == 0) {
						formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-***-$3');
					} else {
						formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
					}
				}
			}
			return formatNum;
		},


		dateFormat: function (num) {
			if (!num) return "";
			var formatNum = '';
			//공백제거
			num = num.replace(/\s/gi, "");
			try {
				if (num.length == 8) {
					formatNum = num.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
				}
			} catch (e) {
				formatNum = num;
				console.log(e);
			}
			return formatNum;
		}

	};

});