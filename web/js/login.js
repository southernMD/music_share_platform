(()=>{
    const goLogin = document.querySelector("#goLogin");
    const goReg = document.querySelector("#goReg");
    const mask = document.querySelector("#mask");
    const maskStateLeft = document.querySelectorAll(".maskState-left");
    const maskStateRight = document.querySelectorAll(".maskState-right");
    console.log(goLogin,goReg,mask,maskStateLeft,maskStateRight);
    // url参数

    goLogin.addEventListener("click",()=>{
        console.log('goLogin');
        mask.classList.add("nav-click");
        maskStateRight.forEach(item=>item.setAttribute("hidden",''))
        maskStateLeft.forEach(item=>item.removeAttribute("hidden"))
    })
    goReg.addEventListener("click",()=>{
        console.log('goReg');
        mask.classList.remove("nav-click");
        maskStateLeft.forEach(item=>item.setAttribute("hidden",''))
        maskStateRight.forEach(item=>item.removeAttribute("hidden"))
    })    
    const urlParams = new URLSearchParams(location.search);
    const way = urlParams.get("way");
    if(way == "login"){
        goLogin.click()
    }else{
        goReg.click()
    }

})()