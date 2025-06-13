package com.example.project.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.project.dto.Profile;

@Mapper
public interface ProfileDao {

	@Select("""
			SELECT *
			   FROM `profile`
			   WHERE memberId = #{id}
			""")
	Profile getProfileByMemberId(int id);

	@Insert("""
			INSERT INTO profile
				  SET memberId = #{memberId}
				  		, profileImageId = #{profileImageId}
				  		, intro = ''
				  		, address = ''
				  		, tag = ''
			""")
	void insertDefaultProfile(Profile profile);

}