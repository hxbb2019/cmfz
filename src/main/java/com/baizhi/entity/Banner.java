package com.baizhi.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Id;
import java.util.Date;
@Data
@NoArgsConstructor
@Accessors(chain = true)
public class Banner {
    @Id
    private String id;
    private String name;
    private String cover;
    private String description;
    private String status;

    @JSONField(format = "yyyy-MM-dd")  //序列化
    @DateTimeFormat(pattern = "yyyy-MM-dd")   //反序列化
    private Date createDate;
}
