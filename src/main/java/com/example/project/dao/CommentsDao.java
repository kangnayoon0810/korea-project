package com.example.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.project.dto.Comments;

@Mapper
public interface CommentsDao {
	
	@Insert("""
			INSERT INTO comments
			 	SET regDate = NOW()
			     	, updateDate = NOW()
			     	, memberId = #{loginedMemberId}
			     	, relTypeCode = #{relTypeCode}
			     	, relId = #{relId}
			     	, content = #{content}
			""")
	public void writeComment(String relTypeCode, int loginedMemberId, int relId, String content);
	
	@Select("""
			SELECT c.*, m.nickName
			FROM comments c
			INNER JOIN `member` m
			ON c.memberId = m.id
			WHERE c.relId = #{relId}
			AND c.relTypeCode = #{relTypeCode}
			""")
	public List<Comments> getComments(int relId, String relTypeCode);
	
	@Select("""
			SELECT LAST_INSERT_ID()
			""")
	int getLastInsertCommentId();
	
	@Select("""
			SELECT c.*, m.nickName
				FROM comments c
			    INNER JOIN `member` m
			    ON c.memberId = m.id
				WHERE c.id = #{id}
			""")
	Comments getCommentById(int id);

	@Delete("""
			DELETE FROM comments
				WHERE id = #{id}
			""")
	public void deleteComment(int id);
	
	@Update("""
			UPDATE comments
				SET updateDate = NOW()
					, content = #{content}
					WHERE id = #{id}
			""")
	public void modifyComment(int id, String content);
	
}
