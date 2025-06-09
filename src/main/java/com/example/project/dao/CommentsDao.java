package com.example.project.dao;

import java.util.List;

import javax.xml.stream.events.Comment;

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
			     	, comment = #{comment}
			""")
	public void writeComment(String comment, String relTypeCode, int loginedMemberId, int relId);
	
	@Select("""
			SELECT c.*, m.loginId
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
			SELECT c.*, m.loginId
				FROM comments c
			    INNER JOIN `member` m
			    ON c.memberId = m.id
				WHERE c.id = #{id}
			""")
	Comment getCommentById(int id);

	@Delete("""
			DELETE FROM comments
				WHERE id = #{id}
			""")
	public void deleteComment(int id);
	
	@Update("""
			UPDATE comments
				SET updateDate = NOW()
					, comment = #{comment}
					WHERE id = #{id}
			""")
	public void modifyComment(int id, String comment);
	
	@Select("""
			SELECT *
				FROM comments
				WHERE memberId = #{id}
				AND relTypeCode = #{relTypeCode}
				AND relId = #{relId}
			""")
	public Comment getComment(int id, String relTypeCode, int relId);

	@Select("""
			SELECT COUNT(*)
				FROM comments
				WHERE relTypeCode = #{relTypeCode}
				AND relId = #{relId}
			""")
	public int getCommentsCnt(String relTypeCode, int relId);
	
}
