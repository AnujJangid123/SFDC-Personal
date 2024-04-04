({
	doInit: function (component, event, helper) {
		console.log("Initialisation Completed");
		//
		const words = helper.getWords(6);
		component.set("v.Words", words);
		console.log("Words: " +words);
		//
		const winWord = helper.getWinWord(words);
		component.set("v.winWord", winWord);
		console.log("Win Word: " + helper.getWinWord(words));
	}

	// doRender: function(component, event, helper) {
	// 	console.log("Render Completed");
	// }
});