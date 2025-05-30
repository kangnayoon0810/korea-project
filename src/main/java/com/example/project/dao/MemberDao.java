package com.example.project.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.example.project.dto.Member;

public interface MemberDao {
	
	@Insert("""
			INSERT INTO `member`
			 	SET regDate = NOW()
			     	, updateDate = NOW()
			     	, `name` = #{name}
			     	, nickName = #{nickName}
			     	, phoneNumber = #{phoneNumber}
			     	, loginId = #{loginId}
			     	, loginPw = #{loginPw}
			     	, eMail = #{eMail}
			""")
	void signupMember(String name, String nickName, int phoneNumber, String loginId, String loginPw, String eMail);
	
	@Select("""
			SELECT *
				FROM `member`
				WHERE loginId = #{loginId}
			""")
	Member getMemberByLoginId(String loginId);
	
	@Select("""
			SELECT *
				FROM `member`
				WHERE nickName = #{nickName}
			""")
	Member getMemberByNickName(String nickName);
	
	@Select("""
			SELECT *
				FROM `member`
				WHERE loginId = #{loginId}
				AND loginPw = #{loginPw}
			""")
	Member loginedMemberId(String loginId, String loginPw);


}
