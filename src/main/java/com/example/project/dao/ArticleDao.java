package com.example.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.project.dto.Article;

@Mapper
public interface ArticleDao {

	@Insert("""
			INSERT INTO article
			    SET regDate = NOW()
			        , boardId = #{boardId}
			        , updateDate = NOW()
			        , memberId = #{loginedMemberId}
			        , content = #{content}
			        , memberCategory = #{memberCategory}
			""")
	public void writeArticle(String content, int loginedMemberId, int boardId, int memberCategory);

	@Select("""
			SELECT a.*, m.nickName, COUNT(c.id) `commentCnt`
			    FROM article a
			    INNER JOIN `member` m
			    ON a.memberId = m.id
			    LEFT JOIN comments c
			 	ON a.id = c.relId
			 	AND c.relTypeCode = 'article'
			    WHERE boardId = #{boardId}
				AND a.content LIKE CONCAT('%', #{keyWord}, '%')
				GROUP BY a.id
				ORDER BY a.id DESC
				LIMIT #{limitFrom}, #{articlesInPage}
			""")
	public List<Article> getArticles(String keyWord, int boardId, int articlesInPage, int limitFrom);

	@Select("""
			SELECT COUNT(id)
				FROM article
				WHERE boardId = #{boardId}
				AND content LIKE CONCAT('%', #{keyWord}, '%')
			""")
	public int getArticlesCnt(int boardId, String keyWord);
	
	@Select("""
			SELECT a.*, m.nickName, COUNT(c.id) `commentCnt`
			 	FROM article a
			 	INNER JOIN `member` m
			 	ON a.memberId = m.id
			 	LEFT JOIN comments c
			 	ON a.id = c.relId
			 	AND c.relTypeCode = 'article'
			 	WHERE a.id = #{id}
			""")
	public Article getArticleById(int id);
	
	@Update("""
			UPDATE article
			    SET updateDate = NOW()
			        , content = #{content}
			    WHERE id = #{id}
			""")
	public void modifyArticle(int id, String content);

	@Delete("""
			DELETE FROM article
				WHERE id = #{id}
			""")
	public void deleteArticle(int id);

	@Select("""
			SELECT LAST_INSERT_ID()
			""")
	public int getLastArticleId();

	@Update("""
			UPDATE article
				SET viewCnt = viewCnt + 1
				WHERE id = #{id}
			""")
	public void increaseViewCnt(int id);
	
	@Select("""
			SELECT *
				FROM article
				WHERE memberCategory = #{memberCategory}
			""")
	public Article getArticleByMemberCategory(int memberCategory);


}