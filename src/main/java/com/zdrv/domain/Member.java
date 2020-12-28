package com.zdrv.domain;

import java.util.Date;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class Member {

	private Integer id;

	@NotBlank
	private String name;

	@Min(0)
	private Integer age;

	private String address;
	private Integer typeId;
	private String typeName;
	private Date created;

}
