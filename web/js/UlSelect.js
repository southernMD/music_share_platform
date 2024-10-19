(function(){
    const ul = document.querySelector("ul");
    const lis  = ul.children;
    for(let i=0;i<lis.length;i++){
        lis[i].onclick = function(){
            for(let j=0;j<lis.length;j++){
                lis[j].className = "";
            }
            this.className = "active";
            this.children[0].click();
        }
    }
})()