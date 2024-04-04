({
    getWords: function(count) {
        if(count>100) return;

        let wordsArray = ["Apple","Banana","Papaya","Grapes","Guava","Pomegranate","Pineapple","Watermelon","Melon","Avocado"];

        wordsArray = this.randomizeArray(wordsArray);

       return wordsArray.slice(0, count);
    },
    
    randomizeArray : function(arr){
        const randomArr = arr;

        for (let i = randomArr.length - 1; i > 0; i--){
            const j = Math.floor(Math.random() * i);
            const temp = randomArr[i];
            randomArr[i] = randomArr[j];
            randomArr[j] = temp;
        }
        return randomArr;
    },

    getWinWord: function(arr) {
        const randomIndex = Math.floor(Math.random() * arr.length);
        return arr[randomIndex];
    }
});