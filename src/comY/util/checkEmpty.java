package comY.util;

import java.util.ArrayList;
import java.util.List;

public class checkEmpty {
    public static void emptyList(String... args){
        List<String> list = new ArrayList<>();
        for (String arg : args){
            if ( arg == null || arg.isEmpty() ){
                list.add(arg + "不能为空");
            }
        }
        if(!list.isEmpty()){
            throw new RuntimeException(list.toString());
        }
    }

    public static void emptyListCanBeEmpty(String... args){
        List<String> list = new ArrayList<>();
        for (String arg : args){
            if ( arg == null){
                list.add(arg + "不能为空");
            }
        }
        if(!list.isEmpty()){
            throw new RuntimeException(list.toString());
        }
    }
}
