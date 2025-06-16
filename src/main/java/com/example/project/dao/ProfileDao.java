package com.example.project.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.project.dto.ProfileDto;

@Mapper
public interface ProfileDao {

	@Select("""
			SELECT *
			   FROM `profile`
			   WHERE memberId = #{id}
			""")
	ProfileDto getProfileByMemberId(int id);

	@Update("""
			UPDATE `profile`
			 	SET profileImagePath = #{profileImagePath}
			    WHERE memberId =  #{memberId}
			""")
	void updateProfileImg(String profileImagePath, int memberId);

	@Select("""
			SELECT *
				FROM profile
				WHERE id = #{id}
			""")
	ProfileDto getProfileById(int id);

}