(function(){
    const toTopButton = document.querySelector(".to-top");
    const appDiv = document.querySelector("#app");
    const div = document.querySelector("main > .looking .right >.top");
    appDiv.addEventListener("scroll",function(){
        const scrollTop = appDiv.scrollTop;
        if(scrollTop>500){
            toTopButton.removeAttribute("hidden");
            if(div && !div.classList.contains("fixed") && !div.classList.contains("bottom-absolute")){
                //添加addClass("fixed");
                div.classList.add("fixed");
            }
        }else{
            toTopButton.setAttribute("hidden",'');
            if(div && div.classList.contains("fixed")){
                //删除removeClass("fixed");
                div.classList.remove("fixed");
            }
        }
    })
    const footer = document.querySelector("footer");
    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            if(div && !div.classList.contains("bottom-absolute")){
                div.classList.add("bottom-absolute");
                div.classList.remove("fixed");
            }
            // 在这里执行您的操作，例如显示图片、加载数据等
          } else {
            // 在这里执行您的操作，例如隐藏图片等
            if(div && div.classList.contains("bottom-absolute")){
                div.classList.remove("bottom-absolute");
                div.classList.add("fixed");
            }
          }
        });
      });
    observer.observe(footer);
    toTopButton.addEventListener("click",function(){
        appDiv.scrollTo({
            top:0,
            behavior:"smooth"
        })
    })
})()