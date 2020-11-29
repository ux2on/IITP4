sap.ui.define([
	"sap/ui/core/library"
], function (coreLibrary) {
	"use strict";

	// shortcut for sap.ui.core.ValueState
	var ValueState = coreLibrary.ValueState;

	return {

		phoneFomatter: function (num, type) {
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

	kbetrFormat: function (num) {
		
		var numTemp;
		var len, point, str;
		if( num !== null ){
			numTemp = parseInt(num).toString();
			
			//num = num + "";
			point = numTemp.length % 3;
			len = numTemp.length;

			str = numTemp.substring(0, point);
			while (point < len) {
				if (str !== "") str += ",";
				str += numTemp.substring(point, point + 3);
				point += 3;
				
		
			}
		}

			 return str;
			 
			// var len, point, str;
			// num = num + "";
			// point = num.length % 3;
			// len = num.length;

			// str = num.substring(0, point);
			// while (point < len) {
			// 	if (str != "") str += ",";
			// 	str += num.substring(point, point + 3);
			// 	point += 3;
				
		
			// }

			// return str;
		
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
		},

		comma: function (num) {
			var len, point, str;

			num = num + "";
			point = num.length % 3;
			len = num.length;

			str = num.substring(0, point);
			while (point < len) {
				if (str != "") str += ",";
				str += num.substring(point, point + 3);
				point += 3;
			}

			return str;

		},
		
		


	};

});