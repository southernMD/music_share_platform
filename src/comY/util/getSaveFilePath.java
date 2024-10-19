package comY.util;

import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

public class getSaveFilePath {
    //这个函数是用来保存文件返回文件名
    public static String getPath(Part part,String path) throws IOException {
        int t_index = part.getSubmittedFileName().lastIndexOf('.');
        String suffix = part.getSubmittedFileName().substring(t_index);
        String fileName = System.currentTimeMillis() + suffix;
        String full_path = path + "files" + "\\" + fileName;
        //判断文件夹是否存在
        File file = new File(path + "files");
        if (!file.exists()) {
            file.mkdir();
        }
        part.write(full_path);
        return fileName;
    }

    //这个函数是用来返回文件路径的
    public static String saveFile(Part part, String path, String defaultFilePath) throws Exception{
        try {
            System.out.println("part_size:"+part.getSize());
            if(part.getSize()==0){
                throw new Exception(defaultFilePath);
            }else{
                return "/files/" + getSaveFilePath.getPath(part,path);
            }
        }catch (Exception e){
            System.out.print(e);
            return defaultFilePath;
        }
    }
}
