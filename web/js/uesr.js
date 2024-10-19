(function(){
    const user_img = document.querySelector("#user-img-button");
    const user_input = document.querySelector('#user-img-input');
    const edit_btn = document.querySelector("#edit-btn");
    //取消按钮
    const cancel_btn = document.querySelector("#cancel-btn");
    //保存按钮
    const save_btn = document.querySelector("#save-btn");
    let orginal_img_url = document.querySelector("#user-img").src;
    user_img.addEventListener('click',(e)=>{
        e.preventDefault();
        user_input.click();
    })
    user_input.addEventListener("change",(e)=>{
        const file = e.target.files[0];
        if(file){
            const reader = new FileReader();
            reader.onload = function(){
                console.log(reader.result);
                const img = document.querySelector("#user-img");
                img.src = reader.result;
            }
            reader.readAsDataURL(file);
        }
    })
    const input_name = document.querySelector("#input-user-name");
    const input_des = document.querySelector("#input-user-des");
    const name = document.querySelector("#name");
    const des = document.querySelector("#des");
    edit_btn.addEventListener("click",(e)=>{
        e.preventDefault();
        edit_btn.setAttribute("hidden","");
        cancel_btn.removeAttribute("hidden");
        save_btn.removeAttribute("hidden");
        user_img.removeAttribute("hidden");
        input_name.removeAttribute("hidden");
        input_des.removeAttribute("hidden");
        name.setAttribute("hidden","");
        des.setAttribute("hidden","");

    })
    cancel_btn.addEventListener("click",(e)=>{
        e.preventDefault();
        edit_btn.removeAttribute("hidden");
        cancel_btn.setAttribute("hidden","");
        save_btn.setAttribute("hidden","");
        user_img.setAttribute("hidden","")
        document.querySelector("#user-img").src = orginal_img_url
        input_name.setAttribute("hidden","");
        input_des.setAttribute("hidden","");
        name.removeAttribute("hidden");
        des.removeAttribute("hidden");
    })
    const ul_music = document.querySelector("#published-music-ul");
    const song_lis = ul_music.querySelectorAll("li");
    for(let i=0;i<song_lis.length - 1;i++){
        const li_edit_btn = song_lis[i].querySelector('.li-edit-btn');
        li_edit_btn.addEventListener("click",(e)=>{
            e.preventDefault();
            //所有兄弟
            const siblings = [...li_edit_btn.parentNode.children];
            const textareas = song_lis[i].querySelectorAll('textarea');
            const inputs = song_lis[i].querySelectorAll("input[type='text']");
            const song_img = song_lis[i].querySelector('.song_img');
            //选择li下type为file的input
            const song_img_input = song_lis[i].querySelector("input[type='file']");
            // song_img.
            //设置song_img css
            song_img.style.cursor = "pointer"
            song_img.addEventListener('click',()=>{
                song_img_input.click()
            })
            song_img_input.addEventListener("change",(e)=>{
                const file = e.target.files[0];
                if(file){
                    const reader = new FileReader();
                    reader.onload = function(){
                        song_img.src = reader.result;
                    }
                    reader.readAsDataURL(file);
                }
            })
            textareas.forEach((item)=>{
                item.removeAttribute("hidden");
                item.nextElementSibling.setAttribute("hidden","");
            })
            inputs.forEach((item)=>{
                item.removeAttribute("hidden");
                item.previousElementSibling.setAttribute("hidden","");
            })
            siblings.forEach((item)=>{
                if(item != li_edit_btn){
                    item.removeAttribute("hidden");
                }else{
                    item.setAttribute("hidden","");
                }
            })
        })
        const cancel_btn = song_lis[i].querySelector(".li-cancel-btn");
        cancel_btn.addEventListener('click',(e)=>{
            //刷新
            location.reload();
        })
    }
    const add_music_img_div = ul_music.querySelector(".song_img_div");
    const cancel_add_button = ul_music.querySelector(".cancel-add-button");
    cancel_add_button.addEventListener("click",(e)=>{
        e.preventDefault();
        add_music_img_div.removeAttribute("hidden")
        add_music_img_div.nextElementSibling.setAttribute("hidden","");
    })
    add_music_img_div.addEventListener("click",()=>{
        add_music_img_div.setAttribute("hidden","")
        add_music_img_div.nextElementSibling.removeAttribute("hidden");
    })
    const song_add_img = ul_music.querySelector(".song_add_img");
    const song_add_img_input = song_add_img.previousElementSibling
    song_add_img.addEventListener("click",()=>{
        song_add_img_input.click();
    })
    song_add_img_input.addEventListener("change",(e)=>{
        const file = e.target.files[0];
        if(file){
            const reader = new FileReader();
            reader.onload = function(){
                song_add_img.src = reader.result;
            }
            reader.readAsDataURL(file);
        }
    })
    const ul_topcis = document.querySelector("#topics-ul");
    const topics_lis = ul_topcis.querySelectorAll("li");
    for(let i=0;i<topics_lis.length - 1;i++){
        const li = topics_lis[i];
        const edit_btn = li.querySelector(".li-edit-btn");
        edit_btn.addEventListener("click",(e)=>{
            e.preventDefault();
            const siblings = [...edit_btn.parentNode.children];
            siblings.forEach((item)=>{
                if(item != edit_btn){
                    item.removeAttribute("hidden");
                }else{
                    item.setAttribute("hidden","");
                }
            })
            const cancel_btn = li.querySelector(".li-cancel-btn");
            cancel_btn.addEventListener('click',(e)=>{
                //刷新
                location.reload();
            })
            const topic_details = li.querySelector(".topic-details");
            const input_title = topic_details.querySelector("input");
            const input_content = topic_details.querySelector("textarea");
            input_title.removeAttribute("hidden");
            input_content.removeAttribute("hidden");
            input_title.previousElementSibling.setAttribute("hidden","");
            input_content.previousElementSibling.setAttribute("hidden","");
            const topic_img = li.querySelector("img");
            const topic_img_input = li.querySelector("input[type='file']")
            topic_img.style.cursor = "pointer"
            topic_img.addEventListener('click',()=>{
                topic_img_input.click()
            })
            topic_img_input.addEventListener("change",(e)=>{
                const file = e.target.files[0];
                if(file){
                    const reader = new FileReader();
                    reader.onload = function(){
                        topic_img.src = reader.result;
                    }
                    reader.readAsDataURL(file);
                }
            })
        })
    }
    const add_topic_img_div = ul_topcis.querySelector(".topic_img_div");
    const cancel_add_topic_button = ul_topcis.querySelector(".cancel-add-topic-button");
    cancel_add_topic_button.addEventListener("click",(e)=>{
        e.preventDefault();
        add_topic_img_div.removeAttribute("hidden")
        add_topic_img_div.nextElementSibling.setAttribute("hidden","");
    })
    add_topic_img_div.addEventListener("click",()=>{
        add_topic_img_div.setAttribute("hidden","")
        add_topic_img_div.nextElementSibling.removeAttribute("hidden");
    })
    const topics_add_img = ul_topcis.querySelector(".topics_add_img");
    const topics_add_img_input = topics_add_img.previousElementSibling
    topics_add_img.addEventListener("click",()=>{
        topics_add_img_input.click();
    })
    topics_add_img_input.addEventListener("change",(e)=>{
        const file = e.target.files[0];
        if(file){
            const reader = new FileReader();
            reader.onload = function(){
                topics_add_img.src = reader.result;
            }
            reader.readAsDataURL(file);
        }
    })
})()