package bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;

@ToString
@Getter
@Setter
public class Room implements Serializable {
    private Integer id;
    private String name;
    private String address;
}
