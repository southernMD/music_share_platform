(function(){
    const ul = document.querySelector("main .looking .left ul");
    const top = document.querySelector("main .looking .left >.top");
    const messageDiv = document.querySelector("main .looking .left .message");
    const changeA = document.querySelector("main .looking .left .top .change >a");
    const lis  = ul?.children;
    const firstOneEleMessageObj = lis?.[0].getBoundingClientRect();
    const first_x = firstOneEleMessageObj?.x;
    const first_y = firstOneEleMessageObj?.y;
    let flag = true; 
    let flag2 = true; 
    top?.addEventListener("mouseleave",()=>{
        messageDiv.setAttribute("hidden","");
        flag = true
        for(let i=0;i<lis.length;i++){
            lis[i].className = "";
            lis[i].style.transform = "translate(0,0)";
        }
    })
    for(let li of lis??[]){
        li.addEventListener("mouseover",function (){
            if(!flag || !flag2)return
            flag = false
            messageDiv.removeAttribute("hidden");
            for(let i=0;i<lis.length;i++){
                lis[i].className = "hide";
            }
            const {x,y} = li.getBoundingClientRect();
            const left = x - first_x;
            const top = y - first_y;
            li.style.transform = `translate(-${left}px,-${top}px) scale(2)`;
            li.className = ""
            console.log(this)
            const scale_message = document.querySelector("#scale_message");
            const title = this.querySelector(".name").innerHTML.split("&nbsp;--&nbsp;")[0];
            const ar = this.querySelector(".name").innerHTML.split("&nbsp;--&nbsp;")[1];
            const lrc = this.querySelector(".lrc").innerHTML;
            const des = this.querySelector(".des").innerHTML;
            scale_message.querySelector(".title").innerHTML = title;
            scale_message.querySelector(".ar").innerHTML = ar;
            scale_message.querySelector(".lrc").innerHTML = lrc;
            scale_message.querySelector(".sign").innerHTML = des;

        })
        li.addEventListener("click",function (){
            //拿到根地址
            window.location.href = `${window.location.origin}/music/detail.jsp?id=${this.getAttribute("data-id")}`;
        })
    }
    changeA?.addEventListener('click',()=>{
        flag2 = true
        messageDiv.setAttribute("hidden","");
        flag = true
        for(let i=0;i<lis.length;i++){
            lis[i].className = "";
            lis[i].style.transform = "translate(0,0)";
        }
    })
})()