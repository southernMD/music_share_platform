document.addEventListener('DOMContentLoaded', function() {
  // const contentDiv = document.getElementById('content');
  const paginationDiv = document.getElementById('pagination');
  const prevLink = paginationDiv.querySelector('.prev');
  const nextLink = paginationDiv.querySelector('.next');
  // 示例数据
  // const items = Array.from({length: 300}, (_, i) => `Item ${i + 1}`);
  const itemsPerPage = +document.querySelector(".pagination_message").children[0].innerText;
  const totalPages = +document.querySelector(".pagination_message").children[1].innerText;
  //从url地址后的?currentPage=1获取currentPage
  let currentPage = +(new URLSearchParams(window.location.search).get('currentPage') ?? 1);
  console.log(currentPage);
  const baseUrl = document.querySelector(".pagination_message .url").innerHTML.trim();
  function showPage(page) {
    if (page < 1 || page > totalPages) return;

    const start = (page - 1) * itemsPerPage;
    const end = start + itemsPerPage;
    
    // contentDiv.innerHTML = items.slice(start, end).join('<br>');
    Array.from(paginationDiv.querySelectorAll('a')).forEach((link, index) => {
      if (index === 0 || index === paginationDiv.children.length - 1) return; // 跳过上一页和下一页按钮
      link.classList.toggle('active', link.innerText == page);
    });
    // 更新上一页和下一页按钮的状态
    // document.querySelector('.prev').disabled = page === 1;
    // document.querySelector('.next').disabled = page === totalPages;
  }
  let flag = true;
  function createPagination() {
    for (let i = 1; i <= totalPages; i++) {
      const link = document.createElement('a');
      link.href = `${baseUrl}currentPage=${i}`;
      link.textContent = i;
      link.onclick = function() {
        window.location.href = link.href;
        currentPage = +link.innerHTML;
        if(totalPages > 10){
          if(currentPage - 1 > 0 && currentPage  <=  +paginationDiv.querySelectorAll('a')[4].innerHTML)rebuildList(-1);
          if(currentPage + 1 < totalPages && currentPage >= paginationDiv.querySelectorAll('a')[7].innerHTML)rebuildList(1);
        }
        showPage(currentPage);
        return false;
      };
      if(i<=9){
        paginationDiv.insertBefore(link, paginationDiv.children[paginationDiv.children.length - 1]);
      }else{
        if(totalPages>10){
          //生成插入...
          const ellipsisEnd = document.createElement('span');
          ellipsisEnd.textContent = '...'
          paginationDiv.insertBefore(ellipsisEnd, paginationDiv.children[paginationDiv.children.length - 1]);
          const LastLink = document.createElement('a');
          LastLink.href = `${baseUrl}currentPage=${totalPages}`;
          LastLink.textContent = totalPages;
          LastLink.onclick = function() {
            window.location.href = LastLink.href;
            currentPage = totalPages;
            showPage(totalPages);
            if(paginationDiv.querySelector('span')){
              const ellipsisEnd = paginationDiv.querySelector('span');
              ellipsisEnd.remove();
              Array.from(paginationDiv.querySelectorAll('a')).forEach((link,index)=>{
                if (!(index === 0 || index === paginationDiv.children.length - 1 || index === paginationDiv.children.length - 2)){
                  link.innerText = totalPages - 10 + index;
                }
              })
            }
            return false;
          };
          paginationDiv.insertBefore(LastLink, paginationDiv.children[paginationDiv.children.length - 1]);
          break;
        }else if(totalPages==10){
          paginationDiv.insertBefore(link, paginationDiv.children[paginationDiv.children.length - 1]);
        }
      }
    }
  }

  function changePage(delta) {
    currentPage += delta;
    if(currentPage<1)currentPage=1;
    if(currentPage>totalPages)currentPage=totalPages;
    showPage(currentPage);
  }
  function rebuildList (step){
    if(totalPages>10 && paginationDiv.querySelector('span')){
      let sum = 0;
      let val = 0;
      let flag = false;
      Array.from(paginationDiv.querySelectorAll('a')).forEach((link,index)=>{
        if (index === 0 || index === paginationDiv.children.length - 2 || index === paginationDiv.children.length - 3) return; 
        val = parseInt(link.innerText) + step;
        if(val<=0)flag = true;
      })
      if(flag)return;
      Array.from(paginationDiv.querySelectorAll('a')).forEach((link,index)=>{
        if (index === 0 || index === paginationDiv.children.length - 2 || index === paginationDiv.children.length - 3) return; 
        val = parseInt(link.innerText) + step;
        sum+=val;
        link.innerText = val+'';
      })
      if(sum+totalPages == sum+val+1){
        const ellipsisEnd = paginationDiv.querySelector('span');
        ellipsisEnd.remove();
      }
    }
    if(!paginationDiv.querySelector('span') && totalPages>10 && currentPage == paginationDiv.querySelectorAll('a')[1].innerText){
      const ellipsisEnd = document.createElement('span');
      ellipsisEnd.textContent = '...'
      paginationDiv.insertBefore(ellipsisEnd, paginationDiv.children[paginationDiv.children.length - 2]);
      Array.from(paginationDiv.querySelectorAll('a')).forEach((link,index)=>{
        if (index === 0 || index === paginationDiv.children.length - 2 || index === paginationDiv.children.length - 3) return; 
        let val = parseInt(link.innerText) + step;
        link.innerText = val+'';
      })
    }
  }
  prevLink.addEventListener("click",()=>{
    if(currentPage == 1)return;
    window.location.href = `${baseUrl}currentPage=${currentPage - 1}`;
    if(currentPage % 10 >7 || currentPage / 10 >= 1 || paginationDiv.querySelectorAll('a')[1].innerText == currentPage && currentPage != 1)rebuildList(-1);
    changePage(-1);
  })
  nextLink.addEventListener("click",()=>{
    if(currentPage == totalPages) return;
      window.location.href = `${baseUrl}currentPage=${currentPage + 1}`;
    if(currentPage % 10 >4 || currentPage / 10 >= 1 )rebuildList(1);
    changePage(1);
  })

  createPagination();
  showPage(currentPage);
});