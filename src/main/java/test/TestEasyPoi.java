package test;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import org.apache.poi.ss.usermodel.Workbook;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TestEasyPoi {
    public static void main(String[] args) throws IOException {
        List<User> list = new ArrayList<>();
        for (int i = 1;i<11;i++){
            User user = new User();
            user.setId(i+"");
            user.setName("张三"+i);
            user.setBir(new Date());
            user.setPhoto("C:/ldh.jpg");
            list.add(user);
        }


        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams("计算机一班学生","学生"),
                User .class, list);
        workbook.write(new FileOutputStream(new File("C:/Users/Administrator.PC-20160225UPJV/Desktop/后期项目/day7/user.xls")));
    }
}
