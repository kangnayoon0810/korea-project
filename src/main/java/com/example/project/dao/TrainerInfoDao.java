package com.example.project.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.project.dto.TrainerInfo;

@Mapper
public interface TrainerInfoDao {

	@Select("""
			SELECT *
			 	FROM trainer_info
			 	WHERE memberId = #{id}
			""")
	TrainerInfo getTrainerInfoByProfileId(int id);

	@Insert("""
			INSERT INTO trainer_info
			 	SET memberId = #{memberId}
				 	, gymName = ''
				 	, career = ''
				 	, license = ''
				 	, availableRegion = ''
			""")
	void insertDefaultInfo(int memberId);

	@Update("""
			UPDATE trainer_info
			 	SET gymName = #{gymName}
			 		, career = #{career}
			 		, license = #{license}
			 		, availableRegion = #{availableRegion}
			 	WHERE memberId = #{memberId}
			""")
	void modifyInfo(int memberId, String gymName, String career, String license, String availableRegion);

	
}