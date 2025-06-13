package com.example.project.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.project.dto.TrainerInfo;

@Mapper
public interface TrainerInfoDao {

	@Select("""
			SELECT *
			 	FROM trainer_info
			 	WHERE memberId = #{id}
			""")
	TrainerInfo getTrainerInfoByProfileId(int id);

	
}