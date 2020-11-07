package bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;

@ToString
@Getter
@Setter
public class College implements Serializable {
    private static final long serialVersionUID = 1L;
    private Room room;
    private Integer id;
    private String name;
}
