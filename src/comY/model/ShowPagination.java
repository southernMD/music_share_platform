package comY.model;

import comY.Config;

public class ShowPagination {
    private int totalPage;
    private int currentPage;
    private final int pageSize = Integer.parseInt(Config.PageSize.getValue());
    //get set
    public int getTotalPage() {
        return totalPage;
    }
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getCurrentPage() {
        return currentPage;
    }
    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
    public int getPageSize() {
        return pageSize;
    }
}
