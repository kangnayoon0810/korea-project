package com.example.project.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.project.dto.Trainer;

@Mapper
public interface TrainerDao {

	@Insert("""
			INSERT INTO trainer
			 	SET regDate = NOW()
			     	, updateDate = NOW()
			     	, `name` = #{name}
			     	, sex = #{sex}
			     	, phoneNumber = #{phoneNumber}
			     	, loginId = #{loginId}
			     	, loginPw = #{loginPw}
			     	, eMail = #{eMail}
			""")
	void signupTrainer(String name, int sex, int phoneNumber, String loginId, String loginPw, String eMail);

	@Select("""
			SELECT *
				FROM trainer
				WHERE phoneNumber = #{phoneNumber}
			""")
	Trainer getTrainerByPhoneNumber(int phoneNumber);

	@Select("""
			SELECT *
				FROM trainer
				WHERE loginId = #{loginId}
			""")
	Trainer getTrainerByLoginId(String loginId);

	@Select("""
			SELECT *
				FROM trainer
				WHERE eMail = #{eMail}
			""")
	Trainer getTrainerByEMail(String eMail);

	@Select("""
			SELECT *
				FROM trainer
				WHERE loginId = #{loginId}
				AND loginPw = #{loginPw}
			""")
	Trainer loginedTrainerId(String loginId, String loginPw);

}