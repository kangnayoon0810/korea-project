package com.example.project.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.project.dto.Member;

@Mapper
public interface MemberDao {

	@Insert("""
			INSERT INTO `member`
			 	SET regDate = NOW()
			     	, updateDate = NOW()
			     	, `name` = #{name}
			     	, sex = #{sex}
			     	, nickName = #{nickName}
			     	, phoneNumber = #{phoneNumber}
			     	, loginId = #{loginId}
			     	, loginPw = #{loginPw}
			     	, eMail = #{eMail}
			     	, address = #{address}
			     	, authLevel = #{authLevel}
			""")
	void signupMember(String name, int sex, String nickName, String phoneNumber, String loginId, String loginPw, String eMail, String address, int authLevel);

	@Select("""
			SELECT *
			FROM `member`
			WHERE nickName = #{nickName}
			""")
	Member getMemberByNickName(String nickName);

	@Select("""
			SELECT *
			FROM `member`
			WHERE phoneNumber = #{phoneNumber}
			""")
	Member getMemberByPhoneNumber(String phoneNumber);

	@Select("""
			SELECT *
				FROM `member`
				WHERE loginId = #{loginId}
			""")
	Member getMemberByLoginId(String loginId);

	@Select("""
			SELECT *
				FROM `member`
				WHERE eMail = #{eMail}
			""")
	Member getMemberByEMail(String eMail);

	@Select("""
			SELECT nickName
				FROM `member`
				WHERE id = #{id}
			""")
	String getLoginId(int id);
	
	@Select("""
			SELECT *
				FROM `member`
				WHERE authLevel = #{authLevel}
			""")
	Member getMemberByAuthLevel(int authLevel);

	@Select("""
			SELECT nickName
				FROM `member`
				WHERE nickName = #{nickName}
			""")
	String getNickName(String nickName);

	@Select("""
			SELECT LAST_INSERT_ID()
			""")
	int getLastInsertId();

	@Select("""
			SELECT *
				FROM `member`
				WHERE id = #{id}
			""")
	Member getMemberById(int id);

	@Update("""
			UPDATE `member`
				SET updateDate = NOW()
					, nickName = #{nickName}
					, phoneNumber = #{phoneNumber}
					, eMail = #{eMail}
					, address = #{address}
				WHERE id = #{id}
			""")
	void modifyMember(int id, String nickName, String phoneNumber, String eMail, String address);

	@Update("""
			UPDATE `member`
				SET updateDate = NOW()
					, loginPw = #{loginPw}
				WHERE id = #{id}
			""")
	void modifyPassword(int id, String loginPw);

	@Select("""
			SELECT *
			 	FROM `member`
			 	WHERE authLevel = #{authLevel}
			""")
	Member getTrainerById(int authLevel);


}