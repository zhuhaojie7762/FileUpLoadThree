package bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;

@ToString
@Getter
@Setter
public class Hotel implements Serializable {

    private static final long serialVersionUID = 1L;


    private Integer id;
    private String name;
    private String address;




}
