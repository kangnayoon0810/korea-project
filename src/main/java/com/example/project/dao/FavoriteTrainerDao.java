package com.example.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.project.dto.Member;

@Mapper
public interface FavoriteTrainerDao {
    
	@Select("""
			SELECT COUNT(*) > 0
			 	FROM favorite_trainer
			 	WHERE memberId = #{memberId}
			   	AND trainerId = #{trainerId}
			""")
    boolean isFavorited(int memberId, int trainerId);
    
	@Insert("""
			INSERT INTO favorite_trainer (regDate, memberId, trainerId)
			VALUES (NOW(), #{memberId}, #{trainerId})
			""")
    void insert(int memberId,int trainerId);
    
	@Delete("""
			DELETE FROM favorite_trainer
			 	WHERE memberId = #{memberId}
			   	AND trainerId = #{trainerId}
			""")
    void delete(int memberId,int trainerId);

	@Select("""
			SELECT m.id, m.nickName, m.eMail, p.id AS profileId
				FROM favorite_trainer ft
				INNER JOIN member m 
				ON ft.trainerId = m.id
				LEFT JOIN profile p
				ON p.memberId = m.id
				WHERE ft.memberId = #{memberId}
			""")
	List<Member> getFavoriteTrainers(int memberId);
}
