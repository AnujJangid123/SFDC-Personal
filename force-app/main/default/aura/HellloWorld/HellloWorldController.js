({
	startGame: function (component, event, helper) {
		let gameModeComboBox = component.find("gameMode");

		let selectedValue = gameModeComboBox.get("v.value");
		component.set("v.selectedMode", selectedValue);
		console.log("The Start Game button is clicked. The game mode is "+ selectedValue);
		//alert("The Start Game button is clicked. The game mode is "+ selectedValue);
	},

	reshuffleBoard : function (Component, event, helper){
		console.log("The Reshuffle button game is clicked");
	}
});