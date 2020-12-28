package com.zdrv.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.zdrv.domain.Member;

@Mapper
public interface MemberDao {

	List<Member> selectAll() throws Exception;
	void insert(Member member) throws Exception;
}
